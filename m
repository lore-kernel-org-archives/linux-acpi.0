From: Peter Meier <crazy-b-Mmb7MZpHnFY@public.gmane.org>
Subject: Suspend to ram broken for me with 2.6.5-mm3 (2.6.4 worked)
Date: Sat, 10 Apr 2004 17:21:49 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1081610508.10947.140.camel@homer>
Reply-To: crazy-b-Mmb7MZpHnFY@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
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

Hi,                                                                                                                              
actually, I'm not abled to wake up from suspend to ram with 2.6.5-mm3.
Monitor stays black, fans are making noise forever, but nothing. Network
is dead, too.
                                                                                                                              I had no problems with suspend to ram untill 2.6.4 (X with in10, unload usb and sound before sleep, use the fixpci script of Stefan Dösinger to get sound working after a wake up). I did not change any kernel configuration options or anything else. 2.6.5-rc2-mm5, 2.6.5-rc3-mm4 have the same problems, as 2.6.5-rc3-mm1, as all 2.6.5-mm*. So somewhere between 2.6.4 and 2.6.5-rc2 something changed which broke it for me.

The only difference I noticed so far is, with the 'broken' kernels, I
see "PM Entering state" as last thing before the system goes to sleep.
With the working kernels, I see more lines before the "PM Entering
state" and system goes to sleep (something with hda, acpi, etc., several
lines)

Notebook is an Acer Travelmate 803 (Radeon Mobility 9000, Centrino).
I'll provide further details on request.

With best regards,
Peter



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
