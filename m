From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI: return first _ADR match for acpi_get_child
Date: Wed, 26 Dec 2012 15:13 +0100
Message-ID: <2952714.u8moKLOMiJ@vostro.rjw.lan>
References: <8150264.b2f1OROKxE@al> <2271508.zSFZF7r2W9@vostro.rjw.lan> <4931572.xMaToDeW2Z@al>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:45115 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751492Ab2LZOHi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 26 Dec 2012 09:07:38 -0500
In-Reply-To: <4931572.xMaToDeW2Z@al>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lekensteyn <lekensteyn@gmail.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Sergio Perez <dagobertstaler@gmail.com>, "Moore, Robert" <robert.moore@intel.com>

On Wednesday, December 19, 2012 11:40:47 PM Lekensteyn wrote:
> Hi,
> 
> On Wednesday 19 December 2012 12:31:35 Rafael J. Wysocki wrote:
> > > This is a well-aimed shot in the dark based on the DSDT I see.
> > 
> > Can you post that DSDT by chance?
> The DSDT for a Lenovo Ideapad Y470 has been posted before to 
> https://bugzilla.kernel.org/show_bug.cgi?id=42696.
> 
> From dsdt.dsl,
> line 9279 (context Device(\_SB.PCI0.PEG0)):
> 
>     Name (_ADR, 0x00010000)
> 
> line 9377 (context Device(\_SB.PCI0.PEG0.PEGP)):
> 
>     Name (_ADR, 0xFFFF)
> 
> line 9414 (context Device(\_SB.PCI0.PEG0.VGA)):
>  Name (_ADR, Zero)
> 
> From ssdt6.dsl, line 1070, (context Device(\_SB.PCI0.PEG0.PEGP)):
>     Method (_INI, 0, NotSerialized)
>     {
>         Store (Zero, \_SB.PCI0.PEG0.PEGP._ADR)
>     }
> 

OK

But as far as I can say, there also are _PS0, _PS1 and _PS3 methods under
PEG0.VGA and there are display devices under it.  Moreover, it seems to have
_DOS defined (which PEGP doesn't have), so I'm not really sure we should
prefer PEG0.PEGP to PEG0.VGA after all?

I wonder what PEG0.PEGP and PEG0.VGA are supposed to represent, actually.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
