From: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: acpi-20040715: functional regression on ASUS M2N
Date: Mon, 9 Aug 2004 16:10:49 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <B44D37711ED29844BEA67908EAF36F03860585@pdsmsx401.ccr.corp.intel.com>
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
To: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Cc: Nathan Bryant <nbryant-p32f3XyCuykqcZcGjlUOXw@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Georg C. F. Greve" <greve-mXXj517/zsQ@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

I guess sysdev suffers from the problem much. Device core doesn't
maintain a tree for all sysdev. It's just a list, so PIC, LAPIC, PIT,
and so on may suspend/resume in random order. Don't know if it's indeed
an issue, but it looks crazy.=20

Thanks,
Shaohua

>-----Original Message-----
>From: Matthew Garrett [mailto:mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org]
>Sent: Friday, August 06, 2004 11:24 PM
>To: Nathan Bryant
>Cc: ACPI Developers; Li, Shaohua; Georg C. F. Greve
>Subject: Re: [ACPI] acpi-20040715: functional regression on ASUS M2N
>
>On Thu, 2004-08-05 at 14:49 -0400, Nathan Bryant wrote:
>
>> The ELCR save/restore patch is causing regressions for some people.
What
>> if the problem is that we're saving/restoring registers at the wrong
time?
>
>On closer investigation, I found that the system was restoring my
ioapic
>state /after/ it had started the programmable interrupt timer back up.
>Changing line 310 of drivers/base/sys.c to list_for_each_entry_reverse
>seems to have greatly improved my ability to suspend and resume (which
>worked fine before the interrupt controller suspend/resume patches,
>except that I didn't get many interrupts...)
>
>There doesn't seem to be any fine-grained way to control the order of
>suspend/resume for individual drivers. It seems to be assumed that
>everything that devices depend on will be higher than them in the tree,
>and so everything will "just work" - I'm not sure this is true. As
>another example, I just had my wireless card fail to resume correctly.
>It tried to do a hotplug firmware load on resume. Which was difficult,
>because it was resumed before the IDE interface was. How can this sort
>of thing be avoided?
>
>--
>Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org



-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
