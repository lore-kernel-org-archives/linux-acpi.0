From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Early init patch breaks Dell laptops
Date: Sun, 10 Oct 2004 03:13:03 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B3001A1938B@hdsmsx401.amr.corp.intel.com>
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
To: Daniel Drake <dsd-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I think the bug is that Linux
enables the LAPIC instead of believeing
the BIOS that it should be off:

+Local APIC disabled by BIOS -- reenabling.
+Found and enabled local APIC!

-Len=20

>-----Original Message-----
>From: Daniel Drake [mailto:dsd-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org]=20
>Sent: Saturday, October 09, 2004 10:08 AM
>To: Brown, Len
>Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>Subject: Early init patch breaks Dell laptops
>
>Hi Len,
>
>I'm one of the maintainers of Gentoo's kernel packages. I=20
>recently added your=20
>ACPI early-init patch into our 2.6.8 patchset in order to=20
>solve the problems=20
>you addressed
>
>http://bugs.gentoo.org/60565
>http://bugzilla.kernel.org/show_bug.cgi?id=3D2941
>
>After adding the "2.6.7 early init" patch, other users have run into=20
>ACPI-related problems (freezing on ACPI events). More=20
>specifically, Dell=20
>Inspiron laptops don't seem to like you :)
>
>According to these users, the issue is also present in=20
>(unmodified) 2.6.9-rc3,=20
>and reverting out the early-init patch seems to solve the problem.
>
>http://bugs.gentoo.org/66723
>http://bugs.gentoo.org/66804
>http://bugs.gentoo.org/66613
>
>A bug has been filed at the kernel bugzilla:
>
>http://bugzilla.kernel.org/show_bug.cgi?id=3D3532
>
>I hope this is useful- please ask if you need any more info.
>
>Thanks,
>Daniel
>


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
