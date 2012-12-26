From: Lekensteyn <lekensteyn@gmail.com>
Subject: Re: [PATCH] ACPI: return first _ADR match for acpi_get_child
Date: Wed, 26 Dec 2012 16:15:16 +0100
Message-ID: <1985295.2rJ73b5T91@al>
References: <8150264.b2f1OROKxE@al> <4931572.xMaToDeW2Z@al> <2952714.u8moKLOMiJ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ee0-f44.google.com ([74.125.83.44]:56400 "EHLO
	mail-ee0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751151Ab2LZPVB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Dec 2012 10:21:01 -0500
Received: by mail-ee0-f44.google.com with SMTP id b47so4233383eek.17
        for <linux-acpi@vger.kernel.org>; Wed, 26 Dec 2012 07:20:59 -0800 (PST)
In-Reply-To: <2952714.u8moKLOMiJ@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Sergio Perez <dagobertstaler@gmail.com>, "Moore, Robert" <robert.moore@intel.com>

On Wednesday 26 December 2012 15:13:00 Rafael J. Wysocki wrote:
> But as far as I can say, there also are _PS0, _PS1 and _PS3 methods under
> PEG0.VGA and there are display devices under it.
_PS0, _PS1 and _PS3 just set _PSC for ACPI. It does interact with any 
hardware. The display adapter use "CADL" (\CADL based on the scope of 
CRT._DCS, not to be confused with \_SB.PCI0.GFX0.CADL (field IGDM)). This field 
is only written in NVIF. It seems to be a display adapter used for a nvidia 
graphics card.

I know that some Lenovo laptops allow you to select Intel / Nvidia / Optimus 
in their BIOS, maybe this PEG0.VGA is used for the nvidia-only setup (lazy 
Lenovo engineers?). Note that this does *not* apply to this IdeaPad Y570 or a 
Lenovo IdeaPad Y470, these laptops force you into the Optimus mode which means 
that you have two graphics cards activated.

> Moreover, it seems to have
> _DOS defined (which PEGP doesn't have), so I'm not really sure we should
> prefer PEG0.PEGP to PEG0.VGA after all?
The code is a subset of what \_SB.PCI0.GFX0._DOS does.
VGA._DOS:

    Store (And (Arg0, 0x07), DSEN)
GFX0._DOS:

    Store (And (Arg0, 0x07), DSEN)
    If (LEqual (And (Arg0, 0x03), Zero)) {
        If (CondRefOf (HDOS)) {
            HDOS ()
        }
    }

> I wonder what PEG0.PEGP and PEG0.VGA are supposed to represent, actually.
PEGP represents the more powerful Nvidia graphics card. GFX0 is the more 
power-aggressive Intel graphics card. VGA... is something useless? A "it 
works, do not touch anything" leftover? There is also a completely useless 
VGA1 device. To quote Linus [1]:

> It's that simple. Don't expect anything else. Firmware is written by
> people who have lost the will to live (why? Because they do firmware
> development for a living), and the only thing keeping them going is
> the drugs. And they're not the "fun" kind of drugs. The end result is
> predictable. In their drug-induced haze, they make a mess.

Regards,
Peter

 [1]: http://lkml.org/lkml/2012/10/21/75
