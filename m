From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Subject: Re: [Fwd: Re: [Linux-usb-users] Fwd: Re: 2.6.17-rc6-mm2 - USB
	issues]
Date: Tue, 20 Jun 2006 14:22:04 +0100
Message-ID: <1150809726.7194.27.camel@localhost.localdomain>
References: <44953B4B.9040108@agotnes.com> <4497DA3F.80302@agotnes.com>
	 <20060620044003.4287426d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from relay6.ptmail.sapo.pt ([212.55.154.26]:32236 "HELO sapo.pt")
	by vger.kernel.org with SMTP id S1750795AbWFTNWQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 20 Jun 2006 09:22:16 -0400
In-Reply-To: <20060620044003.4287426d.akpm@osdl.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: Johny <kernel@agotnes.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb-users@lists.sourceforge.net, linux-usb-devel@lists.sourceforge.net, stern@rowland.harvard.edu, Chris Wedgwood <cw@f00f.org>

Hi,=20

In first thread of this issue in LKML, some months ago, (right now, I
don't have the link).=20
After some discussion, someone arrive the conclusion of that:=20
You only need this quirks, if interrupts are in XT-PIC mode and is
harmless if don't (and "should only run for VIA southbridges"). So if
you are in XT-PIC mode, it is more probability that patch -R in
question, have some affect.
cat /proc/interrupts=20
give you: IO-APIC-... or XT-PIC ?

and what PCI_IDs do you have ? (lspci -n)

Other issue, you can't revert this patch cleanly because after that we
have other patch that adds some more IDs. So just delete any declare of
PCI_DEVICE_ID_VIA_82C... and add one declare with PCI_ANY_ID

Thanks,
S=C3=A9rgio M. B.

On Tue, 2006-06-20 at 04:40 -0700, Andrew Morton wrote:
> You could try a `patch -R' of the below.
>=20
> commit 75cf7456dd87335f574dcd53c4ae616a2ad71a11
> Author: Chris Wedgwood <cw@f00f.org>
> Date:   Tue Apr 18 23:57:09 2006 -0700=20

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
