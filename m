From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: FW: [ACPI-bugzilla] ac power plug stop any acpi events
Date: Wed, 23 Nov 2005 13:42:55 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F840A32CDA0@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="GB2312"
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
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: pavlica-qE1trtYNfs4@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

 Forward to acpi dev list.

Please open a bug on bugzilla.kernel.org.
Please file dmesg, acpidump output, and anything userful on bugzilla.

Can acpi interrupt listed from /proc/interrupts get increased on power =
button and lid button after plug in ac?
The problem sounds like  issue of gpe disabled.


-----Original Message-----
From: acpi-bugzilla-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org =
[mailto:acpi-bugzilla-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of =
pavlica-qE1trtYNfs4@public.gmane.org
Sent: 2005=C4=EA11=D4=C222=C8=D5 0:40
To: acpi-bugzilla-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Subject: [ACPI-bugzilla] ac power plug stop any acpi events

hello,
(it is my first time, so i appologize for any inconveniencies.)

i have Clevo notebook D41EV with SIS648FX chipset.
when i plug in the ac adapter i get no event any more.
i use gentoo linux kernel 2.6.14-r2 with suspend2
i have pentium4 HT processor and i have tried with SMP=20
disabled. i have tried with preempt disabled,
i tried with CONFIG_ACPI_DEBUG=3Dy  and
echo "0xFFFFFFFF" > /proc/acpi/debug_level and
echo "0xFFFFFFFF" > /proc/acpi/debug_layer,
but i get no response when i plug in ac adapter.

i am getting events for power button and lid button before
i plug in ac adapter, so i think there is something wrong with ACPI.

i found something similar only there is no report that there is
no events after plugin of ac adapter. I can reproduce this by resetting
the computer.
(see: http://bugzilla.kernel.org/show_bug_cgi?id=3D2487)

then i have tried to debug DSDT.
i found and corrected two errors, the same as reported here:
http://amd.store20.com/laptop/clevo_400.php
recompiled kernel with custom DSDT tables
With no success.

Has anybody any idea, how to solve this or how to debug further?
Is it possible to debug deeper?

best regards, egon



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=3D7628&alloc_id=3D16845&op=3Dclick
_______________________________________________
acpi-bugzilla mailing list
acpi-bugzilla-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/acpi-bugzilla


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
