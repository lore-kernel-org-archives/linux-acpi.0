From: Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: Fwd: Acer Extensa 3001 battery problem (smart battery)
Date: Tue, 14 Sep 2004 16:02:16 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1095148936.14663.79.camel@sli10-desk.sh.intel.com>
References: <200409131113.01586.johannes.schanda@schanda.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200409131113.01586.johannes.schanda-1R9WWMedIqeELgA04lAiVw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Johannes Schanda <johannes.schanda-1R9WWMedIqeELgA04lAiVw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, 2004-09-13 at 17:13, Johannes Schanda wrote:
> On Monday 13 September 2004 03:15, Li, Shaohua wrote:
> > *snip*
> > Linux doesn't support smart battery yet. Smart battery is more
> complicated
> > than control method battery.
> >
> > Thanks,
> > Shaohua
> >
> Ah, ok. Thanks for clearing that up. 
> 
> I don't want to rush you or anything, you've all been doing a great
> job on 
> ACPI, but just for my information, when can we expect to see smart
> battery 
> support in linux? 
Hi, 
I did look at the spec. Basically we need two drivers for your issue.
1. EC based SMBus host driver. Your system has an EC based SMBus host.
ACPI spec defined a set of interfaces to control the SMBus host. Now we
haven't such SMBus driver.
2. Smart battery driver. It uses the interfaces exported from SMBus host
driver. Smart battery is resided on SMBus, OS must control SMBus host to
generate SMBus protocol to handle smart battery. 
I haven't such system with smart battery. It's hard to say when.

Thanks,
Shaohua



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
