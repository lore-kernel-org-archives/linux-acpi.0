From: Parrenin =?ISO-8859-1?Q?Fr=E9d=E9ric?= <Frederic.Parrenin-uJC2I/HWIrG1lNqXp+/2b1AUjnlXr6A1@public.gmane.org>
Subject: Re: DSDT patch for Samsung P10
Date: 27 Jan 2003 14:14:55 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200301271314.h0RDEgB15253@cnes.fr>
References: <3E2D8E94.2050301@gkec.tu-darmstadt.de>
	 <20030121191357.GG15023@poup.poupinou.org>
	 <3E303184.6020307@gkec.tu-darmstadt.de> <20030123184802.GA11638@clara.net>
	 <3E326CCD.4060107@gkec.tu-darmstadt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3E326CCD.4060107-8NdywcgfOMlWMvVl7B+zuCEWGD4kr0XT@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Stefan Behnel <behnel_ml-8NdywcgfOMlWMvVl7B+zuCEWGD4kr0XT@public.gmane.org>
Cc: acpi-support <acpi-support-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi Stefan,


I have also a Samsung laptop, model V20 cXVC.
I had the same problems as you with ACPI : no thermal zone, no
ac_adaptator, no battery.
A few weeks ago, Bruno Ducrot helped me to correct my dsdt table.
Now, these things work.

Perhaps you will find something useful in my dsdt.
Check my installation page :

http://parrenin.frederic.free.fr/linux-samsung_20_CXVC.html


Hope that helps.


	Fr=E9d=E9ric


Le sam 25/01/2003 =E0 11:54, Stefan Behnel a =E9crit :
> Thanks everyone!
>=20
> Playing a little with iasl gave me a correct(er) DSDT, so now thermal=20
> control is working perfectly. Battery and AC still doesn't show up, but=
=20
> I'll keep trying.
>=20
> Following the instructions here
> http://sourceforge.net/mailarchive/message.php?msg_id=3D2057754
> allowed me to integrate the new DSDT into the kernel.
>=20
> For now I appended the corrected version of the DSDT, just in case=20
> others have the same problems with the Samsung P10.
>=20
> I've also sent a mail to Samsung with my fixes, so maybe they'll provid=
e=20
> an updated BIOS version some time in the future. That laptop is a rathe=
r=20
> new one, so there's still hope...
>=20
> Thanks again,
> Stefan :)
--=20
Frederic Parrenin
LEGOS
18, av. Edouard Belin
31400 TOULOUSE
tel.: 05 61 33 29 56
fax : 05 61 25 32 05



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
