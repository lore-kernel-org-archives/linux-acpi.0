From: Sebastien B <sebastien.bourdeauducq-QFKgK+z4sOrR7s880joybQ@public.gmane.org>
Subject: Gericom Hummer 2430 problems
Date: Wed, 7 Jan 2004 10:35:21 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200401071035.21360.sebastien.bourdeauducq@laposte.net>
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

Hello,
I have several problems with my Gericom Hummer 2430 laptop :
- I can't change the CPU throttling settings. When I write to 
/proc/acpi/processor/CPU1/throttling, nothing happens and the contents of 
this file remain unchanged. Writing to /proc/acpi/processor/CPU1/limit 
doesn't work either. There isn't any error message displayed in the dmesg 
output nor in the console.
- Sometimes my machine locks up for less than a second and when this happens I 
have the following message in the dmesg output : 
atkbd.c: Unknown key pressed (translated set 2, code 0x0, data 0x0, on 
isa0060/serio0).
I'm unsure this problem is ACPI related, but it often happens when the fan 
starts up.
- The S-states just don't work. Trying to enter one either does nothing or 
crashes the computer. The computer shutdowns properly, though.
I'm using Linux 2.6.0 with the ACPI patch 20031203.
You can find useful information about my laptop (contents of the DSDT, full 
output of dmesg and so on) at http://irchat.free.fr/acpi/.
Thank you,
Seb



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
