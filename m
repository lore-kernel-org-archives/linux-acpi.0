From: moali-ArvQUR6U0fYD0fefG/KofA@public.gmane.org
Subject: acpi-20021101 broken
Date: Tue, 05 Nov 2002 08:14:04 +0100 (MET)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1036480444.3dc76fbc753e6@sbox.tugraz.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
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

Hi!

I just tried out acpi-20021101 (patch against 2.4.20-rc1), but unfortunately it 
seems to be broken. When booting, I see some kenel messages (I think I could 
identify the processor-determination) and then the kernel seems to run into an 
endless loop writing tons of messages to the console (nearly impossible to 
read); but they all seem to have the same structure:

a few words "-" four digits "["for digits"]" "["two digits"]" some text ":" 
some text

The first four digits displayed are "0001" almost the whole time.

The system does not lock in this loop, but a warm-reboot is not accepted.

acpi-20021022 worked on the system (but as mentioned with /proc/thermal 
and /proc/processor missing).

If I can help somehow finding the reason for this bug, please let me know.

Maier Gerfried

PS.: The system boots as expected (but without acpi) with acpi=off specified as 
boot-parameter.


-------------------------------------------------------
This sf.net email is sponsored by: See the NEW Palm 
Tungsten T handheld. Power & Color in a compact size!
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0001en
