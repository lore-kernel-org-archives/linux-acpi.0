From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Common boot/shutdown issues with the latest 2.6.37 (Mostly Asus laptops)
Date: Sat, 5 Feb 2011 19:16:31 +0100
Message-ID: <201102051916.32141.rjw@sisk.pl>
References: <556624.21214.qm@web28409.mail.ukl.yahoo.com> <201102042136.20165.rjw@sisk.pl> <4D4D4EF1.8010107@pardus.org.tr>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:46734 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753224Ab1BESRQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 5 Feb 2011 13:17:16 -0500
In-Reply-To: <4D4D4EF1.8010107@pardus.org.tr>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ozan =?utf-8?q?=C3=87a=C4=9Flayan?= <ozan@pardus.org.tr>
Cc: Richard =?utf-8?q?Sch=C3=BCtz?= <r.schtz@t-online.de>, Lionel Debroux <lionel_debroux@yahoo.fr>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org

On Saturday, February 05, 2011, Ozan =C3=87a=C4=9Flayan wrote:
> On 04.02.2011 22:36, Rafael J. Wysocki wrote:
>=20
> >
> > At this point I guess it's best to open a bug entry in the kernel B=
ugzilla,
> > against ACPI (although ACPI may be a red herring), and put some sys=
tem
> > information (ie. dmesg outputs from working kernels, if any, output=
s of
> > acpidump) -- or links to where it can be found.
>=20
> Well I've already filed two bugs:
> https://bugzilla.kernel.org/show_bug.cgi?id=3D26502
> https://bugzilla.kernel.org/show_bug.cgi?id=3D27412

OK

So the conclusion from this thread is that disabling cpuidle doesn't he=
lp, right?

Did you carry out the !CONFIG_NO_HZ tests?

Rafael
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
