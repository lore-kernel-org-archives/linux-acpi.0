From: Yury Umanets <umka-nJ1KrdHEGnBBDgjK7y7TUQ@public.gmane.org>
Subject: ACPI 20030619 and ASUS M3N
Date: Fri, 03 Oct 2003 14:05:48 +0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3F7D49FC.5090205@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R; format=flowed
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
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello all,

I have ASUS M3N laptop and was experienced lots of problem with acpi on 
it. And at last I have found, that linux-2.4.21 with acpi patch of June 
with small patch for asus is working just fine. Thanks for your job 
guys. But, there still few small problems:

(1)  IrDA does not work if irqs are routed via acpi. This looks, like 
irq 3 (on my laptop this is ttyS1) is assigned to irda0 or serial0 
(depends on irda setup) successfully, but interrupt handler is 
definitelly not called, counter is not increased (may be checked by 
means of using cat /proc/interrupts).

(2) Sometimes I have "osl-0888 os_wait_semaphore" messages in my system 
log along with complains, that some semaphore cannot be taken because of 
timeout. This is happened when I access /proc/apci from the few 
processes like cat /proc/acpi/... or if gnome battery_statt applet is 
running.

If someone is able to help me, or just say what direction I should dig 
to, I will be very thankfull.

-- 
umka




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
