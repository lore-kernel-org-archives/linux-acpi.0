From: eric.piel-VkQ1JFuSMpfAbQlEx87xDw@public.gmane.org
Subject: RE: [PATCH] ACPI/Processor: C1/C3 states promotion and demotion
Date: Tue, 10 Feb 2004 10:52:07 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1076406727.4028a9c77b139@mailetu.utc.fr>
References: <C386328088ED7F4E9F81AFBABDDF60DA03F9E637@wdmyexch02.my.asia.wdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <C386328088ED7F4E9F81AFBABDDF60DA03F9E637-Yw6hFe9C1vnHQcBQSaPqJq0fmWJ9l57d0E9HWUfgJXw@public.gmane.org>
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
> Can you post me the script? (off list maybe)
Well, I don't have my laptop with me and the script is so terrible that I=
'd be
very shameful. Anyway, the idea is just to put those two lines in a scrip=
t run
by acpid when the LID event is detected:
xmms -n 0 -u
service hotplug stop

=20
> I still can't really get into C3 much. [00000090] is all I get.
> (I've made a separate post about this earlier)
The good news is that your computer can go to C3 , at least :-/

> You mentioned Bus master activity null.. what does that mean??
That means "bus master activity =3D 000000"

> with usb aware kernel     -> bus master activity =3D fffffff
> with NON usb aware kernel -> bus master activity =3D aa23as2
> 					(this value changes very sec!)
So this means there is another thing that is using the bus master. Try to=
 unload
as many things as you can until you see the activity completly flat, that=
's just
what I did to understand ALSA and USB were the culprits on my laptop.

Eric



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
