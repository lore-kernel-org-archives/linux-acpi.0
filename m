From: Nathan Bryant <nbryant-p32f3XyCuykqcZcGjlUOXw@public.gmane.org>
Subject: Re: "irq 11: nobody cared" after S3
Date: Mon, 02 Aug 2004 22:21:07 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <410EF693.1000009@optonline.net>
References: <B44D37711ED29844BEA67908EAF36F03768BD0@pdsmsx401.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <B44D37711ED29844BEA67908EAF36F03768BD0-4yWAQGcml65pB2pF5aRoyrfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: stefandoesinger-RbZlAiThDcE@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Li, Shaohua wrote:

>I don't think your patch works, and even it works for your system, it
>will break other systems. The goal of 'setonboot' is to prevent setting
>LINK device's IRQ every time, which we added last year. Without it, many
>systems will break. IIRC, its goal is to resolve a bug in bugzilla. But
>currently I don't remember the exact bug number.
>  
>
Hi, Shaohua,

I did some research on this, and came up with the original ChangeSet 
that introduced setonboot:

ChangeSet 1.1046.1.424 2003/07/29 13:28:32 agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org
  ACPI: Allow irqs > 15 to use interrupt semantics other than PCI's standard
  active-low, level trigger. Make other changes as required for this.  
(Andrew de Quincey)

It looks like the setonboot flag was only introduced because calling the 
BIOS again might reset the edge/level and low/high flags. Judging by the 
ChangeSet message, the extra BIOS calls were not originally a problem, 
but getting rid of them was required for the additional edge/level feature.

If I can write my patch in such away that the link reconfiguration only 
gets called ONCE upon S3 resume, with interrupts disabled, and then 
resets the edge/level flags before re-enabling interrupts, will this be 
OK with you? This would save lots of work on several different low-level 
drivers. It might also fix the regressions that people are reporting 
with the ELCR save/restore patch.

This should be less of a "workaround" -- not at all of one, I hope ;)

Nathan


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
