From: Tod Morrison <trmorris-CxZjHwuTSy8Y3NgEzsZOoze48wsgrGvP@public.gmane.org>
Subject: S1 resume stopped working
Date: Thu, 17 Jun 2004 11:43:00 -0600 (MDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.44.0406171127200.9804-100000@math.cudenver.edu>
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

Hello,

I just trying to track down the source of the problem. Currently I can 
suspend and resume (S1) using the 2.6.5-gentoo kernel as long as I unload 
the alsa modules first. I just tried the vanilla 2.6.7 kernel with the 
same config (zcat /proc/config.gz > .config ; make oldconfig ) and cannot 
resume. Suspend works fine, but on resume I make it as far as "PM: 
Finishing up." and locks up.

Anyway, by inserting some pr_debug statements I've tracked it down to a 
section of code in resume.c where it traverses a list of devices changing 
their power state and it appears to go through about eight devices before 
it locks. I'd like to see if I can track down which device is causing the 
problem, but I don't really know my way around the kernel much any more. 
Could someone give me an example of how to print out which device I'm at 
given a "struct device" and maybe something like pr_debug()?

Of course if anyone just knows what changed between 2.6.5-gentoo and 2.6.7 
that is causing this, that info would make this exercise unnecessary. :)

-- 
Tod Morrison <tmorriso-o2OswTf4RFv//ikEAC0814dd74u8MsAO@public.gmane.org>
   http://math.cudenver.edu/~tmorriso



-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
