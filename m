From: "Andreas J. Thorvaldsen" <ajthorva-pC9TGHjoBLc@public.gmane.org>
Subject: Dell i5100 resume from ram probl. (2.6.0-test11)
Date: Mon, 08 Dec 2003 11:50:35 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3FD4577B.60406@start.no>
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

I have run some tests with suspend-to-ram (S3) on my Dell Inspiron 5100
laptop (bios rev. A23, Radeon 7500, ps2-type keyb.), and these are the
symptoms I have encountered:

1. The display stays black after resume (text). If suspending/resuming
from X, some "scary" visual effects resembling "LCD hypothermia"
appears, followed by a dark (but backlit) screen. Typing commands on the 
keyboard gives no response.

2. echo 3 > /proc/acpi/sleep; sleep 10; reboot; does run, indicating
that at least one process resumes correctly.

3. A key logger (Linux Key Logger; userspace) stops logging after resume
(though /var/log/messages continues to write (no errors)), indicating
that it has died somehow (although ...; ps -A > dump; indicates that it 
hasn't).

What are the likely causes of this problem? Is it a timer-, interrupt-, 
keyb.-, or video-problem or a pure ACPI problem? Where should I start 
debugging? Any help og advice is greatly appreciated.

-andreas




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
