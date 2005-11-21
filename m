From: Carsten Tschense <carsten-Bz3kcRWZgqLk1uMJSBkQmQ@public.gmane.org>
Subject: ACPI on hp nx6125 doesn't update battery state
Date: Mon, 21 Nov 2005 14:21:52 +0100
Message-ID: <1132579312.8737.7.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,
I now discovered that the battery state doesn't update after the
temperature reaches the first trip point. I'm not totaly sure, but I
think it's right...

Hope you can help me,
Carsten


-- My first mail:

>Carsten Tschense
>Sent: 2005=E5=B9=B411=E6=9C=8819=E6=97=A5 6:22
>To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>Subject: [ACPI] ACPI on hp nx6125 doesn't update battery state
>
>Hi,
>I bought a HP Compaq nx6125 2 days ago...
>After booting the information in /proc/acpi/battery/C175/state update
>regulary, but after a while they don't. I don't see any errors in
>dmesg, /var/log/messages or /var/log/acpid.
>Well, now the strange solution:
>cat /proc/acpi/thermal_zone/TZ1/temperature
>That's the thermal zone of the cpu. After doing this, the fan starts
>blowing for a while, the cpu usage increases to 100% for about=20
>2 seconds
>(may vary), the systems repeats very slow.
>Now the battery state updates, the system runs as normal. If you do a
>cat /proc/acpi/thermal_zone/TZ1/temperature now, nothing happens, after
>circa 5 minutes the same happens again.
>The temperature looks correct all the time. viewing the temperature of
>another thermal zone doesn't help...
>
>That's a bit strange, isn't it? ;)
>I hope you can help me... :) should I provide some debugging
>information?
>
>I'm running a 2.6.14 with gentoos patchset r2.
>
>Bye,
>Carsten



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
