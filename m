From: Carlos Noguera <carlos.noguera-mwuG6knsBJfQT0dZR+AlfA@public.gmane.org>
Subject: HELP! Compaq TC1000 ACPI - Disable IRQ #9
Date: Thu, 18 Dec 2003 18:06:42 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <15261.4199709662$1071784667@news.gmane.org>
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

I own a Compaq TC1000 Tablet PC and have been trying to get Gentoo
running on it, using the love-sources 2.6.0-test11-love 4 + ACPI patch
set (from
http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/test/2.6.0-test11/ ).

No matter what I do, nor what kernel options I throw at it (including
acpi=off), if the keyboard/mouse combo don't sense activity (i.e.
keypress) I get a message of "Disable IRQ #9" during bootup. This
usually occurs around the enabling hotplug stage.

The worse part is that this IRQ is shared among my OHCI controller AND
my eth0, so if it's disabled I have no way to log into the machine.

I've looked and looked all over the mailing lists and applied all sorts
of pathes, to no avail. If I don't press keys during bootup, I get no
keyboard or ethernet. :-/

Thanks in advance for your help...
[C]arlos



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
