From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: [PATCH 2/2] i915: Enable ASLE if present
Date: Wed, 1 Apr 2009 19:53:33 +0100
Message-ID: <20090401185333.GB16067@srcf.ucam.org>
References: <20090401185229.GA16067@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:51012 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761946AbZDASxi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Apr 2009 14:53:38 -0400
Content-Disposition: inline
In-Reply-To: <20090401185229.GA16067@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: intel-gfx@lists.freedesktop.org
Cc: linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>

The changes to opregion initialisation order meant that the ASLE setup
code might not be run at the correct time. Ensure that the interrupts are
set up.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
---
 drivers/gpu/drm/i915/i915_opregion.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_opregion.c b/drivers/gpu/drm/i915/i915_opregion.c
index c63256b..3699a16 100644
--- a/drivers/gpu/drm/i915/i915_opregion.c
+++ b/drivers/gpu/drm/i915/i915_opregion.c
@@ -389,6 +389,7 @@ int intel_opregion_init(struct drm_device *dev, int resume)
 	if (mboxes & MBOX_ASLE) {
 		DRM_DEBUG("ASLE supported\n");
 		opregion->asle = base + OPREGION_ASLE_OFFSET;
+		opregion_enable_asle(dev);
 	}
 
 	/* Notify BIOS we are ready to handle ACPI video ext notifs.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
