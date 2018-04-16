From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Subject: [RFC PATCH v2 4/4] acpi: apei: Warn when GHES marks correctable errors as "fatal"
Date: Mon, 16 Apr 2018 16:59:03 -0500
Message-ID: <20180416215903.7318-5-mr.nuke.me@gmail.com>
References: <20180416215903.7318-1-mr.nuke.me@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180416215903.7318-1-mr.nuke.me@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org
Cc: rjw@rjwysocki.net, lenb@kernel.org, tony.luck@intel.com, bp@alien8.de, tbaicar@codeaurora.org, will.deacon@arm.com, james.morse@arm.com, shiju.jose@huawei.com, zjzhang@codeaurora.org, gengdongjiu@huawei.com, linux-kernel@vger.kernel.org, alex_gagniuc@dellteam.com, austin_bolen@dell.com, shyam_iyer@dell.com, devel@acpica.org, mchehab@kernel.org, robert.moore@intel.com, erik.schmauss@intel.com, Alexandru Gagniuc <mr.nuke.me@gmail.com>
List-Id: linux-acpi@vger.kernel.org

There seems to be a culture amongst BIOS teams to want to crash the
OS when an error can't be handled in firmware. Marking GHES errors as
"fatal" is a very common way to do this.

However, a number of errors reported by GHES may be fatal in the sense
a device or link is lost, but are not fatal to the system. When there
is a disagreement with firmware about the handleability of an error,
print a warning message.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---
 drivers/acpi/apei/ghes.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index e0528da4e8f8..6a117825611d 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -535,13 +535,14 @@ static const struct ghes_handler *get_handler(const guid_t *type)
 static void ghes_do_proc(struct ghes *ghes,
 			 const struct acpi_hest_generic_status *estatus)
 {
-	int sev, sec_sev;
+	int sev, sec_sev, corrected_sev;
 	struct acpi_hest_generic_data *gdata;
 	const struct ghes_handler *handler;
 	guid_t *sec_type;
 	guid_t *fru_id = &NULL_UUID_LE;
 	char *fru_text = "";
 
+	corrected_sev = GHES_SEV_NO;
 	sev = ghes_severity(estatus->error_severity);
 	apei_estatus_for_each_section(estatus, gdata) {
 		sec_type = (guid_t *)gdata->section_type;
@@ -563,6 +564,13 @@ static void ghes_do_proc(struct ghes *ghes,
 					       sec_sev, err,
 					       gdata->error_data_length);
 		}
+
+		corrected_sev = max(corrected_sev, sec_sev);
+	}
+
+	if ((sev >= GHES_SEV_PANIC) && (corrected_sev < sev)) {
+		pr_warn("FIRMWARE BUG: Firmware sent fatal error that we were able to correct");
+		pr_warn("BROKEN FIRMWARE: Complain to your hardware vendor");
 	}
 }
 
-- 
2.14.3
