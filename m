From: Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>
Subject: Re: APM, ACPI and DPMS question
Date: Fri, 24 Sep 2004 15:47:52 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040924134752.GC5746@message-id.gmane0305.slipkontur.de>
References: <4146E980.8040501@kn.vutbr.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4146E980.8040501-nd92eFGgBBntwjQa/ONI9g@public.gmane.org>
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

On Tue, Sep 14, 2004 at 02:52:16PM +0200, Jan Bernatik wrote:
> Hi,
> 
> I'm studying ACPI, and I found that:
> 
> ----------------------------------------------------------------------
> You should also be aware of another little glitch I discovered. The 
> XFree86 server has an option for DPMS (Energy Star) features. The DPMS 
> can states can be one of standby, suspend, off or on. Since the 2.4.x 
> kernels cannot suspend to disk, this can cause problems.

suspend to disk has nothing to do with DPMS at all. 
> ----------------------------------------------------------------------
> source: http://www.tldp.org/HOWTO/ACPI-HOWTO/daemons.html

well, this document is simply plain wrong in this regard.
 
> I really doesn't understand this. I thought it's just about monitor 
> energy, so please could somebody just roughly explain this ?

DPMS is monitor "standby", "suspend" and "off". It has nothing to do with
system power management, ACPI, APM or suspend to disk / RAM.

Maybe you shold write the author of the ACPI-HOWTO and tell him.
-- 
Stefan Seyfried



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
