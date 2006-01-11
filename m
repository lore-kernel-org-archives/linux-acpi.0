From: Yasunori Goto <y-goto-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Subject: [Patch 0/2]Memory hotplug from ACPI container driver take 2.
Date: Wed, 11 Jan 2006 18:58:33 +0900
Message-ID: <20060111184302.BCB0.Y-GOTO@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "Tolentino, Matthew E" <matthew.e.tolentino-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Linux Kernel ML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI-ML <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


Hello.

I would like to post patches for ACPI memory hotplug again.
These are necessary when container driver, which is a kind of block
like NUMA node, calls memory hotplug.

If a node is hot-added, notification from ACPI reaches to container 
device, and container device driver will try to add and start
each devices which are included on the node by acpi_bus_add() and
acpi_bus_start(). 

But current acpi_memhotplug.c is just for the case that notification
reaches to memory device directly. So, add_memory() is just called by
notify handler of memory device.
If node is hot-added, contaner driver calls only acpi_memory_device_add()
to register "struct acpi_memory_device". But there is no start function
for memory, so add_memory() is not called.

I think that add_memory() should be called at acpi_bus_start() for
NUMA node case. These are patches for it.

These patches are for 2.6.15. And, I tested on my Tiger 4
 with Numa emulation by Custom DSDT.
Please apply.

Thanks.


-- 
Yasunori Goto 


-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
