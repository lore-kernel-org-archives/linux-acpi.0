From: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: [RFC: 2.6 patch] drivers/acpi/: possible cleanups
Date: Thu, 27 Jan 2005 18:30:35 -0500
Message-ID: <200501271830.36444.dtor_core@ameritech.net>
References: <20050127110125.GE28047@stusta.de> <1106867060.2400.2297.camel@d845pe>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261296AbVA0Xuq@vger.kernel.org>
In-Reply-To: <1106867060.2400.2297.camel@d845pe>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <len.brown@intel.com>
Cc: Adrian Bunk <bunk@stusta.de>, Alexey Y Starikovskiy <alexey.y.starikovskiy@intel.com>, Robert Moore <robert.moore@intel.com>, linux-kernel@vger.kernel.org, ACPI Developers <acpi-devel@lists.sourceforge.net>
List-Id: linux-acpi@vger.kernel.org

On Thursday 27 January 2005 18:04, Len Brown wrote:
> Thanks for the patch Adrian.
>=20
> I agree that this is the right direction to go -- enforcing APIs with
> the use of static reduces the possibility of programming errors --
> particularly with many cooks in the kitchen. =C2=A0Indeed, just on Mo=
nday we
> discussed a patch from Alexey Starikovskiy to do the same thing.
>=20
> The problem is one of logistics.
> As I've described before, the files with "R. Byron Moore" at the top =
are
> dual-licensed so Intel can distribute the core interpreter both as GP=
L
> to Linux and also to FreeBSD, HP-UX etc


Well, I can not speak for Adrian but if I were to submit a patch and st=
ate
that it is also dual licensed you should have no troubles applying it e=
ven
to the core files, right?
 =20
--=20
Dmitry
