From: Joshua Legbandt <jtlegbandt-ihVZJaRskl1bRRN4PJnoQQ@public.gmane.org>
Subject: Compaq 2715US ACPI problems
Date: 04 Feb 2003 17:00:09 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1044406809.1621.9.camel@suburbia>
Mime-Version: 1.0
Content-Type: text/plain
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
To: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello,

I've been looking for a solution to a problem that I am having with ACPI
on my Compaq Presario 2715US, running kernel 2.4.21-pre3 with the most
recent ACPI patch. Basically, if I cold boot with the AC Adapter plugged
in, I don't get ACPI. If I reboot, or boot up with the AC Adapater
unplugged, I get ACPI. I suspect that there are error in the dsdt, but I
haven't the first clue on how to debug them...

I've attached my disassembled dsdt.

Cheers,
Josh
-- 
Joshua Legbandt <jtlegbandt-ihVZJaRskl1bRRN4PJnoQQ@public.gmane.org>



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
