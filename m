From: Marcin <marcing-aUYh8w+s/F/VItvQsEIGlw@public.gmane.org>
Subject: Asus L3500D
Date: Thu, 5 Feb 2004 17:25:25 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200402051725.25916.marcing@amu.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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



I have Asus L3500D (Athlon XP-M 2500+).
If I set acpi=off fan speed is "automaticaly" adapted to the temeperature but 
I can't read (because of lack of ACPI) battery status or temperature.
(BIOS doesn't report apm at all, acpi only).

If I turn acpi on, everything is detected, but the fan is "dead" (or rather at 
the "boot" speed - if I reboot "hot" processor it works all the time at the 
same speed). Of course if I use more processor power (higher frequency) my 
machine turns off after several minuts.

If I send it to sleep (echo 1 > /proc/acpi/sleep) and resume, the fan is 
adjusted to correct speed.

If the temperature is high enough (according to trip_points) I get "device is 
not power managable".

									M.




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
