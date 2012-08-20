From: alexdeucher@gmail.com
Subject: [PATCH 2/4] ACPI: export symbol acpi_get_table_with_size
Date: Mon, 20 Aug 2012 11:19:51 -0400
Message-ID: <1345475993-23853-2-git-send-email-alexdeucher@gmail.com>
References: <20120817170313.GA11909@srcf.ucam.org>
 <1345475993-23853-1-git-send-email-alexdeucher@gmail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:52817 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757011Ab2HTPUT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 20 Aug 2012 11:20:19 -0400
In-Reply-To: <1345475993-23853-1-git-send-email-alexdeucher@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: airlied@gmail.com, dri-devel@lists.freedesktop.org, equinox@diac24.net
Cc: linux-acpi@vger.kernel.org, Alex Deucher <alexander.deucher@amd.com>, stable@vger.kernel.org

From: Alex Deucher <alexander.deucher@amd.com>

We need it in the radeon drm module to fetch
and verify the vbios image on UEFI systems.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
---
 drivers/acpi/acpica/tbxface.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/acpica/tbxface.c b/drivers/acpi/acpica/tbxface.c
index ea4c6d5..29e51bc 100644
--- a/drivers/acpi/acpica/tbxface.c
+++ b/drivers/acpi/acpica/tbxface.c
@@ -387,6 +387,7 @@ acpi_get_table_with_size(char *signature,
 
 	return (AE_NOT_FOUND);
 }
+ACPI_EXPORT_SYMBOL(acpi_get_table_with_size)
 
 acpi_status
 acpi_get_table(char *signature,
-- 
1.7.7.5

