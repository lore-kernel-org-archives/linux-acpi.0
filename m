From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Early init patch breaks Dell laptops
Date: Sat, 9 Oct 2004 23:26:32 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3ACA40606221794F80A5670F0AF15F8405BD1224@pdsmsx403>
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
To: Daniel Drake <dsd-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

=20
Would you please try boot option nolapic?

Thanks,
Luming

>-----Original Message-----
>From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org=20
>[mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of=20
>Daniel Drake
>Sent: Saturday, October 09, 2004 10:08 PM
>To: Brown, Len
>Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>Subject: [ACPI] Early init patch breaks Dell laptops
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
