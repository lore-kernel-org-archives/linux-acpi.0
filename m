From: Peter Osterlund <petero2-zq6IREYz3ykAvxtiuMwx3w@public.gmane.org>
Subject: throttling reset when reading ac_adapter state
Date: 01 Sep 2002 19:43:46 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <m2bs7h1u7h.fsf@p4.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: "Charl P. Botha" <c.p.botha-ra0OqMccq8edIhEUFHOBvg@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

I have a Clevo 5600 laptop computer running 2.4.20-pre5 with the
acpi-20020829-2.4.20-pre5.diff.gz patch. I can successfully change the
throttling level using the /proc interface, but reading the ac_adapter
state resets the throttling value:

        best:~# cat /proc/acpi/processor/CPU0/throttling | grep '*'
           *T0:                  00%
        best:~# echo 3 >/proc/acpi/processor/CPU0/throttling 
        best:~# cat /proc/acpi/processor/CPU0/throttling | grep '*'
           *T3:                  37%
        best:~# cat /proc/acpi/ac_adapter/ADP0/state 
        state:                   on-line
        best:~# cat /proc/acpi/processor/CPU0/throttling | grep '*'
           *T0:                  00%

I had the same problem with acpi-20020709. Has anyone else seen this?
How can I find out if this is a bug in the kernel acpi driver or a
bios bug? When booting, my computer reports:

        PhoenixBIOS 4.0 Release 6.0
        Copyright...
        BIOS revision 1.01.06
        KBC/EC Firmware revision 1.00.14

I can provide an acpi dump/disassembly upon request.

Btw, this is the same problem reported by Charl P. Botha some time
ago:

        http://sourceforge.net/mailarchive/message.php?msg_id=1914478

He also has a Clevo 5600 computer.

-- 
Peter Osterlund - petero2-zq6IREYz3ykAvxtiuMwx3w@public.gmane.org
http://w1.894.telia.com/~u89404340


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
