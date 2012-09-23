From: Len Brown <lenb@kernel.org>
Subject: [PATCH 21/23] tools/power/acpi/acpidump: version 20071116
Date: Sun, 23 Sep 2012 00:34:09 -0400
Message-ID: <39a55ff2c34a11ab9bbc8ba6f4dfb5d366cb2532.1348371388.git.len.brown@intel.com>
References: <1348374851-20378-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1348374851-20378-1-git-send-email-lenb@kernel.org>
In-Reply-To: <a950c135e5b2be6ef7518d54d98a7901db1b377a.1348371388.git.len.brown@intel.com>
References: <a950c135e5b2be6ef7518d54d98a7901db1b377a.1348371388.git.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Len Brown <len.brown@intel.com>

This is unchanged version 20071116, plus a small bit in
DEFINE_ALTERNATE_TYPES to enable building with latest kernel headers.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/acpi/acpidump.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/power/acpi/acpidump.c b/tools/power/acpi/acpidump.c
index 8e5e194..a63dee9 100644
--- a/tools/power/acpi/acpidump.c
+++ b/tools/power/acpi/acpidump.c
@@ -540,8 +540,11 @@ int main(int argc, char **argv)
 	if (connect) {
 		lseek(fd, sizeof(struct acpi_rsdp_descriptor), SEEK_SET);
 	}
-	if (!acpi_dump_XSDT(fd, &rsdpx))
-		goto not_found;
+	if (rsdpx.revision > 1 && rsdpx.xsdt_physical_address) {
+		/* ACPIDUMP uses xsdt table */
+		if (!acpi_dump_XSDT(fd, &rsdpx))
+			goto not_found;
+	}
 	if (!acpi_dump_RSDT(fd, &rsdpx))
 		goto not_found;
 	if (connect) {
-- 
1.7.12.1.396.g16eed7c
