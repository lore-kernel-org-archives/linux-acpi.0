From: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>
Subject: Re: passive cooling policy
Date: Wed, 8 Sep 2004 10:54:23 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040908085423.GA7785@dominikbrodowski.de>
References: <413CA0D9.5030901@renninger.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <413CA0D9.5030901-smMupaH/RwJM7kwft8N7nw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Thomas Renninger <mail-smMupaH/RwJM7kwft8N7nw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Thomas,

> 3) If passive limit is reached, kernel throttles cpu and tries to set 
> cpufreq to lowest step. Only way to find out whether machine is 
> passively cooled is in polling /proc/acpi/thermal_zone/*/state.
> (Is it right that cpufreq daemons poll this file to be informed of 
> kernel forced cpufreq slow downs?)

Why do cpufreq daemons want to know that? And the ordering is important:
first scale CPU frequency be means of cpufreq, _then_ throttle the CPU.

> 1) inform userspace that cpu speed is increased/decreased through a 
> thermal event.
> -> avoid userspace progs polling /proc/acpi/thermal_zone/*/state to be 
> informed whether the system is slowed down.

Again, I do not see a reason for why this needs to be exported to userspace.

> 2) Allow setting a passive trip point even BIOS does not export a 
> passive trip point value and initialise tc1, tc2 and tsp with some 
> sensible default values.
> -> you could lower fan activity on every laptop/workstation that 
> supports throttling/cpufreq regardless whether the BIOS exports any 
> passive trip points/cooling mode (event most laptop vendors don't care 
> about trip points).

As long as this allows an additional, probably lower "trip point" for
_passive_ cooling, this sounds like a good idea. It cannot hurt as long as
it doesn't disable the BIOS-initialized active cooling.

	Dominik


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
