From: Malte Thoma <thoma-iYtK5bfT9M8b1SvskN2V4Q@public.gmane.org>
Subject: Fan control with heatload
Date: Mon, 06 Jan 2003 21:07:36 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3E19E208.5090106@muenster.de>
References: <000c01c2add3$3c8ddcf0$0201a8c0@supervanes> <3E1075BF.3070806@uni-muenster.de> <20030106153729.GA4661@digda.intern.quelltext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030106153729.GA4661-XEk0yrNnxERrk9EDFsdIuomMxnTEL9wi0E9HWUfgJXw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Arndt Schoenewald <abs-SA7OhAOe25xnNxvc45mVi0K323yFvGpRdefyYXQ/eNw@public.gmane.org>, heatload-general-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Thank you, Arndt,

from Version 0.6.1 heatload can turn the fan on/off via the menu.
I uses an echo 0|3.

Question to the Gurus:

Why '0' and '3' ?

Greetings,

Malte


Arndt Schoenewald wrote:

>Hallo Malte!
>
> =20
>
>>P.S: I still need a 'cat' of the 'fan' interface. And perhaps can=20
>>someone tell me how to write to this interface.
>>   =20
>>
>
>Ok, ich sitze gerade mal wieder an meinem Laptop (das erste Mal seit
>ein paar Tagen) und kann dir daher jetzt diese Informationen geben.
>
>Zum Auschalten des L=FCfters: echo 3 >/proc/acpi/fan/FAN/state
>
># cat /proc/acpi/fan/FAN/state
>status:                  off
>
>Und zum Wiedereinschalten: echo 0 >/proc/acpi/fan/FAN/state
>
># cat /proc/acpi/fan/FAN/state
>status:                  on
>
>Bei manchen Maschinen (z.B. bei meinem Gericom 1st SuperSonic M6-T)
>l=E4sst sich der L=FCfter auf diese Weise jedoch nicht komplett ausschal=
ten,
>sondern er l=E4uft lediglich langsamer (und leiser, weshalb ich das
>"echo 3 >/proc/acpi/fan/FAN/state" bei jedem Systemboot ausf=FChre).
>
>Bis dann,
>Arndt
>
> =20
>




-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
