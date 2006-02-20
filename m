From: "Li, Shaohua" <shaohua.li@intel.com>
Subject: RE: ACPI Troubles with 2.6.16-rc3
Date: Mon, 20 Feb 2006 16:43:23 +0800
Message-ID: <59D45D057E9702469E5775CBB56411F101AE926E@pdsmsx406>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr17.intel.com ([134.134.136.16]:40627 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S932396AbWBTInb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 20 Feb 2006 03:43:31 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Edgar Hucek <hostmaster@ed-soft.at>, Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-acpi@vger.kernel.org, "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>

>mem38: type=7, attr=0xf, range=[0x000000001feef000-0x000000001fef0000)
(0MB)
>mem39: type=9, attr=0xf, range=[0x000000001fef0000-0x000000001feff000)
(0MB)
>mem40: type=6, attr=0x800000000000000f,
range=[0x000000001feff000-0x000000001ff00000) (0MB)
>mem41: type=11, attr=0x8000000000000000,
range=[0x00000000e00f8000-0x00000000e00f9000) (0MB)
>mem42: type=11, attr=0x8000000000000000,
range=[0x00000000fed1c000-0x00000000fed20000) (0MB)
>mem43: type=11, attr=0x8000000000000000,
range=[0x00000000fffb0000-0x00000000fffe0000) (0MB)
from my little understanding, 'high_memory' should be
0x1fef0000+0xc0000000. mem39 - mem43 haven't usable ram region, so
kernel will ignore them. __ioremap will check 'high_memory', and should
be ok.
Is it possible you could get the dmesg from the kernel with my debug
patch?
Let's check where it failed.

Thanks,
Shaohua
>-----Original Message-----
>From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
>owner@vger.kernel.org] On Behalf Of Edgar Hucek
>Sent: Saturday, February 18, 2006 1:28 AM
>To: Bjorn Helgaas
>Cc: linux-acpi@vger.kernel.org; Tolentino, Matthew E
>Subject: Re: ACPI Troubles with 2.6.16-rc3
>
>Hi.
>
>The memory mapp is on the wiki.
>btw: The wiki have a new homepage :
>http://www.mactel-linux.org/wiki/Main_Page
>
>Later this day i'll put information together how to boot Linux on the
>Intel iMac. You wi'll be surprised how simple it is ;)
>
>cu
>
>Edgar
>
>Bjorn Helgaas wrote:
>> On Friday 17 February 2006 00:54, Edgar Hucek wrote:
>>> The machine is an Apple Intel iMac 17" Dual Core booted with
>>> elilo.
>>
>> Nice work.  I think I could help debug this much better with my own
>> Intel iMac :-)
>>
>> Your wiki (http://xbox-linux.org/mactel/index.php/Main_Page) mentions
>> changes to elilo.  Can you detail those?  The elilo maintainer works
>> across the aisle and would like to make this work out of the box.  Or
>> maybe you just had to remove the ExitBootServices call, so the kernel
>> can keep using the firmware console or something?
>>
>> If you have a way to capture the EFI memmap, could you post that on
>> your wiki page as well?  I guess you could collect basically the same
>> information by turning on EFI_DEBUG in arch/i386/kernel/efi.c.
>>
>> The memmap I've seen (from another iMac) has a few strange things:
>>
>>> Type       Start            End               # Pages
>Attributes
>>> reserved   000000000009F000-000000000009FFFF  0000000000000001
>000000000000000F
>>> available  0000000000100000-000000007BD1DFFF  000000000007BC1E
>000000000000000F
>>
>> No MemMapIO region for VGA frame buffer.  Intel ia64 boxes have the
>> same bug.
>>
>>> MemMapIO   00000000E00F8000-00000000E00F8FFF  0000000000000001
>8000000000000000
>>> MemMapIO   00000000FED1C000-00000000FED1FFFF  0000000000000004
>8000000000000000
>>> MemMapIO   00000000FFFB0000-00000000FFFDFFFF  0000000000000030
>8000000000000000
>>
>> Marked "runtime", but no access types supported.  I'd expect at least
>> UC to be set.
>>
>> And the PCI windows aren't mentioned.  I'd expect
0x80000000-0x88000000
>> and some other regions to be MemMapIO.  I guess you can learn this
from
>> the ACPI root bridge descriptions, so maybe it's not strictly
required.
>>
>> But as for your specific issue, I'd expect your memmap to show that
the
>> ACPI tables are in memory that supports WB, so acpi_os_map_memory()
>> will just use phys_to_virt() instead of ioremap(), which is what your
>> dmesg showed:
>>
>>> ACPI: XSDT (v001 APPLE   Apple00 0x00000039      0x01000013) @
>0x1fefd120
>>> ...
>>> iounmap: bad address dfefd000
>>>  [<c0253684>] acpi_tb_get_table_header+0x67/0x92
>>>  [<c02536c2>] acpi_tb_get_table+0x13/0x55
>>>  [<c02538b2>] acpi_tb_get_table_rsdt+0x1f/0x99
>>>  [<c0253971>] acpi_load_tables+0x45/0xa9
>>>  [<c0443d56>] acpi_early_init+0x46/0xf6
>>
>> (0xdfefd000 = 0x1fefd000 + 0xc0000000)
>>
>> In that case, the iounmap() will certainly fail, as Shaohua points
out.
>> His test patch forces acpi_os_map_memory() to always use ioremap(),
but
>> that didn't help your situation.  My guess is you hit the
>> "if(!PageReserved(page))" case in __ioremap(), and we're missing
>> a SetPageReserved() somewhere in the EFI memory initialization, but
>> I'm not enough of an x86/VM expert propose anything.
>>
>> Sorry for rambling on so long without contributing anything...  Maybe
>> Matt will have some ideas.
>>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-acpi"
in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
