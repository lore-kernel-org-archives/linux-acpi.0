From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] ACPICA: Log Exceptions and Errors as warning while
 loading extra tables
Date: Tue, 14 Mar 2017 09:56:50 +0100
Message-ID: <9a6d4e50-41e7-28f6-b19d-f5f989da032d@redhat.com>
References: <20170301103653.2296-1-hdegoede@redhat.com>
 <1AE640813FDE7649BE1B193DEA596E886CE446E2@SHSMSX101.ccr.corp.intel.com>
 <0518b7f7-8d08-0071-df54-af19806883ae@redhat.com>
 <1AE640813FDE7649BE1B193DEA596E886CE44EB1@SHSMSX101.ccr.corp.intel.com>
 <606dcada-7c56-89a6-24a0-ac8aaa1d980e@redhat.com>
 <1AE640813FDE7649BE1B193DEA596E886CE49617@SHSMSX101.ccr.corp.intel.com>
 <07925741-3500-8e69-cc78-cd5ec140c7c6@redhat.com>
 <1AE640813FDE7649BE1B193DEA596E886CE49E37@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------AFE44BD3A8AC8149282BAEAF"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:25349 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750841AbdCNI4y (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 14 Mar 2017 04:56:54 -0400
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E886CE49E37@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, "Moore, Robert" <robert.moore@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>

This is a multi-part message in MIME format.
--------------AFE44BD3A8AC8149282BAEAF
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 14-03-17 09:15, Zheng, Lv wrote:
> Hi, Hans
>
>> From: Hans de Goede [mailto:hdegoede@redhat.com]
>> Subject: Re: [PATCH] ACPICA: Log Exceptions and Errors as warning while loading extra tables
>>
>> Hi,
>>
>> On 13-03-17 10:52, Zheng, Lv wrote:
>>> Hi, Hans
>>>
>>> For log level issue, is this fix useful for you?
>>> https://github.com/acpica/acpica/pull/121/commits/a505d3942
>>
>> That fixes reloading already loaded tables, the problem I'm
>> getting errors about its loading a different table with identical
>> contents.
>>
>> I will look into your suggestion to do something similar to
>> AcpiTbInstallStandardTable using AcpiTbCompareTables for the
>> SSDT tables. I will send a new patch when I can make some time
>> to look into this.
>
> I just completed a prototype here:
> https://github.com/acpica/acpica/pull/121
>
> I guess the original "duplicate table check" couldn't cover static SSDTs.
> Actually the duplicate table check should be a sanity check of table load.
> And for table install, we should have a different sanity check like:
> https://github.com/acpica/acpica/pull/121/commits/6e825cae5e5
> I'm not sure if this is what you want.

This checks for having 2 table_descriptors pointing to the same table
(address in memory). But in my case there are 2 identical copies of
the table at 2 different addresses in memory, so this won't work.

After looking at this a bit myself, I think fixing this is actually
quite easy (now that you've pointed me to acpi_tb_install_standard_table()

I've come up with the attached patch to fix this. I will give this a test
spin and then submit it officially (assuming it works).

Regards,

Hans


--------------AFE44BD3A8AC8149282BAEAF
Content-Type: text/x-patch;
 name="0001-ACPICA-Always-check-for-duplicate-tables-in-acpi_tb_.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-ACPICA-Always-check-for-duplicate-tables-in-acpi_tb_.pa";
 filename*1="tch"

>From ded25995e0071c8e48f7e634e50efd9c675dcfce Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Tue, 14 Mar 2017 09:49:03 +0100
Subject: [PATCH v3] ACPICA: Always check for duplicate tables in
 acpi_tb_install_standard_table

Always check for duplicate tables in acpi_tb_install_standard_table,
not just when the reload flag is set.

Some firmware contains duplicate tables in their RSDT or XSDT, leading
to a bunch of errors being printed on Linux boot.

This commit moves the check for duplicate tables in
acpi_tb_install_standard_table out of the if (reload) {} block,
to catch this and ignore the duplicate tables.

Note for reviewers: all this does is move the check outside of the
if (reload) {} block, no other changes are made.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/acpica/tbinstal.c | 86 +++++++++++++++++++++---------------------
 1 file changed, 43 insertions(+), 43 deletions(-)

diff --git a/drivers/acpi/acpica/tbinstal.c b/drivers/acpi/acpica/tbinstal.c
index 4620f3c..8622a73 100644
--- a/drivers/acpi/acpica/tbinstal.c
+++ b/drivers/acpi/acpica/tbinstal.c
@@ -250,54 +250,54 @@ acpi_tb_install_standard_table(acpi_physical_address address,
 			status = AE_BAD_SIGNATURE;
 			goto unlock_and_exit;
 		}
+	}
 
