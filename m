From: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Subject: Re: Re: Centrino speedstep
Date: Fri, 07 Jan 2005 15:49:51 -0800
Message-ID: <41DF201F.50006@root.org>
References: <20041229181834.GA19199@poupinou.org>	<41D42E88.5080800@mega.ist.utl.pt>	<m2llbfk931.fsf@phoenix.squirrel.nl>	<41D43A9F.5050507@mega.ist.utl.pt>	<16852.15668.315630.700537@phoenix.squirrel.nl>	<41D4AA9F.7080200@mega.ist.utl.pt>	<20041231082524.GA8312@dominikbrodowski.de>	<16861.5376.560582.314813@aber.ac.uk>	<20050106161440.GD10011@dominikbrodowski.de>	<16862.25182.567350.575532@aber.ac.uk>	<20050107105045.GA17839@dominikbrodowski.de> <16862.27881.864389.196313@aber.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <16862.27881.864389.196313-4CLdheC3Iye1Qrn1Bg8BZw@public.gmane.org>
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
Cc: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Fred Labrosse wrote:
> Dominik Brodowski writes:
>  > (however, as the task now takes twice as long to complete, and the CPU still
>  > consumes power in "t", the CPU does consume more energy than if it weren't
>  > throttled. Only if the fan needs to run _because_ of the high CPU load and
>  > it consumes more power than the CPU in throttling mode, throttling may save
>  > energy.)
>
> I was missing something (brain power?).  Very interesting.  Thank you for
> that.

It's non-intuitive since power consumption is an integral (i.e., the sum 
of individual power usage over time t).  The area under the curve is 
what you care about.

For interactive use, the best scheduling algorithm for CPU idling is to 
run the CPU at 100% performance until there are no runnable tasks, then 
slam it to the lowest Cx state until woken by the next timer tick or 
interrupt.  Since even slow C3 transitions on most platforms are 200 
microseconds or less and given a HZ value of 1000, you still get 600 us 
of sleeping at C3 (3x the latency of a transition.)  The longer-latency 
cpufreq transition is different, in that you should go to the lowest CPU 
state once you have M wakeups over N amount of time but only a small 
number of runnable tasks in that time period.  Tune M and N based on the 
latency of cpufreq transitions for a platform.

With even speedstep transitions being less than a millisecond, there is 
no reason not to use it more.

-- 
Nate


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
