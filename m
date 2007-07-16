From: Stefan Seyfried <seife@suse.de>
Subject: Re: [2.6 patch] the scheduled ACPI_PROCFS removal
Date: Mon, 16 Jul 2007 07:34:32 +0200
Message-ID: <20070716053432.GA20102@suse.de>
References: <20070709145755.GD3492@stusta.de> <20070709174544.2a6b7067@the-village.bc.nu> <Pine.LNX.4.64.0707092044520.2887@fbirervta.pbzchgretzou.qr> <46951969.4030109@tmr.com> <4695BCEA.4060108@gmail.com> <1184231897.2380.2.camel@work>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:49145 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752218AbXGPGjq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 16 Jul 2007 02:39:46 -0400
Content-Disposition: inline
In-Reply-To: <1184231897.2380.2.camel@work>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Richard Hughes <hughsient@gmail.com>
Cc: Alexey Starikovskiy <aystarik@gmail.com>, Bill Davidsen <davidsen@tmr.com>, Jan Engelhardt <jengelh@computergmbh.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Adrian Bunk <bunk@stusta.de>, Zhang Rui <rui.zhang@intel.com>, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Jul 12, 2007 at 10:18:17AM +0100, Richard Hughes wrote:
> On Thu, 2007-07-12 at 09:32 +0400, Alexey Starikovskiy wrote:
> > >> [*] Does someone have an alternative for
> > >> /proc/acpi/battery/BAT1/{state,info}?
> > I'm working on it. Should have proto by the end of week.
>=20
> If you are using the power_supply class (i hope you are ;-) then a HA=
L
> from freedesktop git should make userspace continue to just work.

Having to update HAL is not my definition of "does not break userspace"=
=2E
And, BTW, there is more than just HAL out there using /proc/acpi, and
this should continue to work.
--=20
Stefan Seyfried
QA / R&D Team Mobile Devices        |              "Any ideas, John?"
SUSE LINUX Products GmbH, N=FCrnberg  | "Well, surrounding them's out."=
=20

This footer brought to you by insane German lawmakers:
SUSE Linux Products GmbH, GF: Markus Rex, HRB 16746 (AG N=FCrnberg)
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
