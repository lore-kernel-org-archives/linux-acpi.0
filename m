From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Common boot/shutdown issues with the latest 2.6.37 (Mostly Asus laptops)
Date: Thu, 3 Feb 2011 23:51:31 +0100
Message-ID: <201102032351.31307.rjw@sisk.pl>
References: <556624.21214.qm@web28409.mail.ukl.yahoo.com> <201102032304.46724.rjw@sisk.pl> <4D4B2883.4020701@pardus.org.tr>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4D4B2883.4020701@pardus.org.tr>
Sender: linux-kernel-owner@vger.kernel.org
To: Ozan =?utf-8?q?=C3=87a=C4=9Flayan?= <ozan@pardus.org.tr>
Cc: Richard =?utf-8?q?Sch=C3=BCtz?= <r.schtz@t-online.de>, Lionel Debroux <lionel_debroux@yahoo.fr>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Thursday, February 03, 2011, Ozan =C3=87a=C4=9Flayan wrote:
> On 04.02.2011 00:04, Rafael J. Wysocki wrote:
>=20
> >
> > I guess we see a few different problems here.
> >
> > Can you remind me, please, what the known workarounds are?
>=20
> OK in summary:
>=20
> ASUS X71S - Doesn't boot without nolapic
> ASUS F50SV - Doesn't boot without nolapic (latest tried and working 2=
=2E6.31)
> ASUS N61JQ - X out of Y shutdown hangs (Cured with nolapic too)
>=20
> Note that nolapic is the finer grained fix. acpi=3Doff fixes the issu=
e too.

Hmm.  Are those boxes uniprocessor running SMP kernels?

Rafael
