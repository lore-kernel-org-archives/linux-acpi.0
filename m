From: Fred Labrosse <ffl-4CLdheC3Iye1Qrn1Bg8BZw@public.gmane.org>
Subject: Re: Re: Centrino speedstep
Date: Fri, 7 Jan 2005 11:05:13 +0000
Message-ID: <16862.27881.864389.196313@aber.ac.uk>
References: <20041229181834.GA19199@poupinou.org>
	<41D42E88.5080800@mega.ist.utl.pt>
	<m2llbfk931.fsf@phoenix.squirrel.nl>
	<41D43A9F.5050507@mega.ist.utl.pt>
	<16852.15668.315630.700537@phoenix.squirrel.nl>
	<41D4AA9F.7080200@mega.ist.utl.pt>
	<20041231082524.GA8312@dominikbrodowski.de>
	<16861.5376.560582.314813@aber.ac.uk>
	<20050106161440.GD10011@dominikbrodowski.de>
	<16862.25182.567350.575532@aber.ac.uk>
	<20050107105045.GA17839@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050107105045.GA17839-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Dominik Brodowski writes:
 > > 
 > > How can it not be the case that there is correlation between the two?  The
 > > processor produces heat
 > Yes.
 > 
 > > (less if throttling down, right?)
 > Not necessarily. Only if the average CPU load would be higher than
 > the rate the CPU is throttled to, i.e. if the CPU load is >= 100% for
 > siginifcant amounts of time[*]. If not the CPU is put into the same hardware
 > state ("idle state") because there is no work to do as if there were
 > throttling, i.e. if "x" means the CPU has work to do, "i" means the CPU is
 > in an idle mode, and "t" means the CPU is throttled, we see the following
 > behaviour:
 > 
 > Much work to do:
 > -----------------------------------> time
 > xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx	(no throttling)
 > xxttxxttxxttxxttxxttxxttxxttxxttxxtt	(throttling 50%)
 > 
 > (however, as the task now takes twice as long to complete, and the CPU still
 > consumes power in "t", the CPU does consume more energy than if it weren't
 > throttled. Only if the fan needs to run _because_ of the high CPU load and
 > it consumes more power than the CPU in throttling mode, throttling may save
 > energy.)
 > 
 > 50% load average
 > xixixixixixixixixixixixixixixixixixi	(no throttling)
 > xxttxxttxxttxxttxxttxxttxxttxxttxxtt	(throttling 50%)
 > 	=> as the CPU is in the same hardware state on "i" or "t", no power
 > 	   reduction is achieved because of throttling
 > 
 > 10% load average
 > xiiiiiiiiixiiiiiiiiixiiiiiiiiixiiii	(no throttling)
 > xittiittiittxittiittxittiittiittxit	(throttling 50%)
 > 	=> the same is true again ==> throttling doesn't save you anything
 > 

I was missing something (brain power?).  Very interesting.  Thank you for
that.

 > And as 100% CPU usage isn't that common on notebooks...

It is on mine... ;-).

Cheers,

Fred



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
