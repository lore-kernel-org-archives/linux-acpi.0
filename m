From: Hiroshi 2 Itoh <HIROIT-JE5g2YyFxFHQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] [suspend/resume] wrong wakeup address
Date: Sun, 17 Oct 2004 02:39:19 +0900
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <OFBB541BAC.1982118D-ON49256F2F.00592938-49256F2F.006086C1@jp.ibm.com>
References: <16A54BF5D6E14E4D916CE26C9AD30575546CFA@pdsmsx402.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <16A54BF5D6E14E4D916CE26C9AD30575546CFA-4yWAQGcml66iAffOGbnezLfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org





Hi, Shaohua-san,

I had a glance at your patch and zapped also the codes around ACPI sleep
area.

acpi_wakeup_address is the entry address of wakeup_start() routine jumped
from firmware, which is switching from real mode to protected mode. So its
virtual and physical address must be identical for switching.  See "9.9
Mode Swtching" in IA-32 Intel Architecture Software Developer's Manual.

Can acpi_reserve_bootmem() routine reserve such identical memory to switch
the processor mode?

If so, the virt_to_phys implementation is not required. While if not,
init_low_mapping() treating page directory in acpi_save_state_mem() and
your virt_to_phys() patch are working in pair.

After adding your patch, both are no longer independent each other. I
wonder why waking vector setting is in acpi_pm_prepare(), not in
acpi_pm_enter() with acpi_save_state_mem().

Thanks for your patch.
Hiroshi Itoh
hiroit-JE5g2YyFxFHQT0dZR+AlfA@public.gmane.org



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
