From: Nigel Cunningham <ncunningham-oKK1aGe2n869koe0gwxAeg@public.gmane.org>
Subject: Re: Power on at specific time
Date: Wed, 30 Apr 2003 07:08:22 +1200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1051643301.5394.1.camel@laptop-linux>
References: <1051613486.3508.48.camel@laptop-linux>
 <20030429074410.6d50b75b.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <20030429074410.6d50b75b.rddunlap-3NddpPZAyC0@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Randy.Dunlap" <rddunlap-3NddpPZAyC0@public.gmane.org>
Cc: ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Thanks.

Perhaps it's the fact that I typed ICH3M instead :>

Regards,

Nigel

On Wed, 2003-04-30 at 02:44, Randy.Dunlap wrote:
> On Tue, 29 Apr 2003 22:51:26 +1200 Nigel Cunningham <ncunningham@cl=
ear.net.nz> wrote:
>=20
> | Hi Andy.
> |=20
> | A while ago we had a conversation that finished like this...
> |=20
> |=20
> |  > From: Nigel Cunningham [mailto:ncunningham-1uLG4q7jwdI@public.gmane.org]=20
> |  > On Wed, 2003-02-19 at 13:09, Grover, Andrew wrote:
> |  > > Well, go fix it and send me a patch! :)
> |  > >=20
> |  > > Seriously, Pat roughed-in the alarm support a long long=20
> |  > time ago, but it
> |  > > needs someone to take another look at it and get it fully=
=20
> |  > functional.
> |  >=20
> |  > Gladly, but I wanted to make sure I wasn't barking up the wron=
g tree
> |  > first, and then I need a push in right direction (toward some
> |  > documentation!).
> | =20
> |  Go check out include/linux/mc146818rtc.h. Using this plus the ex=
isting
> |  code plus a recent ICH datasheet available on developer.intel.co=
m (I
> |  recommend ICH3m's - section 9.6 is "Real Time Clock Registers") =
you
> |  should be able to get started.
> | =20
> |  Hope this helps -- Regards -- Andy
> |=20
> |=20
> | I'm having trouble finding the ICH datasheet you spoke of. Could =
you
> | give me a url?
>=20
> Right, I'm not Andy.
>=20
> At developer.intel.com, I followed Hardware Design, Chipsets, Mobil=
e,
> and found a section on Intel=AE 830 Chipset Family, which contains =
the
> letters "ICH3-M" several times.   Then click on Documentation, Data=
sheets,
> scroll down to Mobile Intel=AE 830 Chipset Family, and click on the
> ICH3-M datasheet URL.
>=20
> HTH.
> --
> ~Randy
--=20
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

Be diligent to present yourself approved to God as a workman who does
not need to be ashamed, handling accurately the word of truth.
=09-- 2 Timothy 2:14, NASB.




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
