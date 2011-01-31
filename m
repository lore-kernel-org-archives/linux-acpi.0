From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Common boot/shutdown issues with the latest 2.6.37 (Mostly Asus laptops)
Date: Mon, 31 Jan 2011 11:14:11 +0100
Message-ID: <201101311114.11935.rjw@sisk.pl>
References: <556624.21214.qm@web28409.mail.ukl.yahoo.com> <201101311050.49722.rjw@sisk.pl> <4D4688DD.6030502@pardus.org.tr>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:51449 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752683Ab1AaKOW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 31 Jan 2011 05:14:22 -0500
In-Reply-To: <4D4688DD.6030502@pardus.org.tr>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ozan =?utf-8?q?=C3=87a=C4=9Flayan?= <ozan@pardus.org.tr>
Cc: Lionel Debroux <lionel_debroux@yahoo.fr>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, colin.king@canonical.com

On Monday, January 31, 2011, Ozan =C3=87a=C4=9Flayan wrote:
> On 31.01.2011 11:50, Rafael J. Wysocki wrote:
> > On Monday, January 31, 2011, Ozan =C3=87a=C4=9Flayan wrote:
> >> On 31.01.2011 00:48, Rafael J. Wysocki wrote:
> >>
> >>> Does booting with "nolapic" help on all of the affected systems?
> >>>
> >>> Also, does disabling the CPUidle during boot help?
> >>>
> >>> Finally, is the problem reproducible with CONFIG_NO_HZ unset?
> >>
> >> Well on two machines, nolapic cures the boot hang and on one machi=
ne it
> >> cures the random shutdown hangs.
> >>
> >> I'll compile a kernel with CONFIG_NO_HZ to see what happens but ho=
w do I
> >> disable cpuidle during boot? I've checked the kernel-parameters.tx=
t but
> >> there's no cpuidle related boot parameter there.
> >
> > Booting with intel_idle.max_cstate=3D0 should do the trick.
>=20
> Okay but on Asus X61S idle fallbacks to cpuidle:
>=20
> intel_idle: MWAIT substates: 0x3122220
> intel_idle: does not run on family 6 model 23
>=20
> so forcing max_cstate to 0 will turn off the cpuidle on those machine=
s too?

In those cases you can use processor.max_cstate=3D0 I think.

Rafael
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
