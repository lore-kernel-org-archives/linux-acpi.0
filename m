From: "Pallipadi, Venkatesh" <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Z600 screen restore
Date: Mon, 27 Sep 2004 11:25:32 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <88056F38E9E48644A0F562A38C64FB6002F9167B@scsmsx403.amr.corp.intel.com>
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
To: Ivor Hewitt <ivor-rtBon1mkn18@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


This is probably the acpid shutting down the system after successful
wakeup.
As it thinks the button event was for shut down.

Check whether you have acpid installed.
Check the acpid config file, whether it has anything like this.
	event=3Dbutton/power.*
	action=3D/sbin/shutdown -h now

Comment it if it is there and try again.

Thanks,
Venki=20

>-----Original Message-----
>From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org=20
>[mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of=20
>Ivor Hewitt
>Sent: Monday, September 27, 2004 11:49 AM
>To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>Subject: [ACPI] Z600 screen restore
>
>Hi,
>I have a Sony vaio Z600-hek (same as US model Z505). Which=20
>I've been trying to=20
>get working with ACPI for a while....
>
>On S3 restore the screen would power up and flash briefly and=20
>then power down=20
>immediately although the machine was now up and running.=20
>
>using "acpi_sleep=3Ds3_mode" makes no difference.
>"acpi_sleep=3Ds3_bios" causes the machine to crash on s3 restore.
>
>but if I comment out the two tests:-
>
>#       testl   $1, video_flags - wakeup_code
>#       jz      1f
>and
>#       testl   $2, video_flags - wakeup_code
>#       jz      1f
>
>the machine restores from s3 successfully and the screen=20
>powers up... so that=20
>appears to be the area of the problem...
>any suggestions what the 'correct' fix for this would be?
>
>Cheers,
>
>--=20
>Ivor Hewitt.
>http://www.ivor.it - tech | http://www.ivor.org - hedge
>
>
>-------------------------------------------------------
>This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
>Project Admins to receive an Apple iPod Mini FREE for your judgement on
>who ports your project to Linux PPC the best. Sponsored by IBM.
>Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
>_______________________________________________
>Acpi-devel mailing list
>Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>https://lists.sourceforge.net/lists/listinfo/acpi-devel
>


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
