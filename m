From: Frans Pop <elendil@planet.nl>
Subject: Re: 2.6.23-rc6: S4 and S5 no longer listed as supported on Toshiba Satellite A40
Date: Thu, 20 Sep 2007 20:17:50 +0200
Message-ID: <200709202017.50934.elendil@planet.nl>
References: <200709192014.08443.elendil@planet.nl> <46F2A0E9.9000603@gmail.com> <46F2AE16.9080803@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hpsmtp-eml20.kpnxchange.com ([213.75.38.85]:54598 "EHLO
	hpsmtp-eml20.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757095AbXITSSA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 20 Sep 2007 14:18:00 -0400
In-Reply-To: <46F2AE16.9080803@gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Maciek Rutecki <maciej.rutecki@gmail.com>

On Thursday 20 September 2007, you wrote:
> Please try this patch.

Works. All states are now listed again.
I've not tested suspend to disk, but suspend to ram and power off work =
fine.

> +printk(KERN_INFO PREFIX "(supports");
> =C2=A0#ifdef CONFIG_SUSPEND
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0printk(KERN_INFO PREFIX "(=
supports");
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0for (i =3D ACPI_STATE=
_S0; i < ACPI_STATE_S4; i++) {

Isn't there a risk now that we now end up printing
   ACPI: (supports)
if CONFIG_SUSPEND is not enabled and >S4 is not supported?

Or, more probably, it would print
   ACPI: (supports S5)
as it is unlikely that "off" is not supported :-)

Maybe S0 should be taken outside the #ifdef and the loop as that state =
is=20
also basically always there?

Thanks,
=46JP
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
