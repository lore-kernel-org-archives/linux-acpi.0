From: Fabio Sirna <farnis-VGgt2q2+T+FeoWH0uzbU5w@public.gmane.org>
Subject: Acer travelmate 210 txr
Date: Sun, 20 Apr 2003 13:24:31 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030420112431.GA2719@thecrow.it>
Reply-To: farnis-VGgt2q2+T+FeoWH0uzbU5w@public.gmane.org
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
To: Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I've the laptop in subject.
I patched the kernel 2.4.0 with the patch that I've found on
acpi.sf.net. The battery is found, and battstat works well.
I've problems with sleep and stand-by.
If I do 

echo S1 > /proc/acpi/sleep

the laptop goes in standby with a white screen with many horizontal line.
If I try to wake-up it, the keyboard doesn't work.
I read on acpi.sf.net about the DSDT table, but I don't understand very
well, and I didn't find any DSDT table for my laptop.
If you have any suggestion, please help me.

-- 
Fabio
_____________________________________________________________________
Envie de discuter en "live" avec vos amis ? Télécharger MSN Messenger
http://www.ifrance.com/_reloc/m la 1ère messagerie instantanée de France



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
