From: Ow Mun Heng <Ow.Mun.Heng-Sjgp3cTcYWE@public.gmane.org>
Subject: Re: APM, ACPI and DPMS question
Date: Thu, 16 Sep 2004 09:51:29 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1095299489.11668.99.camel@neuromancer.home.net>
References: <4146E980.8040501@kn.vutbr.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <4146E980.8040501-nd92eFGgBBntwjQa/ONI9g@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, 2004-09-14 at 20:52, Jan Bernatik wrote:
> Hi,
> 
> I'm studying ACPI, and I found that:
> 
> ----------------------------------------------------------------------
> You should also be aware of another little glitch I discovered. The 
> XFree86 server has an option for DPMS (Energy Star) features. The DPMS 
> can states can be one of standby, suspend, off or on. Since the 2.4.x 
> kernels cannot suspend to disk, this can cause problems.
> ----------------------------------------------------------------------

I may be mistaken but.. I think I managed to get a 2.4 kernel on RH9
days to suspend to disk properly.

DPMS also works. Perhaps someone else can remember it much better.
> source: http://www.tldp.org/HOWTO/ACPI-HOWTO/daemons.html
> 
> I really doesn't understand this. I thought it's just about monitor 
> energy, so please could somebody just roughly explain this ?
> 
> thanks, have a nice day
> 
> Jan Bernatik

-- 
Ow Mun Heng
Fedora GNU/Linux Core 2 on D600 1.4Ghz CPU kernel
2.6.7-2.jul1-interactive 
Neuromancer 09:50:41 up 1 day, 34 min, 7 users, load average: 1.83,
1.21, 1.19 


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
