From: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Subject: ACPI very nearly working on Thinkpad 240x
Date: Sun, 2 Mar 2003 18:47:37 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030302184737.GA28806@srcf.ucam.org>
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

Having upgraded my BIOS to the latest available from IBM, I've very 
nearly got working ACPI.

1) S1 usually works correctly, but the backlight doesn't get switched 
off. Is there any trivial way of dealing with this?

2) S3 suspends and resumes. On resume, the backlight comes back on the
machine is responsive from the network. The keyboard and mouse don't
work, though - if I use modular input drivers, a rmmod i8042 && modprobe
i8042 brings things back to life. Switching on the Toshiba keyboard 
kicking code doesn't result in any change in behaviour. The symptoms are 
that no input results in an increase in interrupts until I reload the 
module. 

The other problem is that the screen doesn't come back. The backlight
comes on but no text appears. This is the case with both vesafb and 
vgacon - sometimes (but not predictably) a small amount of text is 
printed, but it looks like it's left over from lilo or something. The 
screen seems to be in 640x480 text mode, rather than the 800x600 it 
should be in when I'm using the VESA driver. Killing X and restarting it 
results in X starting up, but I can't switch back to a text console 
(they're just garbage). Passing acpi_sleep=s3_bios or s3_mode doesn't 
seem to make any difference.

3) S4 with SWSUSP sometimes works, but usually I hit the BUG() in 
ide-disk that others have reported. Is there any understanding behind 
why that one's happening?

It certainly seems a lot better than things have been before now.
-- 
Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
