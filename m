From: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Subject: Timer interrupts after CPU speed change
Date: Wed, 26 Mar 2003 19:06:52 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030326190652.GA12645@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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

For reasons that (as yet) aren't entirely clear to me, suspending my
laptop to S3 when it's on battery results in it failing to resume
correctly (hard drive LED comes on and stays on - it's probably a DMA 
issue or something similarly entertaining, but I've got no console once 
it resumes so it's hard to tell). However, booting on battery, 
connecting it to AC and then suspending allows a resume to work. The 
problem is as follows:

When booting on battery, the CPU runs at 133MHz. As far as I've been 
able to tell, this machine doesn't support Speedstep (it's a mobile PIII 
500, and the Intel information I've found seems to suggest that 
Speedstep only appeared with the 600s) and from poking various registers 
it seems to accomplish this by using throttling (if I force those 
registers to the values that change when changing between AC and 
battery, the selected throttling value in /proc/acpi/ changes).

Attaching power results in the processor speeding up again (and, though 
I haven't checked, I /think/ that just starting ACPI when on battery 
actually results in it running at full speed). If I now suspend, carry 
my laptop around for a while, attach it to power and resume, the system 
timer starts firing at 4096Hz rather than 1024Hz with fairly predictable 
consequences. /proc/cpuinfo continues to say that the processor is 
133MHz, though it's now running happily at 500 (and was running at 500 
before being suspended as well).

Is there any obvious fix for this?

Thanks,
-- 
Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org


-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
