From: Len Brown <lenb@kernel.org>
Subject: [PATCH 075/112] ACPI: make struct osi_linux static
Date: Thu,  7 Feb 2008 04:34:37 -0500
Message-ID: <1d15d84e8b443971cafd885d18f091814ba32cb7.1202376824.git.len.brown@intel.com>
References: <1202376914-21030-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:18844 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754953AbYBGJgc (ORCPT
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
index 71b0c32..fde7ac8 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -120,7 +120,7 @@ static char osi_additional_string[OSI_STRING_LENGTH_MAX];
  */
 #define OSI_LINUX_ENABLE 0
 
-struct osi_linux {
+static struct osi_linux {
 	unsigned int	enable:1;
 	unsigned int	dmi:1;
 	unsigned int	cmdline:1;
-- 
1.5.4.23.gef5b9

