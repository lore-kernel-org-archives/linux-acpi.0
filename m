From: Andrew de Quincey <adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
Subject: Re: [ACPI] Where do I send APIC victims?
Date: Wed, 3 Sep 2003 17:10:49 +0100
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <200309031710.49411.adq_dvb@lidskialf.net>
References: <20030903080852.GA27649@k3.hellgate.ch> <200309031504.03596.vlad@lazarenko.net> <3F55F739.4010600@stesmi.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <3F55F739.4010600-uPWUOVYScjfQT0dZR+AlfA@public.gmane.org>
Content-Disposition: inline
To: Stefan Smietanowski <stesmi-uPWUOVYScjfQT0dZR+AlfA@public.gmane.org>, Vladimir Lazarenko <vlad-Qw1rWqDNyQwB085IDyDbTA@public.gmane.org>
Cc: Stephan von Krawczynski <skraw-DcQCyzbjH0jQT0dZR+AlfA@public.gmane.org>, Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, rl-7uj+XXdSDtwfv37vnLkPlQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


> >>I can't back that. At least on all my Serverworks boxes there are no
> >>problems with ACPI. I got reports from VIA-bases SMP boards that they are
> >>doing well, too. (all for 2.4.22)
>
> And I can say that my Soyo SY-KT600 Ultra (VIA KT600+8237) has ACPI
> problems as well. pci=noacpi doesn't help but acpi=off does. It gives
> lots of errors that the ACPI tables are buggy when booting claiming
> my 8237 SATA controller has gotten IRQ -19 for instance.
> Using acpi=off solves the problem. This is with or without the libata
> VIA 8237 SATA driver. Without anything it recognizes the chip but
> doesn't like using IRQ -19 and doesn't see any disks. With pci=noacpi
> it sees the disks but bombs out when trying to get the partition table.
> It gets IRQ -19 still there. acpi=off makes it all work.

The IRQ -19 thing is a bug in my nforce2 patch in 2.4.22. It didn't drop back 
to using the PIC correctly. My latest acpi-picmode patch (posted to this list 
a few days back) corrects this, among other things.
