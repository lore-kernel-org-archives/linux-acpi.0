From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: ACPI Troubles with 2.6.16-rc3
Date: Fri, 17 Feb 2006 10:14:49 -0700
Message-ID: <200602171014.49656.bjorn.helgaas@hp.com>
References: <43F5811A.60904@ed-soft.at>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel8.hp.com ([156.153.255.206]:483 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S1750766AbWBQROu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 17 Feb 2006 12:14:50 -0500
In-Reply-To: <43F5811A.60904@ed-soft.at>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Edgar Hucek <hostmaster@ed-soft.at>
Cc: linux-acpi@vger.kernel.org, "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>

On Friday 17 February 2006 00:54, Edgar Hucek wrote:
> The machine is an Apple Intel iMac 17" Dual Core booted with
> elilo.

Nice work.  I think I could help debug this much better with my own
Intel iMac :-)

Your wiki (http://xbox-linux.org/mactel/index.php/Main_Page) mentions
changes to elilo.  Can you detail those?  The elilo maintainer works
across the aisle and would like to make this work out of the box.  Or
maybe you just had to remove the ExitBootServices call, so the kernel
can keep using the firmware console or something?

If you have a way to capture the EFI memmap, could you post that on
your wiki page as well?  I guess you could collect basically the same
information by turning on EFI_DEBUG in arch/i386/kernel/efi.c.

The memmap I've seen (from another iMac) has a few strange things:

> Type       Start            End               # Pages          Attributes
> reserved   000000000009F000-000000000009FFFF  0000000000000001 000000000000000F
> available  0000000000100000-000000007BD1DFFF  000000000007BC1E 000000000000000F

No MemMapIO region for VGA frame buffer.  Intel ia64 boxes have the
same bug.

> MemMapIO   00000000E00F8000-00000000E00F8FFF  0000000000000001 8000000000000000
> MemMapIO   00000000FED1C000-00000000FED1FFFF  0000000000000004 8000000000000000
> MemMapIO   00000000FFFB0000-00000000FFFDFFFF  0000000000000030 8000000000000000

Marked "runtime", but no access types supported.  I'd expect at least
UC to be set.

And the PCI windows aren't mentioned.  I'd expect 0x80000000-0x88000000
and some other regions to be MemMapIO.  I guess you can learn this from
the ACPI root bridge descriptions, so maybe it's not strictly required.

But as for your specific issue, I'd expect your memmap to show that the
ACPI tables are in memory that supports WB, so acpi_os_map_memory()
will just use phys_to_virt() instead of ioremap(), which is what your
dmesg showed:

>ACPI: XSDT (v001 APPLE   Apple00 0x00000039      0x01000013) @ 0x1fefd120
>...
> iounmap: bad address dfefd000
>  [<c0253684>] acpi_tb_get_table_header+0x67/0x92
>  [<c02536c2>] acpi_tb_get_table+0x13/0x55
>  [<c02538b2>] acpi_tb_get_table_rsdt+0x1f/0x99
>  [<c0253971>] acpi_load_tables+0x45/0xa9
>  [<c0443d56>] acpi_early_init+0x46/0xf6

(0xdfefd000 = 0x1fefd000 + 0xc0000000)

In that case, the iounmap() will certainly fail, as Shaohua points out.
His test patch forces acpi_os_map_memory() to always use ioremap(), but
that didn't help your situation.  My guess is you hit the
"if(!PageReserved(page))" case in __ioremap(), and we're missing
a SetPageReserved() somewhere in the EFI memory initialization, but
I'm not enough of an x86/VM expert propose anything.

Sorry for rambling on so long without contributing anything...  Maybe
Matt will have some ideas.
