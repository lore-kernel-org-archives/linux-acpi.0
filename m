From: "Nirmal Govind" <nirmalg-8DAjSxpRXgY@public.gmane.org>
Subject: can't get standby (S1) to work
Date: Sat, 20 Dec 2003 11:44:33 -0500 (EST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200312201644.hBKGiX228156@webmail2.cac.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain
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

Hi.. I have acpi compiled into the kernel and also have swsusp. Now, when I try
echo 1 > /proc/acpi/sleep, nothing happens. I'm running Mandrake 9.2, 2.4.22-21
kernel that I compiled with (almost?) all the acpi options enabled. The laptop
is a Fujitsu Lifebook S6120D. Is there any way to get the laptop to standby? I
move around a lot with this computer and really would like to get the standby
working. The swsusp seems to work with the suspend to disk, i.e. when I do an
echo 1 > /proc/swsusp/activate .. however, after the computer suspended, I
couldn't bring it back up - when I hit the power button, it tried to resume,
did something, and then gave me a blank screen -- had to do a hard reboot after
that.

Thanks,
nirmal



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
