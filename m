From: Maier Gerfried <moali-ArvQUR6U0fYD0fefG/KofA@public.gmane.org>
Subject: Power saving scheme changed
Date: Wed, 22 Jan 2003 08:54:19 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1043222059.3e2e4e2b334d2@webmail.tugraz.at>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
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
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello Acpi-List!

I'm now using acpi 20010901 together with kernel 2.4.21-pre3.  No big problems 
occur during use (beside, that the processor module gives back "device or 
resource busy" when unloading).

But I have the impression, that -- sometimes -- the in the BIOS configured 
power-saving scheme is changed (in my case from recommended - max Performance 
on AC - to disabled - always low performance). Obviously this is a bit 
uncomfortable because on the next boot /proc/acpi/processor/CPU0/performance 
says <nt supported>, and always running on low speed.
(when thinking to the past, this behaviour did not appear with kernel 2.4.20 
and acpi 20021212)

The processor is an Intel P4m 1,8G mounted in an Acer Travelmate 630 Notebook 
(I think the ALI 1533 chip is responsible for the ACPI-stuff)

I'd be very glad if anybody had a hint what to do about this.

Maier Gerfried




-- 



-------------------------------------------------------
This SF.net email is sponsored by: Scholarships for Techies!
Can't afford IT training? All 2003 ictp students receive scholarships.
Get hands-on training in Microsoft, Cisco, Sun, Linux/UNIX, and more.
www.ictp.com/training/sourceforge.asp
