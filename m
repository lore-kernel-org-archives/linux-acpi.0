From: "Eric Northup" <digitale-eFwX6J65rk/J8bqQQ1YlwQ@public.gmane.org>
Subject: Shuttle SB61G2 fan speed
Date: Tue, 07 Oct 2003 21:45:03 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <E1A73Nv-0001M5-68@cell01.cell01.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Hi all,

I have a Shuttle mini-PC currently running linux 2.6-test6 (but I have
seen this issue w/all kernels I've tried, 2.4.x and 2.5.x).  It has a
"smart" fan control, which regulates the speed of the system fan
according to the temperature (a Thermal Zone in ACPI terms, yes?).  The
problem is: as soon as Linux gets control from GRUB, the fan goes to
full speed and stays there.

I have flashed the BIOS to the latest (which claimed to fix a fan speed
problem with Windows), but the problem persists.  So I don't know if it
is a case of pilot error, a Linux bug, or a BIOS bug.  Any help sorting
this out would be much appreciated :)

Please CC me on replies, as I'm not subscribed to acpi-devel.

--Eric


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
