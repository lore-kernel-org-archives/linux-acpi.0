From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: 2.6.9 battery status  regression ? [was RE: Battery status wrong from 2.6.7 when running on batteries]
Date: Mon, 29 Nov 2004 16:23:51 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F84041AC0C5@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Fred Labrosse <ffl-4CLdheC3Iye1Qrn1Bg8BZw@public.gmane.org>
Cc: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>, hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Fu, Michael" <michael.fu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

If previous debug patch have positive effect, would you please try the =
following one.

diff -BruN 2.6/drivers/acpi/battery.c edit.stack/drivers/acpi/battery.c
--- 2.6/drivers/acpi/battery.c  2004-11-23 18:46:32.000000000 +0800
+++ edit.stack/drivers/acpi/battery.c   2004-11-29 16:53:25.000000000 =
+0800
@@ -200,6 +200,7 @@
        if (!battery || !bst)
                return_VALUE(-EINVAL);

+       acpi_os_wait_events_complete(NULL);
        /* Evalute _BST */

        status =3D acpi_evaluate_object(battery->handle, "_BST", NULL, =
&buffer);
diff -BruN 2.6/drivers/acpi/thermal.c edit.stack/drivers/acpi/thermal.c
--- 2.6/drivers/acpi/thermal.c  2004-11-23 18:46:50.000000000 +0800
+++ edit.stack/drivers/acpi/thermal.c   2004-11-29 16:55:04.000000000 =
+0800
@@ -224,6 +224,8 @@

        tz->last_temperature =3D tz->temperature;

+       acpi_os_wait_events_complete(NULL);
+
        status =3D acpi_evaluate_integer(tz->handle, "_TMP", NULL, =
&tz->temperature);
        if (ACPI_FAILURE(status))
                return_VALUE(-ENODEV);=20

Thanks
Luming=20

>-----Original Message-----
>From: Yu, Luming=20
>Sent: 2004=C4=EA11=D4=C229=C8=D5 15:09
>To: 'Fred Labrosse'
>Cc: Karol Kozimor; hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org;=20
>acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; Brown, Len; Fu, Michael
>Subject: RE: 2.6.9 battery status regression ? [was RE: [ACPI]=20
>Battery status wrong from 2.6.7 when running on batteries]
>
>>Bug 3678 is about wrong battery and temperature (and maybe=20
>>others) status
>>reported soon after running on batteries, but never when=20
>running on AC.
>>The problem remains after plugging back the AC.  THIS IS A=20
>>REGRESSION OF
>>2.6.7.
>
>Hi Fred,
>
>  Since the execution for battery and temperature are scheduled through
>workqueue of kacpid. I guess, this issue is just due to some=20
>defered task
>haven't been executed , when you are observing them.
>
>Anyway, please try to revert the enclosed patch to verfy it is=20
>a regression of 2.6.7.
>
>Please note, I extracted it from patch-2.6.7 from=20
>www.kernel.org. If it doesn't
>compile, please look for the missed snippets there.
>
>
>Thanks,
>Luming
>
>
>


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
