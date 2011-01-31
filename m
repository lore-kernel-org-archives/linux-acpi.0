From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Common boot/shutdown issues with the latest 2.6.37 (Mostly Asus laptops)
Date: Mon, 31 Jan 2011 21:42:37 +0100
Message-ID: <201101312142.37773.rjw@sisk.pl>
References: <556624.21214.qm@web28409.mail.ukl.yahoo.com> <201101312012.42393.rjw@sisk.pl> <4D471D2F.7010008@pardus.org.tr>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <4D471D2F.7010008@pardus.org.tr>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Ozan =?utf-8?q?=C3=87a=C4=9Flayan?= <ozan@pardus.org.tr>
Cc: Richard =?utf-8?q?Sch=C3=BCtz?= <r.schtz@t-online.de>, Lionel Debroux <lionel_debroux@yahoo.fr>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, colin.king@canonical.com
List-Id: linux-acpi@vger.kernel.org

On Monday, January 31, 2011, Ozan =C3=87a=C4=9Flayan wrote:
> On 31.01.2011 21:12, Rafael J. Wysocki wrote:
>=20
> > Booting with maxcpus=3D0 also disables the I/O APIC, which probably=
 is a bit too
> > much, but let's see what happens in that case.
>=20
> Well the only-booting-with-nolapic one doesn't boot with maxcpus=3D0.=
 Pff,=20
> are there any compile-time(Kconfig) or runtime parameters related to=20
> debugging various subsystems that you'll suggest which will show wher=
e=20
> the boot hangs? That way we can maybe pinpoint the issue to a specifi=
c=20
> function call.

Booting with initcall_debug causes all of the initcalls to be shown (st=
art,
finish and duration), so it may allow you to find the culprit if you ca=
n
collect the messages.

Rafael
