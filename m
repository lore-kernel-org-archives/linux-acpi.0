From: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>
Subject: Re: Re: Centrino speedstep
Date: Fri, 7 Jan 2005 11:50:45 +0100
Message-ID: <20050107105045.GA17839@dominikbrodowski.de>
References: <20041229181834.GA19199@poupinou.org> <41D42E88.5080800@mega.ist.utl.pt> <m2llbfk931.fsf@phoenix.squirrel.nl> <41D43A9F.5050507@mega.ist.utl.pt> <16852.15668.315630.700537@phoenix.squirrel.nl> <41D4AA9F.7080200@mega.ist.utl.pt> <20041231082524.GA8312@dominikbrodowski.de> <16861.5376.560582.314813@aber.ac.uk> <20050106161440.GD10011@dominikbrodowski.de> <16862.25182.567350.575532@aber.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <16862.25182.567350.575532-4CLdheC3Iye1Qrn1Bg8BZw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Fred Labrosse <ffl-4CLdheC3Iye1Qrn1Bg8BZw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Jan 07, 2005 at 10:20:14AM +0000, Fred Labrosse wrote:
> Dominik Brodowski writes:
>  > On Thu, Jan 06, 2005 at 10:37:52AM +0000, Fred Labrosse wrote:
>  > > Dominik Brodowski writes:
>  > >  > On Fri, Dec 31, 2004 at 01:25:51AM +0000, Pedro Venda wrote:
>  > >  > > also, how exactly can I use ACPI throttling? because with the speestep 
>  > >  > > driver, I can't go below 600MHz, but 12% of maximum frequency is 180MHz 
>  > >  > > which I can reach using ACPI throttling.
>  > >  > 
>  > >  > but throttling doesn't save you anything.
>  > >  > 
>  > > 
>  > > Well, it makes it run slightly cooler, so saves on fan power.  Or am I
>  > > mistaken?
>  > If there is indeed a correlation with the fan power, indeed. Usually this
>  > isn't the case, and then it doesn't matter at all.
>  > 
> 
> How can it not be the case that there is correlation between the two?  The
> processor produces heat
Yes.

> (less if throttling down, right?)
Not necessarily. Only if the average CPU load would be higher than
the rate the CPU is throttled to, i.e. if the CPU load is >= 100% for
siginifcant amounts of time[*]. If not the CPU is put into the same hardware
state ("idle state") because there is no work to do as if there were
throttling, i.e. if "x" means the CPU has work to do, "i" means the CPU is
in an idle mode, and "t" means the CPU is throttled, we see the following
behaviour:

Much work to do:
-----------------------------------> time
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx	(no throttling)
xxttxxttxxttxxttxxttxxttxxttxxttxxtt	(throttling 50%)

(however, as the task now takes twice as long to complete, and the CPU still
consumes power in "t", the CPU does consume more energy than if it weren't
throttled. Only if the fan needs to run _because_ of the high CPU load and
it consumes more power than the CPU in throttling mode, throttling may save
energy.)

50% load average
xixixixixixixixixixixixixixixixixixi	(no throttling)
xxttxxttxxttxxttxxttxxttxxttxxttxxtt	(throttling 50%)
	=> as the CPU is in the same hardware state on "i" or "t", no power
	   reduction is achieved because of throttling

10% load average
xiiiiiiiiixiiiiiiiiixiiiiiiiiixiiii	(no throttling)
xittiittiittxittiittxittiittiittxit	(throttling 50%)
	=> the same is true again ==> throttling doesn't save you anything

And as 100% CPU usage isn't that common on notebooks...

	Dominik



[*] (>0.1/0.5s ?)


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
