From: Dominik Brodowski <linux-JhLEnvuH02M@public.gmane.org>
Subject: Re: Why does my CPU switch to high speed?
Date: Fri, 22 Nov 2002 21:14:44 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021122201444.GD2117@brodo.de>
References: <m2heeqna6t.fsf@tnuctip.rychter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <m2heeqna6t.fsf-dTJq59+VGzkkCw8IV3R6h0EOCMrvLtNR@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jan Rychter <jan-JAsPCFd0eodBDgjK7y7TUQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sat, Nov 09, 2002 at 02:29:14PM +0100, Jan Rychter wrote:
> What makes my CPU (Intel Pentium IIIm, speedstep) switch to maximum
> performance mode?
> 
> ACPI says:
> 
> [14:25] tnuctip:/root#cat /proc/acpi/processor/CPU0/performance 
> <not supported>
> [14:27] tnuctip:/root#
> 
> if I use the "speedstep" utility to set the clock to half-speed (works
> great), everything is fine, until the machine wants to spend a lot of
> CPU in kernel space (ACPI eating CPU or my wireless network drivers
> crashing and eating CPU). Then the CPU somehow switches to maximum
> performance.
What "speedstep" utility? Marc's program? Or cpufreq?

	Dominik


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
