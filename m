From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Several problems with sleep states
Date: Fri, 27 Feb 2004 11:33:12 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040227103312.GM2869@poupinou.org>
References: <403F0BA9.6060905@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <403F0BA9.6060905-L2FTfq7BK8M@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nicolas Sabouret <Nicolas.Sabouret-L2FTfq7BK8M@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Feb 27, 2004 at 10:19:37AM +0100, Nicolas Sabouret wrote:
> Hi,
> 
> following problems:
> 1. echo -n "disk" > /sys/power/state => nothing happens
> 2. echo -n "mem" > /sys/power/state => the computer enters "suspend on 
> ram" mode (the suspend light gets on, etc...) when I try to wake up the 
> computer, it hangs (some noise indicating that the disks are woken up 
> and then nothing but a blank screen, even starting from console).

You should try with swsusp instead and with /proc/acpi/sleep by now.
pmdisk apparently does support only S4BIOS (and you don't have s4bios,
looking the dmesg), not S4.

> 
> 3. It has certainly nothing to do with what I said before, but I cannot 
> find a /proc/acpi/processor/CPU0/performance (I have all the other files 
> you mention in your Documentation section).

It has been deprecated.  Look at /sys/devices/system/cpu0/cpufreq instead.

Cheers,

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
