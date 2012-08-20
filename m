From: alexdeucher@gmail.com
Subject: [PATCH 3/4] drm/radeon: convert radeon vfct code to use acpi_get_table_with_size
Date: Mon, 20 Aug 2012 11:19:52 -0400
Message-ID: <1345475993-23853-3-git-send-email-alexdeucher@gmail.com>
References: <20120817170313.GA11909@srcf.ucam.org>
 <1345475993-23853-1-git-send-email-alexdeucher@gmail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:63516 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757022Ab2HTPUU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 20 Aug 2012 11:20:20 -0400
In-Reply-To: <1345475993-23853-1-git-send-email-alexdeucher@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: airlied@gmail.com, dri-devel@lists.freedesktop.org, equinox@diac24.net
Cc: linux-acpi@vger.kernel.org, Alex Deucher <alexander.deucher@amd.com>, stable@vger.kernel.org

From: Alex Deucher <alexander.deucher@amd.com>

Allows us to verify the table size.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/radeon/radeon_bios.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_bios.c b/drivers/gpu/drm/radeon/radeon_bios.c
index a32232f..ab0b2f7 100644
--- a/drivers/gpu/drm/radeon/radeon_bios.c
+++ b/drivers/gpu/drm/radeon/radeon_bios.c
@@ -482,13 +482,12 @@ static bool radeon_acpi_vfct_bios(struct radeon_device *rdev)
 {
 	bool ret = false;
 	struct acpi_table_header *hdr;
-	/* acpi_get_table_with_size is not exported :( */
-	acpi_size tbl_size = 0x7fffffff;
+	acpi_size tbl_size;
 	UEFI_ACPI_VFCT *vfct;
 	GOP_VBIOS_CONTENT *vbios;
 	VFCT_IMAGE_HEADER *vhdr;
 
-	if (!ACPI_SUCCESS(acpi_get_table("VFCT", 1, &hdr)))
+	if (!ACPI_SUCCESS(acpi_get_table_with_size("VFCT", 1, &hdr, &tbl_size)))
 		return false;
 	if (tbl_size < sizeof(UEFI_ACPI_VFCT)) {
 		DRM_ERROR("ACPI VFCT table present but broken (too short #1)\n");
@@ -525,7 +524,6 @@ static bool radeon_acpi_vfct_bios(struct radeon_device *rdev)
 	ret = !!rdev->bios;
 
 out_unmap:
-	/* uh, no idea what to do here... */
 	return ret;
 }
 #else
-- 
1.7.7.5

