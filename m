From: "Russell Y. Neches" <russell-1vnkWVZi4QaVc3sceRu5cw@public.gmane.org>
Subject: power-off on boot
Date: Tue, 20 Jul 2004 18:38:13 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1090363093.6236.27.camel@joker.ccs.neu.edu>
Reply-To: russell-1vnkWVZi4QaVc3sceRu5cw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain
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

Hey there --

I have an "interesting" behavior with 2.6.6 and 2.6.7, and I was
wondering if this list would mind helping me figure out what's causing
it. 

Basically, my machine turns off while it's booting. It doesn't get far
enough to mount any filesystems, so there aren't any logs. On a hunch, I
turned on ACPI-debugging, and noticed that the kernel immediately begins
spewing warnings about a critical trap (that's from memory, I can't be
completely sure if that's literally the string), and that the CPU is
over 120 degrees C. Now, I'm actually *underclocking* my CPU because I
have very bad luck with hardware, and I happen to know that the
temperature never goes above 38 degrees C (according to my BIOS and the
hardware meter glued to the heat sync). 

2.6.5 doesn't seem to have this problem (USB-related oopses
notwithstanding), and Debian's 2.6.7-1-k7 kernel package boots without
issue (Debian's module insanity notwithstanding). So, I know there is a
solution to the problem somewhere, but without logs, I'm not sure how to
even begin researching it.

If it weren't for the fact that there are recent ACPI-enabled kernels
that work fine, I'd guess that my motherboard has a broken DSTD. 

Would anyone mind orienting me and pointing me in the right direction? 

Thanks!

Russell

PS - The list moderator hasn't approved a previous email with some
system information attached. So, instead of attaching it, I'll just link
to it:
	
	http://vort.org/downloads/spew.txt




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
