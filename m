From: Tony Luck <tony.luck@intel.com>
Subject: [RFC PATCH 2/4] firmware: dmi: Add function to look up a handle and return DIMM size
Date: Thu, 30 Nov 2017 12:40:40 -0800
Message-ID: <2fae02861e5c446c0cdd30ba3e00fad55db97807.1512070562.git.tony.luck@intel.com>
References: <cover.1512070562.git.tony.luck@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:10155 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750923AbdK3Ukn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 30 Nov 2017 15:40:43 -0500
In-Reply-To: <cover.1512070562.git.tony.luck@intel.com>
In-Reply-To: <cover.1512070562.git.tony.luck@intel.com>
References: <cover.1512070562.git.tony.luck@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-edac@vger.kernel.org
Cc: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, Dan Williams <dan.j.williams@intel.com>, Jean Delvare <jdelvare@suse.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-nvdimm@lists.01.org, Lv Zheng <lv.zheng@intel.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>, Aristeu Rozanski <aris@redhat.com>

When we first scan the SMBIOS table, save the size of the DIMM.

Provide a function for other code (EDAC driver) to look up the size
of a DIMM from its SMBIOS handle.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 drivers/firmware/dmi_scan.c | 29 +++++++++++++++++++++++++++++
 include/linux/dmi.h         |  2 ++
 2 files changed, 31 insertions(+)

diff --git a/drivers/firmware/dmi_scan.c b/drivers/firmware/dmi_scan.c
index 783041964439..946e86fb1ec6 100644
--- a/drivers/firmware/dmi_scan.c
+++ b/drivers/firmware/dmi_scan.c
@@ -37,6 +37,7 @@ static char dmi_ids_string[128] __initdata;
 static struct dmi_memdev_info {
 	const char *device;
 	const char *bank;
+	u64 size;
 	u16 handle;
 } *dmi_memdev;
 static int dmi_memdev_nr;
@@ -395,6 +396,8 @@ static void __init save_mem_devices(const struct dmi_header *dm, void *v)
 {
 	const char *d = (const char *)dm;
 	static int nr;
+	u64 bytes;
+	u16 size;
 
 	if (dm->type != DMI_ENTRY_MEM_DEVICE || dm->length < 0x12)
 		return;
@@ -405,6 +408,18 @@ static void __init save_mem_devices(const struct dmi_header *dm, void *v)
 	dmi_memdev[nr].handle = get_unaligned(&dm->handle);
 	dmi_memdev[nr].device = dmi_string(dm, d[0x10]);
 	dmi_memdev[nr].bank = dmi_string(dm, d[0x11]);
+	size = get_unaligned((u16 *)&d[0xC]);
+	if (size == 0)
+		bytes = 0;
+	else if (size == 0xffff)
+		bytes = ~0ul;
+	else if (size & 0x8000)
+		bytes = (u64)(size & 0x7fff) << 10;
+	else if (size != 0x7fff)
+		bytes = (u64)size << 20;
+	else
+		bytes = (u64)get_unaligned((u32 *)&d[0x1C]) << 20;
+	dmi_memdev[nr].size = bytes;
 	nr++;
 }
 
@@ -1073,3 +1088,17 @@ void dmi_memdev_name(u16 handle, const char **bank, const char **device)
 	}
 }
 EXPORT_SYMBOL_GPL(dmi_memdev_name);
+
+u64 dmi_memdev_size(u16 handle)
+{
+	int n;
+
+	if (dmi_memdev) {
+		for (n = 0; n < dmi_memdev_nr; n++) {
+			if (handle == dmi_memdev[n].handle)
+				return dmi_memdev[n].size;
+		}
+	}
+	return ~0ul;
+}
+EXPORT_SYMBOL_GPL(dmi_memdev_size);
diff --git a/include/linux/dmi.h b/include/linux/dmi.h
index 46e151172d95..7f5929123b69 100644
--- a/include/linux/dmi.h
+++ b/include/linux/dmi.h
@@ -113,6 +113,7 @@ extern int dmi_walk(void (*decode)(const struct dmi_header *, void *),
 	void *private_data);
 extern bool dmi_match(enum dmi_field f, const char *str);
 extern void dmi_memdev_name(u16 handle, const char **bank, const char **device);
+extern u64 dmi_memdev_size(u16 handle);
 
 #else
 
@@ -142,6 +143,7 @@ static inline bool dmi_match(enum dmi_field f, const char *str)
 	{ return false; }
 static inline void dmi_memdev_name(u16 handle, const char **bank,
 		const char **device) { }
+static inline u64 dmi_memdev_size(u16 handle) { return ~0ul; }
 static inline const struct dmi_system_id *
 	dmi_first_match(const struct dmi_system_id *list) { return NULL; }
 
-- 
2.14.1

