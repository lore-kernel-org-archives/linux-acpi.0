From: Sourav K Mandal <smandal-DPNOqEs/LNQ@public.gmane.org>
Subject: Compaq Presario 2800T update
Date: Wed, 31 Jul 2002 12:48:42 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200207311648.MAA10977@buzzword-bingo.mit.edu>
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org



Hi all,

Here's a synopsis of what I've achieved with my laptop:

* After cleaning up the DSDT somewhat, I have battery
and fan entries and the battery state seems correct.
I get readouts for both batteries when I have the
expansion bay battery installed.  I am not required
to boot up w/o AC in order to have this functionality.
One curious note is that while the second battery is
being drawn (having more charge), the primary battery's
state is given as "unknown."

* In addition to changing "*PNP" to "PNP", I changed
the cryptic names of some devices to the standard ones
("AC", "BAT1", "BAT2") so the GNOME battstat applet 
will work (it can't handle two batteries -- ACPI 
parsing code is quite simplistic).

* Here's the kicker:  swsusp no longer works.  It 
suspends just fine, but on resume it seems to get 
caught on the next to last screen during suspend,
the one that says "Stopping all tasks ... eating
pages ... freeing pages ..." in ASCII.

If it were not for this last failure I would be quite
happy.  dmesg is unremarkable.  I took care to make 
sure that the CONFIG_ACPI_SLEEP=y line is still in 
the kernel .config.

One possibility is my XF86 Synaptics touchpad driver.
I got suspend to work once with the driver installed,
and the touchpad froze.  However, the problem I
have above seems unrelated.

At least I have battery status -- thanks for 
everyone's help.


Regards,

Sourav



-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
