From: Shawn Starr <shawn.starr-bJEeYj9oJeDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [2.6.12-rc1][ACPI][suspend] /proc/acpi/sleep vs /sys/power/state issue - 'standby' on a laptop
Date: Tue, 5 Apr 2005 14:56:20 -0400 (EDT)
Message-ID: <20050405185620.80060.qmail@web88009.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: 6667
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I'm working o

--- Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org> wrote:
> Hi!
> 
> > I've noticed something strange with issuing
> 'standby' to the system:
> > 
> > when echoing "standby" to /sys/power/state,
> nothing happens, not even a log or 
> > system activity to attempt standby mode.
> > 
> > However, trying echo "1" to /proc/acpi/sleep the
> system attempts to (standby) 
> > and aborts:
> > 
> > [4295945.236000] PM: Preparing system for suspend
> > [4295946.270000] Stopping tasks: 
> >
>
=============================================================================|
> > [4295946.370000] Restarting tasks... done
> > 
> > We get no reason as to why it quickly aborts. 
> 
> > [4294672.065000] ACPI: CPU0 (power states: C1[C1]
> C2[C2] C3[C3])
> > [4294676.827000] ACPI: (supports S0 S3 S4 S5)
> 
> 
> ...aha, but your system does not support S1 aka
> standby.
>  

Right, so nothing should happen if I try to do it, but
something does only in /proc/acpi/sleep does the
system attempt S1 which is not supported.

Do you know if /proc/acpi/sleep will be deprecated in
favour of /sys/power/state? If so, this thread will be
moot ;)

> > What is '1' in /proc/acpi/sleep?  standby mode is
> not the same as suspend to 
> > ram? when I put a normal desktop in standby mode
> its still 'on' but the hard 
> > disk is put to sleep and the system runs in a
> lower power mode. 
> 
> stanby != suspend to ram.

Correct, I wanted to be sure.

> 
> 				Pavel
> -- 
> 64 bytes from 195.113.31.123: icmp_seq=28 ttl=51
> time=448769.1 ms         
> 
> 


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
