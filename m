From: Brian Kendig <brian-TPUXs3lpsvIxsqv6Oivclw@public.gmane.org>
Subject: ACPI doesn't sense one of my batteries after I reinsert it
Date: Sat, 05 Jun 2004 10:15:35 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <40C1D587.3000206@enchanter.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
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

I have a Dell Latitude CPi D266XT laptop.  It has two batteries in it, 
and ACPI senses them both, but if I remove the left one then ACPI will 
never detect it again even if I reinsert it.

The left battery is BAT0. The right battery is BAT1 (its slot can also 
be used for an internal floppy or cdrom). I should be able to remove and 
reinsert either or both batteries (removing both at the same time 
requires that I have AC power, of course), and generally this works, 
except that once I pull out BAT0 the system never sees it again even 
after I reinsert it.  It still draws power from that battery; if I pull 
out both batteries and reinsert the left one then 
/proc/acpi/battery/BAT0/state says "present: no" and the Gnome battery 
charge monitor says I'm at 0%, but the laptop will continue to use its 
charge and keep running.

This has happened on several kernels I've tried, but most recently on 
2.6.7-rc2.

I'd like to log this as a bug; where's the correct place for me to do 
so, and what additional information should I include?



-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
