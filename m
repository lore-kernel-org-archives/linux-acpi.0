From: Greg Sarjeant <greg-QNIYhHqVzB9kr2E5YSwMOQ@public.gmane.org>
Subject: Re: PROBLEM: ACPI crashes (2.6.2-rc2-mm1)
Date: Thu, 29 Jan 2004 07:03:46 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1075377825.5640.7.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
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

Looks like this didn't get through last night. Let me try it again.



Hi,

  Just wanted to add my experience. I was able to suspend to disk and
resume just fine from a console with the following configuration on the
Gateway 200X.

kernel 2.6.1
agpgart module loaded
intel_agp module loaded
i830 module loaded
swsusp compiled into the kernel
ACPI sleep states compiled into the kernel
suspend with 'echo 4 > /proc/acpi/sleep'

   When I tried this after starting X with startx, I got the reboot loop
described by others. I figured I'd give it a shot, since the AGP modules
didn't interfere with the console suspend/resume. Ah well. 

   Interestingly, starting X and then dropping back into a console
caused problems, too. I didn't get stuck in a reboot loop, but the
resume just hung. It did get past the 'Waiting for DMA to settle down'
message, though. I can't remember now exactly what it said, but it
seemed to be mostly done. I had to do a hard reboot to get it back, and
then I had to do the 'noresume; mkswap; swapon' routine.

   I haven't tried unaccelerated X, since the AGP modules seem to be
loaded regardless of what I do (remove the agpgart alias in
/etc/modules.conf, remove X from default runlevel, etc) and I cannot
unload them. I guess I should try compiling a kernel without AGP support
at all next.

   Thanks,
    Greg



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
