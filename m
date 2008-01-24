From: Len Brown <lenb@kernel.org>
Subject: [PATCH 2/8] DMI: create dmi_get_slot()
Date: Wed, 23 Jan 2008 21:32:41 -0500
Message-ID: <f89e3b0620a0dc19f313218f55373b9361142203.1201141721.git.len.brown@intel.com>
References: <1201141967-28134-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:21248 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751710AbYAXCdj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Jan 2008 21:33:39 -0500
In-Reply-To: <1201141967-28134-1-git-send-email-lenb@kernel.org>
In-Reply-To: <81b4e1f6269cea345f17d3aa349ec9beb31a8cd3.1201141721.git.len.brown@intel.com>
References: <81b4e1f6269cea345f17d3aa349ec9beb31a8cd3.1201141721.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

This simply allows other sub-systems (such as ACPI)
to access and print out slots in static dmi_ident[].

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/firmware/dmi_scan.c |    8 ++++++++
 include/linux/dmi.h         |    2 ++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/drivers/firmware/dmi_scan.c b/drivers/firmware/dmi_scan.c
index 0cdadea..5e596a7 100644
--- a/drivers/firmware/dmi_scan.c
+++ b/drivers/firmware/dmi_scan.c
@@ -470,3 +470,11 @@ int dmi_get_year(int field)
 	return year;
 }
 
+/**
+ *	dmi_get_slot - return dmi_ident[slot]
+ *	@slot:	index into dmi_ident[]
+ */
+char *dmi_get_slot(int slot)
+{
+	return(dmi_ident[slot]);
+}
diff --git a/include/linux/dmi.h b/include/linux/dmi.h
index b1251b2..5b42a65 100644
--- a/include/linux/dmi.h
+++ b/include/linux/dmi.h
@@ -79,6 +79,7 @@ extern void dmi_scan_machine(void);
 extern int dmi_get_year(int field);
 extern int dmi_name_in_vendors(const char *str);
 extern int dmi_available;
+extern char *dmi_get_slot(int slot);
 
 #else
 
@@ -89,6 +90,7 @@ static inline const struct dmi_device * dmi_find_device(int type, const char *na
 static inline int dmi_get_year(int year) { return 0; }
 static inline int dmi_name_in_vendors(const char *s) { return 0; }
 #define dmi_available 0
+static inline char *dmi_get_slot(int slot) { return NULL; }
 
 #endif
 
-- 
1.5.4.rc4.14.g6fc74

