From: Pavel Vondricka <Pavel.Vondricka-1W7zqEVgo5LrBKCeMvbIDA@public.gmane.org>
Subject: Freezing more and more (Gericom Supersonic M6T)
Date: Tue, 4 Mar 2003 15:29:11 -0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200303041529.11172.Pavel.Vondricka@ff.cuni.cz>
Reply-To: Pavel.Vondricka-1W7zqEVgo5LrBKCeMvbIDA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
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

Hi,
I have a Gericom Supersonic M6T notebook and therefore I need ACPI IRQ-routing 
to use the modem, sound, network and pcmcia cards, because the BIOS is 
probably not really doing much with assigning IRQ to them. All the subsystems 
share either IRQ 5 or 10 together with others.

---- PROBLEMS in detail: -------------

In the last few months I have realized freezing of the whole system. I use 
ACPI patches since the beginning and I've never had problems until about the 
time I started to use PCMCIA 802.11b cards. Now I have problems even if I do 
not use them just at the moment. The computer is freezing completely mostly 
when manipulating the PCMCIA cards (insert, eject), starting video or audio 
playing, aso. But also without any clear reason. Sometimes everything is OK, 
sometimes just a small operation freezes the whole system. Mainly when the 
computer has been running for a longer time (however, I don't suppose the 
problem is in overheating), it becames more and more unstable.

The situation was OK for a long time with kernel 2.4.17 (+ACPI +some temporary 
irq-routing patch) and later mainly 2.4.19 with the appropriate ACPI 
(20020815 or 20020918, do not remember). Then the problems started with 
2.4.20 (+ACPI 20021122 patch). After freezing, even the older kernel 2.4.19 
paniced withy some "Aiee! ..." message already by booting/fixing the 
filesystem. I didn't help to turn off the machine. I had to run 2.4.20 again 
and then reboot to 2.4.19, if it managed to fix the disk before freezing 
again. However, soon the 2.4.19 kernel began to freeze as well. I removed the 
processor.o module code and the system worked better for a while - no more 
slowdown down to complete freezing. But now it freezes again quite often, 
unexpectedly, without the slowdowns.

2.4.19 reportes some ACPI Debug numbers like 000000001 or 00000004D or 
00000004B (two times, usually after 000000001) when started after crash (and 
poweroff!) of the 2.4.20 kernel.

I tried 2.4.21-pre4 with the latest 20030228 patch. The result: freezing 
Konsole in KDE just after starting the machine, then freezing the whole 
keyboard - unable to switch to any text console, unable to do anything, maybe 
move the mouse cursor. Completely useless.

----- SHORTLY - MY QUESTION: --------------
Could you at least not tell me, if this is a hardware or a software problem of 
ACPI, please? Should I ask for warranty repair of my notebook (I still have 
one year, I believe) or just patiently wait for another ACPI patch releases? 
Can I send you more debug info, how?
----------------------------------------------------------------

Thank you very much for your effort,
Pavel


-- 
###########################################################################
# mailto:Pavel.Vondricka-1W7zqEVgo5LrBKCeMvbIDA@public.gmane.org / ICQ:143159880 
# http://web.ff.cuni.cz/~vondric
#
# Muzete mi psat cesky s libovolnym kodovanim (UTF-8, ISO-8859-2,
# windows-1250, atd. ...)
###########################################################################


-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
