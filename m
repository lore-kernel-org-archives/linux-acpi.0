From: "Herbert Nachtnebel" <Herbert.Nachtnebel-8zxNtbQCHXIjuwv8T7myQQ@public.gmane.org>
Subject: AW: Completely discharging LION batteries
Date: Wed, 11 Dec 2002 16:26:41 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <B900970C7DD9474C972986EB3EC7C58F04EA7D@andromeda.agcad.local>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> I'm using Linux 2.4.20 together with the acpi patches=20
> 20021205-2.4.20 on a
> Thinkpad T20. If I use two batteries (the builtin and a=20
> second in the Ultra-
> Bay), the second battery first gets discharged _completely_=20
> and after that the internal battery is used.

That's normal, but yes it is not the smartest idea to do.

> After completely discharging the battery, the
> maximum capacity to which the battery can be charged is only=20
> 28120 mWh,
> so I lost about 2000 mWh or about 8 percent of the battery capacity!!!

Yes that's correct, but a 8 percent drop is way to much.=20
It's a physical property that if Lion batteries are discharged=20
completely the capacity gets smaller. Hence in areas were reliability is
important (i.e. in satellites) lion batteries are never allowed to =
discharge
deeply. But on the other hand, from the manufacturer point of view this =
is=20
more than welcome. The customer has the replace his batteries sooner.

>=20
> So since I found that out I don't allow the Laptop to fully=20
> discharge the
> battery anymore. So may questions are: Can I set the capacity=20
> at which the
> Laptop switches to the builtin battery? Can you acknowledge=20
> my experiences?

The strategy is set by the BIOS or by the embedded controller, there is =
no
way to change it.

Herbert.


-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
