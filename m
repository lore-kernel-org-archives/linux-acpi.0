From: Seiji Aguchi <seiji.aguchi@hds.com>
Subject: ERST: how to avoid a dynamic memory allocation in panic case
Date: Tue, 22 Jan 2013 23:30:08 +0000
Message-ID: <A5ED84D3BB3A384992CBB9C77DEDA4D414A51F3D@USINDEM103.corp.hds.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Huang, Ying (ying.huang@intel.com)" <ying.huang@intel.com>, "rjw@sisk.pl" <rjw@sisk.pl>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "H. Peter Anvin (hpa@zytor.com)" <hpa@zytor.com>, "robert.moore@intel.com" <robert.moore@intel.com>, "trenn@suse.de" <trenn@suse.de>, "myron.stowe@redhat.com" <myron.stowe@redhat.com>
List-Id: linux-acpi@vger.kernel.org

[Issue]

Current erst driver is kicked in panic case.
On the other hand, a dynamic memory allocation seems to run in it
with a following code path.

erst_writer -> erst_write -> __erst_write_to_storage -> many of apei_exec_run -> 
ctx->ins_table[entry->instruction].run()

which are functions defined in erst_ins_type table i.e:

apei_exec_read_register -> apei_read -> acpi_os_read_memory64 -> acpi_os_ioremap -> ioremap_cache

which possibly involve IOMMU allocator.

I may cause a failure of  an erst driver if the panic happens in an interrupt context.

[Idea]

If we can remove ioremap_cache() from acpi_os_read_memory() as follows,
It is easy to fix this issue.
But I'm not sure if it is feasible because I can't see the reason of tying acpi_os_ioremap()  from a git log...

Any comment?

<snip>
@@ -918,10 +918,7 @@ acpi_os_read_memory(acpi_physical_address phys_addr, u64 *value, u32 width)
 	virt_addr = acpi_map_vaddr_lookup(phys_addr, size);
 	if (!virt_addr) {
 		rcu_read_unlock();
-		virt_addr = acpi_os_ioremap(phys_addr, size);
-		if (!virt_addr)
-			return AE_BAD_ADDRESS;
-		unmap = true;
+		return AE_BAD_ADDRESS;
 	}
 
 	if (!value)
<snip>

Seiji
