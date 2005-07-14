From: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Fw: Followup on 2.6.13-rc3 ACPI processor C-state regression
Date: Thu, 14 Jul 2005 11:00:29 +0800
Message-ID: <16A54BF5D6E14E4D916CE26C9AD3057502AA9A8C@pdsmsx402.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
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
To: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, radsaq-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

There is a patch from Jindrich which should fix your issue. See
http://sourceforge.net/mailarchive/forum.php?thread_id=3D7640723&forum_id=
=3D
6102

Thanks,
Shaohua
>-----Original Message-----
>From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-
>admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Andrew Morton
>Sent: Thursday, July 14, 2005 7:14 AM
>To: Brown, Len
>Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>Subject: [ACPI] Fw: Followup on 2.6.13-rc3 ACPI processor C-state
>regression
>
>
>There's another regression being reported over on lkml.
>
>Begin forwarded message:
>
>Date: Wed, 13 Jul 2005 18:05:30 -0400
>From: Kevin Radloff <radsaq-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>Subject: Followup on 2.6.13-rc3 ACPI processor C-state regression
>
>
>Previously, I had said that in 2.6.13-rc3, C2/C3 capabilities were not
>detected on my Fujitsu Lifebook P7010D. I found that in the merge at:
>
>http://kernel.org/git/?p=3Dlinux/kernel/git/torvalds/linux-
>2.6.git;a=3Dblobdiff;h=3D893b074e3d1a48a4390cf84b4c1a10ef6be2460c;hp=3Dc=
9d671
cf78
>57dbc7101e99d469fa24eed711ac60;hb=3D5028770a42e7bc4d15791a44c28f0ad53932=
3
807;
>f=3Ddrivers/acpi/processor_idle.c
>
>.. in the section at (please forgive my destruction of the formatting)
...
>
>@@ -787,10 +843,7 @@ static int acpi_processor_get_power_info
>         if ((result) || (acpi_processor_power_verify(pr) < 2)) {
>             result =3D acpi_processor_get_power_info_fadt(pr);
>             if (result)
>-                return_VALUE(result);
>-
>-            if (acpi_processor_power_verify(pr) < 2)
>-                return_VALUE(-ENODEV);
>+               result =3D =
acpi_processor_get_power_info_default_c1(pr);
>         }
>
>.. a call to acpi_processor_power_verify() is removed, which breaks
>detection of C2/C3 capabilities if the above
>acpi_processor_get_power_info_cst() failed. It it had succeeded (and
>returned 0), then acpi_processor_power_verify() is called in the
>conditional statement, which will set the valid flags for C2/C3. But
>if it fails, like on my laptop, then the valid flags will never be
>set, despite the fact that the acpi_processor_get_power_info_fadt()
>function finds the necessary info for a subsequent
>acpi_processor_power_verify() call to succeed.
>
>I don't know what exactly the proper fix here is (with the
>introduction of the acpi_processor_get_power_info_default_c1()
>function, that is), but simply reversing this part of the patch fixes
>detection of C2/C3 on my laptop.
>
>Please CC me with any followups, as I'm not on the list.
>
>--
>Kevin 'radsaq' Radloff
>radsaq-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
>http://saqataq.us/
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
>the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>-------------------------------------------------------
>This SF.Net email is sponsored by the 'Do More With Dual!' webinar
>happening
>July 14 at 8am PDT/11am EDT. We invite you to explore the latest in
dual
>core and dual graphics technology at this free one hour event hosted by
HP,
>AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
>_______________________________________________
>Acpi-devel mailing list
>Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
