From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: Re: Centrino question
Date: 27 May 2004 02:13:25 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1085638405.17692.59.camel@dhcppc4>
References: <3ACA40606221794F80A5670F0AF15F84046AA243@PDSMSX403.ccr.corp.intel.com>
	 <20040522005658.640e1d91.neurowork@free.fr>
	 <1085282649.12352.739.camel@dhcppc4>
	 <20040523132122.6ba363b4.neurowork@free.fr>
	 <1085415078.12941.2.camel@Neuromancer.home.net>
	 <20040525072725.GA12282@message-id.gmane0305.slipkontur.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040525072725.GA12282-l0tNAEGuAhhzZ8+rp42Dbp9+tswZ0GTaehPwdyo5hKaELgA04lAiVw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Stefan
The LAPIC TSC is not reliable when C3 runs.

Indeed, we need to either disable the TSC if C3 is enabled,
or disabled C3 if the TSC is used.

-Len

http://bugme.osdl.org/show_bug.cgi?id=2560

On Tue, 2004-05-25 at 03:27, Stefan Seyfried wrote:
> On Mon, May 24, 2004 at 09:11:18AM -0700, Ow Mun Heng wrote:
> > On Sun, 2004-05-23 at 06:21, Cyril Wattebled wrote:
> > > On 22 May 2004 23:24:10 -0400
> > > Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> > > > Linux slows the processor to 600MHz when Windows gets down to 200MHz?
> > 
> > Len,
> > 
> > 	On my system, either 2.4 or 2.6 kernel, running on battery, cpufreq is at 600Mhz but
> > if i were running gkrellm, the x86info plugin will show that the cpufreq is actually fluactuating 
> > between 99 to 200 mHz. I'm not sure where this plugin gets it's data but..
> 
> I am quite sure that this is due to the tool you are using and due to C3 usage.
> I don't know about the gkrellm x86info plugin, but the suse 9.1 powersaved
> has a function to get the "real" CPU speed. It goes something like this:
> 
> float getRealProcessorSpeed() {
> 
>         /* get this function in cached memory */
>         gettimeofday(&tvstart, NULL);
>         __asm__ volatile ("rdtsc" : "=A" (x));
>         cycles[0] = x;
>         gettimeofday(&tvstart, NULL);
> 
>         /* we don't trust that this is any specific length of time */
>         sleep_left = sleep(1);
>         if (sleep_left || errno == EINTR)
>                 return -1.0;
>         __asm__ volatile ("rdtsc" : "=A" (x));
>         cycles[1] = x;
>         gettimeofday(&tvstop, NULL);
>         microseconds = ((tvstop.tv_sec-tvstart.tv_sec)*1000000) +
>                 (tvstop.tv_usec-tvstart.tv_usec);
> 
>         ret = (float)(cycles[1]-cycles[0])/microseconds;
>         return ret;
> }
> 
> There is of course some more checking around, it is only working on i386, 
> not on ia64.  This shows me:
> 
> seife-4N56LNXDvWs@public.gmane.org:~> powersave -r
> 82.559082 MHz
> 
> but from /sys/.../scaling_setspeed i see that my cpu is running on 600mhz.
> 
> seife-4N56LNXDvWs@public.gmane.org:~> cat /proc/acpi/processor/CPU0/power 
> active state:            C3
> default state:           C1
> bus master activity:     00000000
> states:
>     C1:                  promotion[C2] demotion[--] latency[000] usage[00020000]
>     C2:                  promotion[C3] demotion[C1] latency[002] usage[00737909]
>    *C3:                  promotion[--] demotion[C2] latency[205] usage[35772579]
> 
> if i force C2 state (by plugging in a usb mouse or playing sound), it shows
> the frequency correct:
> 
> seife-4N56LNXDvWs@public.gmane.org:~> powersave -r
> 598.058594 MHz
> 
> seife-4N56LNXDvWs@public.gmane.org:~> cat /proc/acpi/processor/CPU0/power 
> active state:            C2
> default state:           C1
> bus master activity:     ffffffff
> states:
>     C1:                  promotion[C2] demotion[--] latency[000] usage[00020850]
>    *C2:                  promotion[C3] demotion[C1] latency[002] usage[00770669]
>     C3:                  promotion[--] demotion[C2] latency[205] usage[35825285]
> 
> So the effects you are seeing are clearly related to a tool that is measuring
> wrong.



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
