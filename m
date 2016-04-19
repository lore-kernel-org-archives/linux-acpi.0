From: Octavian Purdila <octavian.purdila@intel.com>
Subject: Re: [PATCH v2 3/3] ACPI / tables: Convert the initrd table override
 mechanisms to the table upgrade mechanism
Date: Tue, 19 Apr 2016 16:57:32 +0300
Message-ID: <CAE1zotKVO===HEJMv5mjqtT++EE5nycbJBwJvAKmr1oqcv6HNQ@mail.gmail.com>
References: <cover.1460340514.git.lv.zheng@intel.com>
	<b4bd2cb8102b66c034f94abae2969797d004f039.1460340514.git.lv.zheng@intel.com>
	<CAMoF9u2rwWF5ZguMHPti70C=vS33phUGWJGNbH-5ASp5CK58bg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMoF9u2rwWF5ZguMHPti70C=vS33phUGWJGNbH-5ASp5CK58bg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, lkml <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Apr 13, 2016 at 7:01 PM, Octavian Purdila
<octavian.purdila@intel.com> wrote:
> On Mon, Apr 11, 2016 at 5:13 AM, Lv Zheng <lv.zheng@intel.com> wrote:
>>
>> This patch converts the initrd table override mechanism to the table
>> upgrade mechanism by restricting its usage to the tables released with
>> compatibility and more recent revision.
>>
>> This use case has been encouraged by the ACPI specification:
>> 1. OEMID:
>>    An OEM-supplied string that identifies the OEM.
>> 2. OEM Table ID:
>>    An OEM-supplied string that the OEM uses to identify the particular data
>>    table. This field is particularly useful when defining a definition
>>    block to distinguish definition block functions. OEM assigns each
>>    dissimilar table a new OEM Table Id.
>> 3. OEM Revision:
>>    An OEM-supplied revision number. Larger numbers are assumed to be newer
>>    revisions.
>> For OEMs, good practices will ensure consistency when assigning OEMID and
>> OEM Table ID fields in any table. The intent of these fields is to allow
>> for a binary control system that support services can use. Because many
>> support function can be automated, it is useful when a tool can
>> programatically determine which table release is a compatible and more
>> recent revision of a prior table on the same OEMID and OEM Table ID.
>>
>> The facility can now be used by the vendors to upgrade wrong tables for bug
>> fixing purpose, thus lockdep disabling taint is not suitable for it and it
>> should be a default 'y' option to implement the spec encouraged use case.
>>
>
> I agree that we should not force lockdep disabling. I wonder if we
> should add a new taint (like the one I proposed in the overlay patch
> set) to see in bug reports that the ACPI tables have been modified.
>
> Also, do we need a new config option? IMO it would be better if we can
> keep the existing config option and do the following:
>
> * if CONFIG_ACPI_INITRD_TABLE_OVERRIDE is set: allow arbitrary
> overrides (preserve the current behavior)
>
> * if CONFIG_ACPI_INITRD_TABLE_OVERRIDE is not set: allow upgrades
> based on the revision number
>
> * allow adding new tables regardless of CONFIG_ACPI_INITRD_TABLE_OVERRIDE

Here is possible implementation for that (compile tested only):

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 2e74dbf..d72edd6 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -435,14 +435,20 @@ static void __init check_multiple_madt(void)
        return;
 }

-static void acpi_table_taint(struct acpi_table_header *table)
+static void acpi_table_taint(struct acpi_table_header *table, int taint,
+                            const char *action)
 {
-       pr_warn("Override [%4.4s-%8.8s], this is unsafe: tainting kernel\n",
-               table->signature, table->oem_table_id);
-       add_taint(TAINT_OVERRIDDEN_ACPI_TABLE, LOCKDEP_NOW_UNRELIABLE);
+       enum lockdep_ok lockdep = LOCKDEP_STILL_OK;
+
+       pr_info(PREFIX "table %s [%4.4s-%6.6s-%8.8s]\n", action,
+               table->signature, table->oem_id, table->oem_table_id);
+
+       if (taint == TAINT_OVERRIDDEN_ACPI_TABLE)
+               lockdep = LOCKDEP_NOW_UNRELIABLE;
+
+       add_taint(taint, lockdep);
 }

-#ifdef CONFIG_ACPI_INITRD_TABLE_OVERRIDE
 static u64 acpi_tables_addr;
 static int all_tables_size;

