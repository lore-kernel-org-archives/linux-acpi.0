From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Common boot/shutdown issues with the latest 2.6.37 (Mostly Asus laptops)
Date: Mon, 31 Jan 2011 19:33:37 +0100
Message-ID: <201101311933.38050.rjw@sisk.pl>
References: <556624.21214.qm@web28409.mail.ukl.yahoo.com> <201101311924.33098.rjw@sisk.pl> <4D46FF82.1090704@pardus.org.tr>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <4D46FF82.1090704@pardus.org.tr>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Ozan =?utf-8?q?=C3=87a=C4=9Flayan?= <ozan@pardus.org.tr>
Cc: Richard =?utf-8?q?Sch=C3=BCtz?= <r.schtz@t-online.de>, Lionel Debroux <lionel_debroux@yahoo.fr>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, colin.king@canonical.com
List-Id: linux-acpi@vger.kernel.org

On Monday, January 31, 2011, Ozan =C3=87a=C4=9Flayan wrote:
> On 31.01.2011 20:24, Rafael J. Wysocki wrote:
>=20
> >>
> >> Or just use the processor.max_cstate parameter then.
> >
> > As I wrote a couple of messages ago, https://lkml.org/lkml/2011/1/3=
1/52 .
>=20
> The users reported that processor.max_cstate=3D0 didn't help too. The=
 ones=20
> which experience random hangs during shutdown tells that the hard dis=
k=20
> is turned off and the fans are turning faster.
>=20
> The other user which can't even boot didn't tell the result of adding=
=20
> processor.max_cstate=3D0 to boot params.

Well, I'm kind of not sure what to do next.

The expectation seems to be that the problem is somehow related to cpui=
dle,
but the above observations fail to confirm that.

Would it be possible to check if running the kernel in uniprocessor mod=
e
makes the problem go away?

Rafael
