From: Nick Hill <nick-kMuUVokNkCa9FHfhHBbuYA@public.gmane.org>
Subject: Processor dynamic power management for desktop machines
Date: Wed, 05 Nov 2003 22:47:42 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3FA97E0E.6060906@nickhill.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I have a desktop system based on an AMD Athlon XP2200+ running Linux 
Kernel 2.6.0-test9

The processor is not a notebook type and does not support powernow!

I have a power meter connected to the mains supply of the desktop 
machine, which provides a constant reading of power demand.

With the machine not under processing load, I have noticed a substantial 
difference in power demand between the throttling state t0 and 
throttling state t15. The power demand drops by between 21 and 36 watts.

As the demand waveform of the machine does not folow ohm's law, the 
power meter fluctuates as it samples different parts of the power 
waveform. When on t0, the reading fluctuates between 56 and 96w. T15 
between 35 and 60watts demand.

The machine doubles as a desktop and server. The machine therefore needs 
to be powered on constantly. As the server processes are not generally 
processor intensive, the machine could be on t14 when not being used as 
a desktop machine.

Being an ecologically conscientious type, I have set up a shell script 
to allow me to easily change the processor throttling level. t0 
(compiling etc) t10 (normal desktop use) and t14 (Leaving it on overnight).

Are there plans for a system to modulate power demand for desktop 
machines? My set up demonstrates substantial power saving is feasible 
with an inelegant userspace daemon (me!).

If there are 50 million GNU/Linux machines powered-on worldwide (this is 
a guestimate) and a power saving of 22 watts could be achieved, on 
average per machine, this would translate to a global energy saving of 
1.1Gigawatt. As a substantial amount of power is lost in the power 
delivery infrastructure, this would translate to a saving of 1.7Gigawatt 
generating capacity worldwide, or $56,000 per hour at average production 
prices.





-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