@@ -471,9 +477,9 @@ static const char * const table_sigs[] = {

 #define ACPI_HEADER_SIZE sizeof(struct acpi_table_header)

-#define ACPI_OVERRIDE_TABLES 64
-static struct cpio_data __initdata acpi_initrd_files[ACPI_OVERRIDE_TABLES];
-static DECLARE_BITMAP(acpi_initrd_installed, ACPI_OVERRIDE_TABLES);
+#define ACPI_INITRD_TABLES 64
+static struct cpio_data __initdata acpi_initrd_files[ACPI_INITRD_TABLES];
+static DECLARE_BITMAP(acpi_initrd_installed, ACPI_INITRD_TABLES);

 #define MAP_CHUNK_SIZE   (NR_FIX_BTMAPS << PAGE_SHIFT)

@@ -488,7 +494,7 @@ static void __init acpi_table_initrd_init(void
*data, size_t size)
        if (data == NULL || size == 0)
                return;

-       for (no = 0; no < ACPI_OVERRIDE_TABLES; no++) {
+       for (no = 0; no < ACPI_INITRD_TABLES; no++) {
                file = find_cpio_data(cpio_path, data, size, &offset);
                if (!file.data)
                        break;
@@ -497,7 +503,7 @@ static void __init acpi_table_initrd_init(void
*data, size_t size)
                size -= offset;

                if (file.size < sizeof(struct acpi_table_header)) {
-                       pr_err("ACPI OVERRIDE: Table smaller than ACPI
header [%s%s]\n",
+                       pr_err(PREFIX "initrd: Table smaller than ACPI
header [%s%s]\n",
                                cpio_path, file.name);
                        continue;
                }
@@ -509,17 +515,17 @@ static void __init acpi_table_initrd_init(void
*data, size_t size)
                                break;

                if (!table_sigs[sig]) {
-                       pr_err("ACPI OVERRIDE: Unknown signature [%s%s]\n",
+                       pr_err(PREFIX "initrd: Unknown signature [%s%s]\n",
                                cpio_path, file.name);
                        continue;
                }
                if (file.size != table->length) {
-                       pr_err("ACPI OVERRIDE: File length does not
match table length [%s%s]\n",
+                       pr_err(PREFIX "initrd: File length does not
match table length [%s%s]\n",
                                cpio_path, file.name);
                        continue;
                }
                if (acpi_table_checksum(file.data, table->length)) {
-                       pr_err("ACPI OVERRIDE: Bad table checksum [%s%s]\n",
+                       pr_err(PREFIX "initrd: Bad table checksum [%s%s]\n",
                                cpio_path, file.name);
                        continue;
                }
@@ -593,6 +599,8 @@ acpi_table_initrd_override(struct
acpi_table_header *existing_table,
        int table_index = 0;
        struct acpi_table_header *table;
        u32 table_length;
+       const char *action;
+       bool taint;

        *length = 0;
        *address = 0;
@@ -611,17 +619,29 @@ acpi_table_initrd_override(struct
acpi_table_header *existing_table,
                table_length = table->length;

                /* Only override tables matched */
-               if (test_bit(table_index, acpi_initrd_installed) ||
-                   memcmp(existing_table->signature, table->signature, 4) ||
+               if (memcmp(existing_table->signature, table->signature, 4) ||
                    memcmp(table->oem_table_id, existing_table->oem_table_id,
                           ACPI_OEM_TABLE_ID_SIZE)) {
                        acpi_os_unmap_memory(table, ACPI_HEADER_SIZE);
                        goto next_table;
                }

+               if (existing_table->oem_revision >= table->oem_revision) {
+                       action = "override";
+                       taint = TAINT_OVERRIDDEN_ACPI_TABLE;
+#ifndef CONFIG_ACPI_INITRD_TABLE_OVERRIDE
+                       acpi_os_unmap_memory(table, ACPI_HEADER_SIZE);
+                       goto next_table;
+#endif
+               } else {
+                       taint = TAINT_OVERLAY_ACPI_TABLE;
+                       action = "upgrade";
+               }
+
+
                *length = table_length;
                *address = acpi_tables_addr + table_offset;
-               acpi_table_taint(existing_table);
+               acpi_table_taint(existing_table, taint, action);
                acpi_os_unmap_memory(table, ACPI_HEADER_SIZE);
                set_bit(table_index, acpi_initrd_installed);
                break;
@@ -662,7 +682,7 @@ static void __init acpi_table_initrd_scan(void)
                        goto next_table;
                }

-               acpi_table_taint(table);
+               acpi_table_taint(table, TAINT_OVERLAY_ACPI_TABLE, "install");
                acpi_os_unmap_memory(table, ACPI_HEADER_SIZE);
                acpi_install_table(acpi_tables_addr + table_offset, TRUE);
                set_bit(table_index, acpi_initrd_installed);
@@ -671,25 +691,6 @@ next_table:
                table_index++;
        }
 }
-#else
-static void __init acpi_table_initrd_init(void *data, size_t size)
-{
-}
-
-static acpi_status
-acpi_table_initrd_override(struct acpi_table_header *existing_table,
-                          acpi_physical_address *address,
-                          u32 *table_length)
-{
-       *table_length = 0;
-       *address = 0;
-       return AE_OK;
-}
-
-static void __init acpi_table_initrd_scan(void)
-{
-}
-#endif /* CONFIG_ACPI_INITRD_TABLE_OVERRIDE */

 acpi_status
 acpi_os_physical_table_override(struct acpi_table_header *existing_table,
@@ -714,7 +715,8 @@ acpi_os_table_override(struct acpi_table_header
*existing_table,
                *new_table = (struct acpi_table_header *)AmlCode;
 #endif
        if (*new_table != NULL)
-               acpi_table_taint(existing_table);
+               acpi_table_taint(existing_table, TAINT_OVERRIDDEN_ACPI_TABLE,
+                               "override");
        return AE_OK;
 }
