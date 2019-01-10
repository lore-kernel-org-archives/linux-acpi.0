From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] APEI / ERST: Switch to use new generic UUID API
Date: Thu, 10 Jan 2019 17:38:55 +0200
Message-ID: <20190110153855.47180-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Kees Cook <keescook@chromium.org>, Anton Vorontsov <anton@enomsg.org>, Colin Cross <ccross@android.com>, Tony Luck <tony.luck@intel.com>, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

There are new types and helpers that are supposed to be used in new code.

As a preparation to get rid of legacy types and API functions do
the conversion here.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/apei/erst.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/acpi/apei/erst.c b/drivers/acpi/apei/erst.c
index 9953e50667ec..389d88e35ffb 100644
--- a/drivers/acpi/apei/erst.c
+++ b/drivers/acpi/apei/erst.c
@@ -938,17 +938,17 @@ static struct pstore_info erst_info = {
 };
 
 #define CPER_CREATOR_PSTORE						\
-	UUID_LE(0x75a574e3, 0x5052, 0x4b29, 0x8a, 0x8e, 0xbe, 0x2c,	\
-		0x64, 0x90, 0xb8, 0x9d)
+	GUID_INIT(0x75a574e3, 0x5052, 0x4b29, 0x8a, 0x8e, 0xbe, 0x2c,	\
+		  0x64, 0x90, 0xb8, 0x9d)
 #define CPER_SECTION_TYPE_DMESG						\
-	UUID_LE(0xc197e04e, 0xd545, 0x4a70, 0x9c, 0x17, 0xa5, 0x54,	\
-		0x94, 0x19, 0xeb, 0x12)
+	GUID_INIT(0xc197e04e, 0xd545, 0x4a70, 0x9c, 0x17, 0xa5, 0x54,	\
+		  0x94, 0x19, 0xeb, 0x12)
 #define CPER_SECTION_TYPE_DMESG_Z					\
-	UUID_LE(0x4f118707, 0x04dd, 0x4055, 0xb5, 0xdd, 0x95, 0x6d,	\
-		0x34, 0xdd, 0xfa, 0xc6)
+	GUID_INIT(0x4f118707, 0x04dd, 0x4055, 0xb5, 0xdd, 0x95, 0x6d,	\
+		  0x34, 0xdd, 0xfa, 0xc6)
 #define CPER_SECTION_TYPE_MCE						\
-	UUID_LE(0xfe08ffbe, 0x95e4, 0x4be7, 0xbc, 0x73, 0x40, 0x96,	\
-		0x04, 0x4a, 0x38, 0xfc)
+	GUID_INIT(0xfe08ffbe, 0x95e4, 0x4be7, 0xbc, 0x73, 0x40, 0x96,	\
+		  0x04, 0x4a, 0x38, 0xfc)
 
 struct cper_pstore_record {
 	struct cper_record_header hdr;
@@ -1012,7 +1012,7 @@ static ssize_t erst_reader(struct pstore_record *record)
 		rc = -EIO;
 		goto out;
 	}
-	if (uuid_le_cmp(rcd->hdr.creator_id, CPER_CREATOR_PSTORE) != 0)
+	if (!guid_equal(&rcd->hdr.creator_id, &CPER_CREATOR_PSTORE))
 		goto skip;
 
 	record->buf = kmalloc(len, GFP_KERNEL);
@@ -1024,15 +1024,12 @@ static ssize_t erst_reader(struct pstore_record *record)
 	record->id = record_id;
 	record->compressed = false;
 	record->ecc_notice_size = 0;
-	if (uuid_le_cmp(rcd->sec_hdr.section_type,
-			CPER_SECTION_TYPE_DMESG_Z) == 0) {
+	if (guid_equal(&rcd->sec_hdr.section_type, &CPER_SECTION_TYPE_DMESG_Z)) {
 		record->type = PSTORE_TYPE_DMESG;
 		record->compressed = true;
-	} else if (uuid_le_cmp(rcd->sec_hdr.section_type,
-			CPER_SECTION_TYPE_DMESG) == 0)
+	} else if (guid_equal(&rcd->sec_hdr.section_type, &CPER_SECTION_TYPE_DMESG))
 		record->type = PSTORE_TYPE_DMESG;
-	else if (uuid_le_cmp(rcd->sec_hdr.section_type,
-			     CPER_SECTION_TYPE_MCE) == 0)
+	else if (guid_equal(&rcd->sec_hdr.section_type, &CPER_SECTION_TYPE_MCE))
 		record->type = PSTORE_TYPE_MCE;
 	else
 		record->type = PSTORE_TYPE_MAX;
-- 
2.20.1
