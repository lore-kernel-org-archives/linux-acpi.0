From: Daniel Drake <dsd-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Subject: Early init patch breaks Dell laptops
Date: Sat, 09 Oct 2004 15:08:28 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <4167F0DC.3010307@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Len,

I'm one of the maintainers of Gentoo's kernel packages. I recently added your 
ACPI early-init patch into our 2.6.8 patchset in order to solve the problems 
you addressed

http://bugs.gentoo.org/60565
http://bugzilla.kernel.org/show_bug.cgi?id=2941

After adding the "2.6.7 early init" patch, other users have run into 
ACPI-related problems (freezing on ACPI events). More specifically, Dell 
Inspiron laptops don't seem to like you :)

According to these users, the issue is also present in (unmodified) 2.6.9-rc3, 
and reverting out the early-init patch seems to solve the problem.

http://bugs.gentoo.org/66723
http://bugs.gentoo.org/66804
http://bugs.gentoo.org/66613

A bug has been filed at the kernel bugzilla:

http://bugzilla.kernel.org/show_bug.cgi?id=3532

I hope this is useful- please ask if you need any more info.

Thanks,
Daniel


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
