From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: Re: [Proposal]Another way to save/restore PCI config space
 for suspend/resume
Date: Wed, 27 Oct 2004 02:30:50 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <417F409A.5060409@intel.com>
References: <fa.fvou17m.1f5oa9u@ifi.uio.no> <fa.ivj042g.g5qnoo@ifi.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <fa.ivj042g.g5qnoo-6miFZF/5cTBuMpJDpNschA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, ACPI-DEV <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Li Shaohua wrote:
> On Tue, 2004-10-26 at 17:21, Pavel Machek wrote:

>>>Here is a another idea: 
>>>Record all PCI writes in Linux kernel...
>>
>>That looks extremely ugly to me. If you want to do something special
>>in resume function, just do it there. It will probably share a lot of
>>code with your init function, anyway.
> 
> How can you handle devices without driver? And how to save/restore
> config space for special devices, such as LPC bridge and host bridge?

Say that writing the missing drivers is the only workable solution.
Does anybody have an estimate of how many there are and how big
a task that would be?

-Len


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
