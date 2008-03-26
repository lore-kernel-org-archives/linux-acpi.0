From: Corentin CHARY <corentincj@iksaif.net>
Subject: Re: ISA -> ISA_ (Re: [GIT PATCH] ACPI patches for 2.6.25-rc6)
Date: Wed, 26 Mar 2008 16:45:00 +0100
Message-ID: <200803261645.01343.corentincj@iksaif.net>
References: <200803180510.47670.lenb@kernel.org> <20080326081653.GA8247@elte.hu> <200803261132.21448.lenb@kernel.org>
Reply-To: corentincj@iksaif.net
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.dns26.com ([84.246.226.15]:55370 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753342AbYCZPqs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Mar 2008 11:46:48 -0400
In-Reply-To: <200803261132.21448.lenb@kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Bjorn Helgaas <bjorn.helgaas@hp.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org

On Wednesday 26 March 2008 16:32:20 Len Brown wrote:
> So if this is correct or not depends on what the BIOS programmer
> for the Asus A1x choose to write. =A0Perhaps Corentin 'Iksaif' CHARY
> can confirm if the driver is working properly on that system.

Hi,
Sorry I don't have an A1x to test that, and this was here a long time b=
efore I start working on acpi4asus.
But, see that grep :

chary_c@foo /usr/src/linux/drivers/misc $ grep ISA *
asus-laptop.c:      "\\_SB.PCI0.ISA.EC0._Q10",  /* A1x */
thinkpad_acpi.c:IBM_HANDLE(ec, root, "\\_SB.PCI0.ISA.EC0",      /* 240,=
 240x */
thinkpad_acpi.c:           "\\_SB.PCI.ISA.EC",  /* 570 */
thinkpad_acpi.c:           "\\_SB.PCI0.ISA0.EC0",       /* 600e/x, 770e=
, 770x */
thinkpad_acpi.c:           "\\_SB.PCI0.ISA.EC", /* A21e, A2xm/p, T20-22=
, X20-21 */
thinkpad_acpi.c:           "\\_SB.PCI.ISA.SLCE",        /* 570 */

So it seems to work for thinkpads.
I think this patch isn't needed.

--=20
Corentin 'Iksaif' CHARY
http://xf.iksaif.net
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
