From: eric.piel-VkQ1JFuSMpfAbQlEx87xDw@public.gmane.org
Subject: RE: [PATCH] ACPI/Processor: C1/C3 states promotion and demotion
Date: Tue, 10 Feb 2004 10:17:29 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1076404649.4028a1a97d77d@mailetu.utc.fr>
References: <C386328088ED7F4E9F81AFBABDDF60DA03F9E5A8@wdmyexch02.my.asia.wdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <C386328088ED7F4E9F81AFBABDDF60DA03F9E5A8-Yw6hFe9C1vnHQcBQSaPqJq0fmWJ9l57d0E9HWUfgJXw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ow Mun Heng <ow.mun.heng-Sjgp3cTcYWE@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Quoting Ow Mun Heng <ow.mun.heng-Sjgp3cTcYWE@public.gmane.org>:
> > Some processors seems to support only C1 and C3 states, for=20
> > instance... mine ;-)
> > (Pentium III Coppermine). The problem is that, in this case,=20
> > no promotion or
> > demotion are linking those two states, therefore the=20
> > preocessor never goes to C3!
>=20
> Hmmm so.. your processor only has C1 and C3 and no C2 right??
> and you're saying since there's no C2, it will never go to c3
Exactly. This simple logic is coded in processor.c, the patch makes it a =
bit
more clever...

> Any idea what is 'threshold_count' and 'latency_ticks'
> and what it does? My Processor Pentium M doen't go to C3 much.
Well, not really, I just took (an modified) the code for C1/C2 :-/ Basica=
lly,
what I undertood is that 'threshold_count' is the number of time the idle
function should be called before the state changes to the promote one. Th=
e
'latency_ticks' is given by the bios and it's the time cost of going to t=
his
more energy saving state.

If you want your processor to go to C3 state you'll need to have your bus=
 master
activity null (you can check it in /proc/acpi/processor/CPU0/power). On m=
y
laptop it requires not playing any sound and not having any usb device on=
... not
so convenient but I've a script that does all those requirements as soon =
as I
close the LID.

Eric



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
