#!/usr/bin/env bash
# Case Study 01 (NERAD): Orthanc PACS Zero Trust & NIST SP 800-207 Remediation Script
set -euo pipefail

MODALITY_IP="10.0.2.20"
WORKSTATION_IP="10.0.2.30"
ORTHANC_CONF="/etc/orthanc/orthanc.json"

echo "[1/3] Enforcing Orthanc REST API & DICOM authentication..."
if [[ -f "$ORTHANC_CONF" ]]; then
  cp -a "$ORTHANC_CONF" "${ORTHANC_CONF}.bak.$(date +%Y%m%d%H%M%S)"
  sed -i 's/"AuthenticationEnabled"[[:space:]]*:[[:space:]]*false/"AuthenticationEnabled" : true/g' "$ORTHANC_CONF"
  sed -i 's/"DicomCheckCalledAet"[[:space:]]*:[[:space:]]*false/"DicomCheckCalledAet" : true/g' "$ORTHANC_CONF"
  systemctl restart orthanc || true
fi

echo "[2/3] Applying UFW default-deny & source-IP micro-segmentation..."
ufw --force reset
ufw default deny incoming
ufw default allow outgoing
ufw logging low

ufw allow from "$MODALITY_IP" to any port 4242 proto tcp comment "Authorized DICOM Modality"
ufw allow from "$WORKSTATION_IP" to any port 8042 proto tcp comment "Authorized Clinical Viewer REST"
ufw allow from "$WORKSTATION_IP" to any port 22 proto tcp comment "Authorized PACS Admin SSH"

echo "[3/3] Enabling UFW policy enforcement..."
ufw --force enable
ufw status verbose
