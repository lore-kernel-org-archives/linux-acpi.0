From: Nathan Bryant <nbryant-p32f3XyCuykqcZcGjlUOXw@public.gmane.org>
Subject: Re: acpi-20040715: functional regression on ASUS M2N
Date: Fri, 06 Aug 2004 13:07:33 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <4113BAD5.1030909@optonline.net>
References: <4112814C.2070808@optonline.net> <m37jsc3424.fsf@reason.gnu-hamburg> <41138944.3060309@optonline.net> <m3u0vgurzy.fsf@reason.gnu-hamburg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <m3u0vgurzy.fsf-glUV91rXKAHWIjgkaejU9x2eb7JE58TQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Georg C. F. Greve" <greve-mXXj517/zsQ@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Georg C. F. Greve wrote:

> Here is what it said for my machine during resume from suspend to ram:
> 
>   i8259: saving ELCR: 0xfffffff0 0x0a

Interesting. That translates into the following IRQ's set to level trigger:

4
5
6 (!) floppy controller?
7
9
11

But I don't think there's anything wrong with that. It does seem that 
Matthew Garrett's message holds the key:

He wrote:
> On Thu, 2004-08-05 at 14:49 -0400, Nathan Bryant wrote:
> 
> 
>>> The ELCR save/restore patch is causing regressions for some people. What 
>>> if the problem is that we're saving/restoring registers at the wrong time?
> 
> 
> On closer investigation, I found that the system was restoring my ioapic
> state /after/ it had started the programmable interrupt timer back up.
> Changing line 310 of drivers/base/sys.c to list_for_each_entry_reverse
> seems to have greatly improved my ability to suspend and resume (which
> worked fine before the interrupt controller suspend/resume patches,
> except that I didn't get many interrupts...) 
> 
> There doesn't seem to be any fine-grained way to control the order of
> suspend/resume for individual drivers. It seems to be assumed that
> everything that devices depend on will be higher than them in the tree,
> and so everything will "just work" - I'm not sure this is true. As
> another example, I just had my wireless card fail to resume correctly.
> It tried to do a hotplug firmware load on resume. Which was difficult,
> because it was resumed before the IDE interface was. How can this sort
> of thing be avoided?
> 
> -- Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org 




-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
