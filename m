From: Neil Brown <neilb-YbfuJp6tym7X/JP9YwkgDA@public.gmane.org>
Subject: How to disable wake-on-Lid Switch
Date: Wed, 9 Mar 2005 09:53:07 +1100
Message-ID: <16942.11475.596633.415660@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


hi,
 I have a problem with my notebook. (Dell Latitude D800).

 It suspends and resumes quite nicely (video, audio, etc all work
 well) so I'm quite happy.  But there is one little problem.

 The lid-switch seems to be a bit iffy.  Sometimes, while the laptop
 is put away snug in it's bag in suspend mode, the lid-switch suddenly
 thinks that the lid has been opened.  So it wakes up from suspend and
 starts generating heat.  As it is in a nicely padded bag, the heat
 doesn't go anywhere, so the temperature goes up up up.

 I would really like the lid button to *Not* resume from suspend.  I
 much prefer using the power button to do that.

 I have managed to fix it using:

diff ./drivers/acpi/scan.c~current~ ./drivers/acpi/scan.c
--- ./drivers/acpi/scan.c~current~	2005-03-08 21:07:21.000000000 +1100
+++ ./drivers/acpi/scan.c	2005-03-08 21:07:57.000000000 +1100
@@ -352,7 +352,7 @@ acpi_bus_get_wakeup_device_flags (
 
 	device->wakeup.flags.valid = 1;
 	/* Power button, Lid switch always enable wakeup*/
-	if (!acpi_match_ids(device, "PNP0C0D,PNP0C0C,PNP0C0E"))
+	if (!acpi_match_ids(device, "PNP0C0C,PNP0C0E"))
 		device->wakeup.flags.run_wake = 1;
 
 end:


But I have to apply this patch to each new kernel.  It would be better
to have some sysfs interface where I can
  echo 0 > /sys/firmware/acpi/namespace/_SB/LID/wakeup

or similar.
I am happy to try to knock together a patch, but I would like some
input first on what sort of interface would be appropriate.
Is namespace/_SB/LID the right place, or would
  echo 'power,lid' > /sys/power/wake_devs

be a more appropriate interface...  or maybe something I haven't even
thought of.

Thanks,
NeilBrown


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
