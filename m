From: Joshua Wise <joshua-NtISFavHD68j5TC/SZClsA@public.gmane.org>
Subject: ACPI on hp tc1100
Date: Sat, 04 Dec 2004 23:40:13 -0500
Message-ID: <41B2912D.8020105@joshuawise.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Hi all,

I'd like to start off this email by commending the authors of the ACPI 
drivers for Linux. I've done a little bit of looking into fixing the 
DSDT for the hp tc1100, and in my research, I gained quite an 
appreciation for what an endeavour it must be to write something to 
parse this, make sense out of it, and then act properly on it.

Anyway, without further ado, here's my status report for hp tc1100:

* No crashes on boot. That's good.

* The device does the Right Thing in terms of going on battery and off 
battery.

* ACPI detects the multiple clock states available to the processor, and 
seems to be able to act on them.

* ACPI detects the battery and can figure out its charge state.

* When the device is commanded to go into standby (S0) via the following 
command ...
	# echo standby > /sys/power/sleep
   ... the device turns its screen black, then restores the contents of 
the screen by repainting. The system is then as it was left.

* When the device is commanded to suspend to ram (S3) via the following 
command ...
	# echo mem > /sys/power/sleep
   ... the system does any one of a number of things.

   - The system can fail to acquire some semaphore as reported in the 
system log. It will then fail to go to sleep.
   - If the nvidia binary-only driver has been loaded, and X has been 
run within that cycle of loading the nvidia driver, then the system goes 
to sleep. When commanded to wake through the power switch, the system 
will switch to a console momentarily, print some debugging messages, 
then blank the screen and seemingly halt.
   - If the nvidia binary-only driver has been loaded, and X has not 
been run within that cycle of loading the nvidia driver, then the system 
goes to sleep. When commanded to wake through the power switch, the 
system will go back to the console in which the system was left. The 
system will be functional, except for the wireless driver, as will be 
mentioned below. If X is run in this load cycle of the nvidia 
binary-only driver, the system's display will blank and the system will 
seemingly halt.
   - If the nvidia binary-only driver has not been loaded, then the 
system goes to sleep. When commanded to wake through the power switch, 
the system will go back to the console in which the system was left. The 
system will be functional, except for the wireless driver, as will be 
mentioned below.

* After the device has been woken, the internal ipw2100 wireless card 
will no longer function. Reloads of the module will succeed, but no card 
will be detected.

* The device seems to run very warm, and the fan is almost always on. I 
am not sure whether this is a function of running Linux, or whether this 
has always happened -- Windows was only running on this device for about 
two or three hours before Debian was loaded on it.

* The wacom_acpi patch provided by Jamey Hicks seems to work out of the 
box on 2.6.9, although with the latest ACPI patches, it seems that 
acpi_get_current_resources has been deprecated. What is the replacement 
for that?

Does anyone have any insight to the problems seen? If you need more 
detail, feel free to reply.

Thanks for all the great work!
joshua


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
