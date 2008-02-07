From: Len Brown <lenb@kernel.org>
Subject: [PATCH 074/112] ACPI: make acpi_dmi_dump() static
Date: Thu,  7 Feb 2008 04:34:36 -0500
Message-ID: <12d3931c1007a7ad47364a4884e5a6c6e25aa5e1.1202376824.git.len.brown@intel.com>
References: <1202376914-21030-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:9414 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753918AbYBGJgc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Feb 2008 04:36:32 -0500
In-Reply-To: <1202376914-21030-1-git-send-email-lenb@kernel.org>
In-Reply-To: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
References: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Adrian Bunk <bunk@kernel.org>, Len Brown <len.brown@intel.com>

From: Adrian Bunk <bunk@kernel.org>

Signed-off-by: Adrian Bunk <bunk@kernel.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/osl.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 347cda2..71b0c32 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -1213,7 +1213,7 @@ acpi_status acpi_os_release_object(acpi_cache_t * cache, void *object)
  *
  *	Returns 0 on success
  */
-int acpi_dmi_dump(void)
+static int acpi_dmi_dump(void)
 {
 
 	if (!dmi_available)
-- 
1.5.4.23.gef5b9

