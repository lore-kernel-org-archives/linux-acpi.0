From: Paul Ionescu <paul-f7LjuT9/YZU@public.gmane.org>
Subject: Linux Video ACPI support
Date: Sun, 29 Feb 2004 13:49:45 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1078055385.5345.14.camel@t40>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
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
To: ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello Bruno,

I tried your ACPI video patch with an IBM T30 and IBM T40 laptop.
Kernel was 2.6.4-rc1.
Here is some feedback for you:

It finds 4 vido devices, and I have the following directories under
/proc/acpi/video/VID:

CRD0
DVI0
LCD0
TV0

cat /proc/acpi/video/VID/info
Switching heads:	yes
Video ROM:	no
Device to be POSTed on boot: no

cat of POST and POST_info gives <not supported>.

I am still able to switch between CRT and LCD with the Fn+F7 as usual,
but I cannot switch with the method described in README file from your
patch.
However the information from CRT0/state file is correct:
0x1f when active and connected
0x0f when active and disconnected from crt
0x1d when disabled and connected to CRT
0x0d when disabled and no CRT attached
To verify these values, I used Fn+F7 to switch between heads.

cat <anydevice>/brightness
<not supported>

If you need more information/logs/testing please let me know.
I have access to other IBM thinkpad models for testing.




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
