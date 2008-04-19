From: Len Brown <lenb@kernel.org>
Subject: Re: Linux 2.6.25 (coretemp reads high temperatures)
Date: Fri, 18 Apr 2008 21:51:48 -0400
Message-ID: <200804182151.49021.lenb@kernel.org>
References: <e85b9d30804180837y39c52e26i588e4b67c87a5e9d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754268AbYDSBwp@vger.kernel.org>
In-Reply-To: <e85b9d30804180837y39c52e26i588e4b67c87a5e9d@mail.gmail.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew <jackdachef@gmail.com>, linux-acpi@vger.kernel.org
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Friday 18 April 2008, Matthew wrote:
> Hi everyone, hi Linus,
>=20
> congratulations on this new great kernel-release :)
>=20
> I've another "regression" to report for 2.6.25:
>=20
> it's concerning much higher temperatures being read out by the
> "coretemp" kernel-module in comparison to 2.6.24* series
>=20
> e.g. where temperatures were around 40-47=B0C they are now constantly
> jumping around 55-70=B0C (even in idle !)
>=20
> several other users/testers have reported this issue too (both on
> zen-sources [heavy patched] & latest gentoo-sources) [slightly
> patched]:
>=20
> http://forums.gentoo.org/viewtopic-t-684812-highlight-.html
>=20
> if I understood git right it (also) happens in conjunction with an 3
> weeks old acpi-snapshot
> (http://repo.or.cz/w/linux-2.6/zen-sources.git?a=3Dheads) integrated =
in
> zen-sources
>=20
> I can "reproduce" this on an Intel Core 2 Duo 6600 (Conroe) with a P5=
W
> DH Deluxe mainboard (by Asus) since at least 2.6.25-rc8 (or possibly
> also rc7)
>=20
> the temperatures on mobile core (2) duo intel processors [e.g. an
> T7500] seem to be read out correctly - I can't tell it exactly but
> this seems to be an entirely "cosmetical" issue
> (hopefully it's not the opposite and the values are now read out
> correctly since such high temps would be very worrying ;) )
>=20
> Keep up the great work & please don't forget your growing amount of
> linux-desktop users :)
>=20
> Regards
>=20
> Mat

Hello Mat,
I'm not familiar with "coretemp", can you point me to the exact version
of the application you are running so I can see how it is getting at
the underlying information?

Also, do you see any change with and without kernel built with CONFIG_T=
HERMAL=3Dy?

thanks,
-Len
