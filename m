From: Gabe Sibley <gsibley-DG7SOAwx7rg@public.gmane.org>
Subject: S3 on a Compaq Evo N610c
Date: Mon, 02 Feb 2004 01:59:14 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <401E1F72.3080300@usc.edu>
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

Hi all,

I've got a scary storie to tell.  The other day I was checking out the 
acpi support on my Compaq Evo n610c.  I have the latest bios from 
compaq, and I was trying out the 2.6.1 stock kernel.  I build the acpi 
modules into the kernel.  When I pipe a "3" to /proc/acpi/sleep the 
system seems to go down just fine.  But when I try to power up, she just 
lets out a continuous beep.  I had to take the battery out to reset it. 
  Then at as I'm booting, grub freaks out.  Somehow, grub.conf was 
gone... wtf?   grub.conf lives on /hda2, which was never mounted.  I 
re-wrote grub.conf, but don't really know what happened... where did it 
go?  why?  THe next boot cycle, /hda5 (home) complains, so I fsck it, 
and find a few inode problems that I just let fsck fix.  Next boot, grub 
is completely gone from the boot sector, and the machine boots straight 
to Windows!  At this point I'm worried big time.  I have run all the 
compaq diagnostics to see if the disk is messedup - it's not.  I 
re-installed grub, and I've gone back to 2.6.0.  I have not tried echo 3 
again.  So I have no idea what happened.  Seems the laptop freaked out. 
  anyone else see anything like this before?

On another note, has anywone gotten acpi to *really* work on the n610c???

cheers, Gabe




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
