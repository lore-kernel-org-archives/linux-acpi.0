From: "Michael A. Smith" <mas3f-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org>
Subject: Problems with 600m PM states
Date: Wed, 31 Dec 2003 10:48:36 -0500 (EST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.BSF.4.55.0312311037060.49916@dea.intranet>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I have been unable to get any type of sleep to work with this laptop and
the 2.6.0 vanilla kernel.

Let's start with S1 and work up from there.

 echo 1 > /proc/acpi/sleep

Generates...

 Stopping tasks: ========|
 hdc: start_power_step(step: 0)
 hdc: completing PM request, suspend
 hda: start_power_step(step: 0)
 hda: start_power_step(step: 1)
 hda: complete_power_step(step: 1, stat: 50, err: 0)
 hda: completing PM request, suspend
 PM: Entering state.
  hwsleep-0257 [23] acpi_enter_sleep_state: Entering sleep state [S1]

...and it appears to be in standby.  The power led goes from solid on to
a blink.  Now, if I hit the power button to attempt resume, I get ...

 Back to C!
 PM: Finishing up.

... and that's it.  The power led is back on solid, but the system is
non-responsive.


For reference, I've tried to minimize the variables as much as possible.
I'm booting into single user mode and testing from there.  There are no
modules loaded.


Any help is appreciated, I'm happy to post more info or try any
suggestions.

Thanks,
Michael Smith
mas3f-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
