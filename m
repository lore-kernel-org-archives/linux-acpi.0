From: Henry Umansky <hmust2+-fYq5UfK3d1k@public.gmane.org>
Subject: ACPI state 4
Date: Mon, 02 Feb 2004 14:43:21 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <80712959.1075733001@HELPDESK-PC13.fdl.pitt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
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
I just compiled Linux kernel 2.6.1 with ACPI support and I wanted to test 
out the different sleep states.  So I ran the command:

$echo 4 > /proc/acpi/sleep

And it started freeing up memory and everything looked like it worked. 
Then my computer shut off.  When I pressed the power button, it started up 
and I started my linux kernel with the following GRUB commands:

root (hd0,0)
kernel /vmlinuz resume=/dev/hda2

And it looks like ACPI attempts to read the state from the swap partition 
(/dev/hda2) but then it reboots all of a sudden.  This happens everytime I 
try to recover.  When I try to boot normally, most of my files are corrupt. 
I'm guessing that when I entered the S4 sleep state, everything in the swap 
partition didn't sync with my hard drive, because a lot of my text files 
are corrupt and can't be read anymore.  I apologize if I didn't include 
enough information, because I'm new to this mailing list and this is the 
first "real" time I've messed with ACPI.  Let me know if you need anymore 
information.

Thank you,
Henry

PS-this might help, but when I did a cat /proc/acpi/sleep is showed S0, S1, 
S2, S3, S4bios, and S5.  Maybe also S6 but I can't remember and since I 
don't have a stable running system, I can't really check.


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
