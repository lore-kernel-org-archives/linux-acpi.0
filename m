From: "Herbert Nachtnebel" <Herbert.Nachtnebel-8zxNtbQCHXIjuwv8T7myQQ@public.gmane.org>
Subject: Re: fan control
Date: Fri, 2 May 2003 14:00:45 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <B900970C7DD9474C972986EB3EC7C58F0D40A1@andromeda.agcad.local>
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
To: Daniele Boffi <boffi-piYtxHxN1XRAly3Pu9w1wA@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> In this moment:
>
> $ cat /proc/acpi/thermal_zone/TZ1/temperature
> temperature:             50 C
>
> $ cat /proc/acpi/fan/FAN*/state
> status:                  on
> status:                  off
> status:                  off
> status:                  off

Ah, here it is - correct.

> (I changed the name of the fans to the more readable FAN[0-3], OK?)

:-)

> if I  echo -n 3 > /proc/acpi/fan/FAN0/state

> then the fan stops.
> After reaching the second trip point, the fan starts up and I have the
> following status report

You have explicitely turned it off.

> $ cat /proc/acpi/fan/FAN*/state
> status:                  off
> status:                  on
> status:                  off
> status:                  off
>=20
> This is what is strange.

Well, not really. ACPI fan (speed) control is a little bit artificial. =
In your case there are four devices presented to the system which has to =
be activated or deactivated according to the temprature measured by TZ1. =
What the system doesn't know is that these four devices are in fact the =
same and are translated into different rotating speeds of the FAN. To =
correctly achieve the result you are expect, the acpi subsystem would =
have to guess that an activated FAN device means that all other FAN =
devices before that device also are activated. A little bit much =
guessing, not?

Have a look, if the temperature is dropping again under the second =
treshold in your above situation than you will see that the state of the =
devices will be correctly again.

Ciao,
Herbert.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
