From: Dominik Brodowski <linux-JhLEnvuH02M@public.gmane.org>
Subject: Re: Processor dynamic power management for desktop machines
Date: Thu, 6 Nov 2003 07:52:16 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031106065216.GB4188@brodo.de>
References: <3FA97E0E.6060906@nickhill.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3FA97E0E.6060906-kMuUVokNkCa9FHfhHBbuYA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nick Hill <nick-kMuUVokNkCa9FHfhHBbuYA@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Nov 05, 2003 at 10:47:42PM +0000, Nick Hill wrote:
> I have a desktop system based on an AMD Athlon XP2200+ running Linux 
> Kernel 2.6.0-test9
> 
> The processor is not a notebook type and does not support powernow!
> 
> I have a power meter connected to the mains supply of the desktop 
> machine, which provides a constant reading of power demand.
> 
> With the machine not under processing load, I have noticed a substantial 
> difference in power demand between the throttling state t0 and 
> throttling state t15. The power demand drops by between 21 and 36 watts.
> 
> As the demand waveform of the machine does not folow ohm's law, the 
> power meter fluctuates as it samples different parts of the power 
> waveform. When on t0, the reading fluctuates between 56 and 96w. T15 
> between 35 and 60watts demand.
> 
> The machine doubles as a desktop and server. The machine therefore needs 
> to be powered on constantly. As the server processes are not generally 
> processor intensive, the machine could be on t14 when not being used as 
> a desktop machine.
> 
> Being an ecologically conscientious type, I have set up a shell script 
> to allow me to easily change the processor throttling level. t0 
> (compiling etc) t10 (normal desktop use) and t14 (Leaving it on overnight).
> 
> Are there plans for a system to modulate power demand for desktop 
> machines? My set up demonstrates substantial power saving is feasible 
> with an inelegant userspace daemon (me!).

Indeed, there is. Check the "cpufreq" project. While it currently does not
use ACPI-based throttling for "frequency scaling", there is work going on to
support dynamic adaption of CPU frequency levels based on system load, user
preferences, etc.

	Dominik


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
