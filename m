From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Inconsistent contents of /proc/acpi/sleep and /sys/power/state
Date: Mon, 25 Jul 2005 18:05:32 +0200
Message-ID: <20050725160531.GB1046@openzaurus.ucw.cz>
References: <20050725090421.GA24084@tangens.sinus.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20050725090421.GA24084-hxMeMO63rIAUgFT2KJq8fg@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Troller <patrol-FIBU9iiavH4@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

>   I would like to ask, why the contents of /proc/acpi/sleep and /sys/power/state
> is different:
> 
> root@miro:~# cat /proc/acpi/sleep
> S0 S3 S4 S5
> root@miro:~# cat /sys/power/state
> standby mem disk
> 
>   The first one corresponds with a real functionality - for example, in dmesg
> there is the line
> ACPI: (supports S0 S3 S4 S5)
> on my notebook.
>   The second one seems to be wrong: There is "standby", although I have neither
> S1 nor S2 capable system - and it's really not working, and S5 is missing
> (should there be something like "off" in /sys/power/state ?).
>   I'm asking because /proc/acpi/sleep has been obsoletized in latest kernels and
> IMHO /sys/power/state is not a fully-featured and working replacement.
> 

Agreed, feel free to submit a patch.
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
