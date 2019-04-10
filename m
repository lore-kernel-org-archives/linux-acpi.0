From: Qian Cai <cai@lca.pw>
Subject: [PATCH -next v2] acpi/hmat: fix memory leaks in hmat_init()
Date: Tue,  9 Apr 2019 22:14:50 -0400
Message-ID: <20190410021450.1263-1-cai@lca.pw>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: rjw@rjwysocki.net, lenb@kernel.org, keith.busch@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
List-Id: linux-acpi@vger.kernel.org

The commit 665ac7e92757 ("acpi/hmat: Register processor domain to its
memory") introduced some memory leaks below due to it fails to release
the heap memory in an error path, and then those statically-allocated
__initdata memory which reference them get freed during boot renders
those heap memory as leaks. Since it is valid to pass NULL to
acpi_put_table(), it is fine to call it even if acpi_get_table() returns
an error.

unreferenced object 0xc8ff8008349e9400 (size 128):
  comm "swapper/0", pid 1, jiffies 4294709236 (age 48121.476s)
  hex dump (first 32 bytes):
    00 d0 9e 34 08 80 ff 84 d8 00 43 11 00 10 ff ff  ...4......C.....
    00 00 00 00 ff ff ff ff 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000869d4503>] __kmalloc+0x568/0x600
    [<0000000070fd6afb>] alloc_memory_target+0x50/0xd8
    [<00000000efa2081e>] srat_parse_mem_affinity+0x58/0x5c
    [<000000008bfaef74>] acpi_parse_entries_array+0x1c8/0x2c0
    [<0000000022804877>] acpi_table_parse_entries_array+0x11c/0x138
    [<00000000ffe9cd34>] acpi_table_parse_entries+0x7c/0xac
    [<00000000a7023afd>] hmat_init+0x90/0x174
    [<00000000694a86c1>] do_one_initcall+0x2d8/0x5f8
    [<0000000024889da9>] do_initcall_level+0x37c/0x3fc
    [<000000009be02908>] do_basic_setup+0x38/0x50
    [<0000000037b3ac0a>] kernel_init_freeable+0x194/0x258
    [<00000000f5741184>] kernel_init+0x18/0x334
    [<000000007b30f423>] ret_from_fork+0x10/0x18
    [<000000006c7147a8>] 0xffffffffffffffff

Signed-off-by: Qian Cai <cai@lca.pw>
---

v2: goto out_put per Rafael.

 drivers/acpi/hmat/hmat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/hmat/hmat.c b/drivers/acpi/hmat/hmat.c
index b7824a0309f7..69cdb3cea545 100644
--- a/drivers/acpi/hmat/hmat.c
+++ b/drivers/acpi/hmat/hmat.c
@@ -637,7 +637,7 @@ static __init int hmat_init(void)
 
 	status = acpi_get_table(ACPI_SIG_HMAT, 0, &tbl);
 	if (ACPI_FAILURE(status))
-		return 0;
+		goto out_put;
 
 	hmat_revision = tbl->revision;
 	switch (hmat_revision) {
-- 
2.17.2 (Apple Git-113)
