From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: HP nw8000 never wakes up from acpi suspend
Date: Sat, 9 Oct 2004 23:10:11 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3ACA40606221794F80A5670F0AF15F8405BD1223@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Vadim Zeitlin <vadim-oE/GLL+f5xMgsBAKwltoeQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

S1 is less important than S3 and S4.
So, please verify S4 is ok, then S3.=20
S1 is nice-to-have.

try command " echo -n 4 > /proc/acpi/sleep" for s4
echo -n 3 > /proc/acpi/sleep" for  s3
echo -n 1 > /proc/acpi/sleep"  for s1.

There is a known S3 VGA resume issue on some laptop.=20
Maybe you will hit that bug. Please verify.

Thanks,
Luming


>-----Original Message-----
>From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org=20
>[mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of=20
>Vadim Zeitlin
>Sent: Saturday, October 09, 2004 10:30 PM
>To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>Subject: [ACPI] HP nw8000 never wakes up from acpi suspend
>
> Hello,
>
> I've installed Debian (2.6.8-1 kernel, first without, then with ACPI
>patch) on HP nw8000 notebook. Everything worked perfectly out=20
>of the box
>except for suspend. All ACPI modules load successfully and, in general,
>things like monitoring fans and thermal zones work great. Also, cat
>/sys/power/state outputs the expected "standby mem disk".
>
> But standby (S1 state?) doesn't work at all:
>
>[sunrise:/sys/power]# echo standby > state
>echo: write error: operation not permitted
>
>and in syslog I see just the following:
>
>PM: Preparing system for suspend
>Stopping tasks:=20
>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D|
>Restarting tasks... done
>
>
> Doing "echo mem > state" does work if I unload the USB=20
>modules (otherwise
>it stops with an error but this is ok): I see the messages=20
>about drivers
>being stopped and then the machine goes to sleep. The trouble=20
>is, it never
>wakes up. Pressing keys on the keyboard, opening/closing the=20
>lid, pressing
>the power button and cursing loudly all have the same effect:=20
>none at all.
>I can only hard reset the notebook by holding the power button for 5
>seconds.
>
>
> Needless to say, a notebook which can't be suspended is a bit=20
>annoying so
>I'd really like to fix this. Unfortunately I don't know=20
>where/how to start
>debugging this. All I could do was to build a minimal kernel=20
>with nothing
>except absolutely needed stuff (i.e. IDE) in it but not even=20
>graphics card
>support included but this didn't help at all.
>
> Any help would be really appreciated, thanks in advance!
>VZ
>
>
>
>-------------------------------------------------------
>This SF.net email is sponsored by: IT Product Guide on=20
>ITManagersJournal
>Use IT products in your business? Tell us what you think of=20
>them. Give us
>Your Opinions, Get Free ThinkGeek Gift Certificates! Click to=20
>find out more
>http://productguide.itmanagersjournal.com/guidepromo.tmpl
>_______________________________________________
>Acpi-devel mailing list
>Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>https://lists.sourceforge.net/lists/listinfo/acpi-devel
>


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
