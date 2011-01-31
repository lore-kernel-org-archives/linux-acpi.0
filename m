From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Common boot/shutdown issues with the latest 2.6.37 (Mostly Asus laptops)
Date: Mon, 31 Jan 2011 11:23:14 +0100
Message-ID: <201101311123.14704.rjw@sisk.pl>
References: <556624.21214.qm@web28409.mail.ukl.yahoo.com> <201101311050.49722.rjw@sisk.pl> <4D468CF0.9040103@t-online.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <4D468CF0.9040103@t-online.de>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Richard =?utf-8?q?Sch=C3=BCtz?= <r.schtz@t-online.de>
Cc: Ozan =?utf-8?q?=C3=87a=C4=9Flayan?= <ozan@pardus.org.tr>, Lionel Debroux <lionel_debroux@yahoo.fr>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, colin.king@canonical.com
List-Id: linux-acpi@vger.kernel.org

On Monday, January 31, 2011, Richard Sch=C3=BCtz wrote:
> >> I'll compile a kernel with CONFIG_NO_HZ to see what happens but ho=
w do I
> >> disable cpuidle during boot? I've checked the kernel-parameters.tx=
t but
> >> there's no cpuidle related boot parameter there.
> >
> > Booting with intel_idle.max_cstate=3D0 should do the trick.
>=20
> intel_idle.max_cstate=3D0 causes a fallback to the acpi_idle driver. =
So it=20
> does not disable the C-states directly.

What about not building the acpi_idle driver, then?

Rafael