-		/* Check if table is already registered */
+	/* Check if table is already registered */
 
-		for (i = 0; i < acpi_gbl_root_table_list.current_table_count;
-		     ++i) {
-			/*
-			 * Check for a table match on the entire table length,
-			 * not just the header.
-			 */
-			if (!acpi_tb_compare_tables(&new_table_desc, i)) {
-				continue;
-			}
+	for (i = 0; i < acpi_gbl_root_table_list.current_table_count;
+	     ++i) {
+		/*
+		 * Check for a table match on the entire table length,
+		 * not just the header.
+		 */
+		if (!acpi_tb_compare_tables(&new_table_desc, i)) {
+			continue;
+		}
 
+		/*
+		 * Note: the current mechanism does not unregister a table if it is
+		 * dynamically unloaded. The related namespace entries are deleted,
+		 * but the table remains in the root table list.
+		 *
+		 * The assumption here is that the number of different tables that
+		 * will be loaded is actually small, and there is minimal overhead
+		 * in just keeping the table in case it is needed again.
+		 *
+		 * If this assumption changes in the future (perhaps on large
+		 * machines with many table load/unload operations), tables will
+		 * need to be unregistered when they are unloaded, and slots in the
+		 * root table list should be reused when empty.
+		 */
+		if (acpi_gbl_root_table_list.tables[i].flags &
+		    ACPI_TABLE_IS_LOADED) {
+
+			/* Table is still loaded, this is an error */
+
+			status = AE_ALREADY_EXISTS;
+			goto unlock_and_exit;
+		} else {
 			/*
-			 * Note: the current mechanism does not unregister a table if it is
-			 * dynamically unloaded. The related namespace entries are deleted,
-			 * but the table remains in the root table list.
-			 *
-			 * The assumption here is that the number of different tables that
-			 * will be loaded is actually small, and there is minimal overhead
-			 * in just keeping the table in case it is needed again.
-			 *
-			 * If this assumption changes in the future (perhaps on large
-			 * machines with many table load/unload operations), tables will
-			 * need to be unregistered when they are unloaded, and slots in the
-			 * root table list should be reused when empty.
+			 * Table was unloaded, allow it to be reloaded.
+			 * As we are going to return AE_OK to the caller, we should
+			 * take the responsibility of freeing the input descriptor.
+			 * Refill the input descriptor to ensure
+			 * acpi_tb_install_table_with_override() can be called again to
+			 * indicate the re-installation.
 			 */
-			if (acpi_gbl_root_table_list.tables[i].flags &
-			    ACPI_TABLE_IS_LOADED) {
-
-				/* Table is still loaded, this is an error */
-
-				status = AE_ALREADY_EXISTS;
-				goto unlock_and_exit;
-			} else {
-				/*
-				 * Table was unloaded, allow it to be reloaded.
-				 * As we are going to return AE_OK to the caller, we should
-				 * take the responsibility of freeing the input descriptor.
-				 * Refill the input descriptor to ensure
-				 * acpi_tb_install_table_with_override() can be called again to
-				 * indicate the re-installation.
-				 */
-				acpi_tb_uninstall_table(&new_table_desc);
-				(void)acpi_ut_release_mutex(ACPI_MTX_TABLES);
-				*table_index = i;
-				return_ACPI_STATUS(AE_OK);
-			}
+			acpi_tb_uninstall_table(&new_table_desc);
+			(void)acpi_ut_release_mutex(ACPI_MTX_TABLES);
+			*table_index = i;
+			return_ACPI_STATUS(AE_OK);
 		}
 	}
 
-- 
2.9.3


--------------AFE44BD3A8AC8149282BAEAF--
