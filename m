From: "Brown, Len" <len.brown@intel.com>
Subject: RE: [ACPI] Re: ACPI for 2.4
Date: Thu, 25 Mar 2004 18:28:39 -0500
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE002D31BC7@hdsmsx402.hd.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
content-class: urn:content-classes:message
To: Sergey Vlasov <vsu@altlinux.ru>, acpi-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

>ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/
>release/2.4.26/acpi-20040311-2.4.26.diff.gz

Yes, on each release I update the ACPI patch for every release that I
support.

>Patch for 2.4.25 seems to be updated too; however, it gives several
>rejects when applied to a fresh 2.4.25 tree:

>
>./arch/i386/kernel/acpi.c.rej
>./arch/x86_64/kernel/acpi.c.rej
>./arch/x86_64/kernel/e820.c.rej
>./drivers/acpi/system.c.rej
>./include/acpi/acconfig.h.rej
>./include/asm-x86_64/acpi.h.rej
>./include/asm-i386/acpi.h.rej
>./include/asm-ia64/acpi.h.rej

I just tested it on a clean 2.4.25 tree and got no rejects.
(I tested the .gz edition)

Either there was a patch in your tree already, or the
patch got corrupted.  Note that kernel.org signs their files
and you can verify their valididity per instructions in here:

http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/README.A
CPI

Cheers,
-Len
