From: Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>
Subject: Re: Battery rate on Acer TM 292
Date: Mon, 13 Sep 2004 07:39:00 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040913053900.GB851@message-id.gmane0305.slipkontur.de>
References: <16A54BF5D6E14E4D916CE26C9AD305751B66D5@pdsmsx402.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <16A54BF5D6E14E4D916CE26C9AD305751B66D5-4yWAQGcml66iAffOGbnezLfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Sep 13, 2004 at 09:20:53AM +0800, Li, Shaohua wrote:
> >stefan@nano:~$ cat /proc/acpi/battery/BAT1/state
> >present:                 yes
> >capacity state:          ok
> >charging state:          discharging
> >present rate:            0 mA
> >remaining capacity:      3960 mAh
> >present voltage:         16376 mV

> Please don't trust 'present rate'. In many systems, 'present rate' are
> always 0.

There are actually a lot of systems where 'present rate' is pretty accurate
and there is ACER where it is always 0. I am in a dispute with ACER engineers
about this right now but they don't seem to understand the problem.
Of course this is a minor problem, but it is something which is done better
by the competitors.
I wonder if you get to see a estimated battery lifetime in Windows on these
machines.

> If you want to estimate the power of the battery, please use
> remaining capacity. I'd like the user daemon use 'remaining capacity' to
> calculate the rate.

Although this is possible, it is very low priority on my todo list since
it is needed only for ACER AFAICT and you get very bogus results shortly
after restarting the userspace daemon etc.
-- 
Stefan Seyfried



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
