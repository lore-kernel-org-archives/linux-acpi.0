From: "Bryan K. Wright" <bryan-j2wAk2T2zOxQaOoIv/cCD/2DmoZIrT0C@public.gmane.org>
Subject: Bad interaction between ehci-hcd and acpi?
Date: Mon, 01 Mar 2004 12:08:07 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200403011708.i21H87b06973@ayesha.phys.Virginia.EDU>
Reply-To: bryan-utW8kV9oO443r0Ub5QXD9Q@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
Cc: bryan-j2wAk2T2zOxQaOoIv/cCD/2DmoZIrT0C@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

(Sorry if this is a duplicate.  I just realized that I wasn't subscribed
to acpi-devel.  I've subscribed now.)

Hi folks,

	The ehci-hcd kernel module enables support for high-speed USB
devices.  I've noticed the following oddity:  When I plug in a high-speed
USB device, the CPU temperature jumps up by about 25 degrees C.  The 
temperature stays up even after I unplug the USB device.  Rmmod'ing
the ehci-hcd module brings the temperature back down.  I can then
re-install the ehci-hcd module, and things stay normal until the next
time I plug in a high-speed USB device.

	Here are the configuration details:
Kernel 2.4.21 (vanilla) with the acpi-20030619-2.4.21.diff patch.
Sharp PC-AV18 laptop (KN266, Athlon XP-M 1800+)
Tested with two different models of Epson scanner, and with two different
brands of external USB disks.

	I've also recently tried using 'athcool', which enables
the VLink auto-disconnect bit and the 'bus disconnect on STPGNT' bit
(this was already set).  I'd hoped it might fix the odd behavior noted
above, but athcool doesn't seem to make any difference.

	Has anybody else seen similar symptoms?

						Thanks,
						Bryan

-- 
===============================================================================
Bryan Wright                |"If you take cranberries and stew them like 
Physics Department          | applesauce, they taste much more like prunes 
University of Virginia      | than rhubarb does."  --  Groucho 
Charlottesville, VA  22901  |			
(434) 924-7218              |         bryan-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org
===============================================================================




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
