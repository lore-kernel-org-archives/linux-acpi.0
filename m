From: Stefan Smietanowski <stesmi-uPWUOVYScjfQT0dZR+AlfA@public.gmane.org>
Subject: Re: [ACPI] Where do I send APIC victims?
Date: Wed, 03 Sep 2003 16:14:17 +0200
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <3F55F739.4010600@stesmi.com>
References: <20030903080852.GA27649@k3.hellgate.ch> <1062589205.19059.6.camel@dhcp23.swansea.linux.org.uk> <20030903145356.35b9a192.skraw@ithnet.com> <200309031504.03596.vlad@lazarenko.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200309031504.03596.vlad-Qw1rWqDNyQwB085IDyDbTA@public.gmane.org>
To: Vladimir Lazarenko <vlad-Qw1rWqDNyQwB085IDyDbTA@public.gmane.org>
Cc: Stephan von Krawczynski <skraw-DcQCyzbjH0jQT0dZR+AlfA@public.gmane.org>, Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org, rl-7uj+XXdSDtwfv37vnLkPlQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Vladimir Lazarenko wrote:
> On my board, A7V8X, ACPI/APIC works just perfectly with 2.4.22 and KT400 
> chipset, alas on A7N8X Deluxe board with nForce2 chipsets it causes nasty 
> hangups.
> Machine just simply freezes, no oops, nothing whatsoever.
> 
> Disabling APIC solved the problem.
> 
> --
> Regards,
> Vladimir
> 
> On Wednesday 03 September 2003 14:53, Stephan von Krawczynski wrote:
> 
>>On Wed, 03 Sep 2003 12:40:06 +0100
>>
>>Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org> wrote:
>>
>>>On Mer, 2003-09-03 at 11:48, Andrew de Quincey wrote:
>>>
>>>>2.4.22 has the ACPI from 2.6 backported into it, (which includes my
>>>>patch for nforce2 boards) so it will start having the same issue with
>>>>the BIOS bug in KT333/KT400  boards.
>>>
>>>It does - 2.4.22pre7 is great on my boxes, 2.4.22 final ACPI is
>>>basically unusable on anything I own thats not intel.
>>
>>I can't back that. At least on all my Serverworks boxes there are no
>>problems with ACPI. I got reports from VIA-bases SMP boards that they are
>>doing well, too. (all for 2.4.22)

And I can say that my Soyo SY-KT600 Ultra (VIA KT600+8237) has ACPI
problems as well. pci=noacpi doesn't help but acpi=off does. It gives
lots of errors that the ACPI tables are buggy when booting claiming
my 8237 SATA controller has gotten IRQ -19 for instance.
Using acpi=off solves the problem. This is with or without the libata
VIA 8237 SATA driver. Without anything it recognizes the chip but
doesn't like using IRQ -19 and doesn't see any disks. With pci=noacpi
it sees the disks but bombs out when trying to get the partition table.
It gets IRQ -19 still there. acpi=off makes it all work.

// Stefan
