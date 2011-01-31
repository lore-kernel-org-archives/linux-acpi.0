From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Common boot/shutdown issues with the latest 2.6.37 (Mostly Asus laptops)
Date: Mon, 31 Jan 2011 19:24:32 +0100
Message-ID: <201101311924.33098.rjw@sisk.pl>
References: <556624.21214.qm@web28409.mail.ukl.yahoo.com> <201101311123.14704.rjw@sisk.pl> <4D468F1F.8030704@t-online.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:54688 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751950Ab1AaSYu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 31 Jan 2011 13:24:50 -0500
In-Reply-To: <4D468F1F.8030704@t-online.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Richard =?utf-8?q?Sch=C3=BCtz?= <r.schtz@t-online.de>
Cc: Ozan =?utf-8?q?=C3=87a=C4=9Flayan?= <ozan@pardus.org.tr>, Lionel Debroux <lionel_debroux@yahoo.fr>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, colin.king@canonical.com

On Monday, January 31, 2011, Richard Sch=C3=BCtz wrote:
> >>>> I'll compile a kernel with CONFIG_NO_HZ to see what happens but =
how do I
> >>>> disable cpuidle during boot? I've checked the kernel-parameters.=
txt but
> >>>> there's no cpuidle related boot parameter there.
> >>>
> >>> Booting with intel_idle.max_cstate=3D0 should do the trick.
> >>
> >> intel_idle.max_cstate=3D0 causes a fallback to the acpi_idle drive=
r. So it
> >> does not disable the C-states directly.
> >
> > What about not building the acpi_idle driver, then?
>=20
> Or just use the processor.max_cstate parameter then.

As I wrote a couple of messages ago, https://lkml.org/lkml/2011/1/31/52=
 .

Sure, that should do the trick too.

Thanks,
Rafael
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
