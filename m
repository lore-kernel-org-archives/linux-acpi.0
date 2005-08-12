From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: Re: NX6125 has insane thermal trip values
Date: Fri, 12 Aug 2005 09:32:55 +0200
Message-ID: <42FC50A7.5090404@suse.de>
References: <20050811234836.GA32021@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050811234836.GA32021-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Matthew Garrett wrote:
> Booting a 64-bit kernel on an HP nx6125, the thermal trip values are set 
> to 16 degrees centigrate by default. This seems to be due to the 
> following block of code:
> 
>             If (LAnd (LEqual (\_SB.C031, 0x01), LAnd (LEqual (Arg0, 
> 0x00), LEqu\al (Arg1, 0x00))))
>             {
>                 If (\_SB.C046.C0AD.C110.C164 ())
>                 {
>                     Store (0x0B4B, Local2)
>                 }
>             }
> 
>             If (LEqual (\_SB.C046.C054.C055, 0x01))
>             {
>                 Store (0x0B4B, Local2)
>             }
> 
>             Return (Local2)
> 
> which appears to explicitly set those temperatures. I'm assuming that 
> this is only supposed to be triggered under a certain set of conditions, 
> but HP's insistence on replacing all of their object names with crap 
> makes me weep bitter tears of loathing and I really can't be bothered 
> tracking this down. I've attached the DSDT
Sorry, no DSDT attached.
> - can anyone see any obvious 
> reason why this code path should be triggered? I'll get in touch with HP 
> anyway, and see if they can fix it in a newer BIOS revision.
> 

I saw fixed temperatures embedded in an if/else clause quite often.
It seems as if BIOS programmers often misuse thermal zones to implement
a shutdown trigger for other purposes.

Normally only a critical trip point is exported and a temperature like
that is returned:

if (all_is_well)
      return temp_below_critical_tp;
else
      // trigger shutdown
      return temp_above_critical_tp;

As long as the temperature stays below, I wouldn't care.

This could get a problem if scripts like to automatically set tps according
to user configurations, as the kernel cuts of the position after the decimal
point.

The powersave daemon (sourceforge) can do that and triggered a critical shutdown
by only resetting the critical tp to the same value:
E.g. possible temperatures: 47 C, 49.9 C
critical BIOS trip point: 49.7 C

The kernel simply exports the rounded 50 C value as critical trip point (in fact 49.7).
Resetting it to 50 C triggers a shutdown.
If the /proc/acpi interface should ever be moved to /sys, people should consider to
export exact values to userspace if it is intended to be able to control fan activity,
which already works well on some laptops.

     Thomas



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
