From: Diego Zuccato <diego-gmoNqwowlqBr8A+qpt3pXFzrSV/HdtiB@public.gmane.org>
Subject: Slowdowns
Date: Wed, 16 Apr 2003 17:29:05 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3E9D92E1.D355E6E4@otello.alma.unibo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Acpi List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hello all.

I'm testing kernel 2.4.21-pre7-ac1-acpi20030328 (actually applied pre4
patch, just some offsets) on my Acer TM525TE (PIII/700).
It sometimes slows down to 200MHz and won't return to 700MHz till
reboot.
Seems it happens more frequently if I tell the bios that PM is done by
ACPI - if I tell it it's done by APM, ACPI works anyway and slowdowns
occour rarely (don't know if that could have other side effects).
Seems it's not an overheat problem (CPU is at about 58C, and I've seen
it often at 70C/700MHz), but I noticed that it happens quite often if I
run some CPU-intensive app after a quite long inactivity period (for
example Lopster+xmms during the night then mplayer in the morning).
Should I look at something special in DSDT ? Seems nearly nothing is
supported (no throttling, performance mgmt or limit interface
available).

The only message I never seen before in dmesg is "i8253 count too high!
resetting..", but I don't think it's related (never seen at the previous
slowdowns).

BYtE,
 Diego.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
