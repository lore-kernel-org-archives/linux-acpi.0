From: Anders Rune Jensen <anders-VYFdHW3tBKJknbxzx/v8hQ@public.gmane.org>
Subject: Trouble booting with latest acpi
Date: Sat, 15 Feb 2003 23:25:37 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <87vfzli3ku.fsf@gnulinux.dk>
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
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel <acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi

Just some info. My laptop is a Toshiba Tecra 8200.

Hadn't updated my 2.4 kernel in a long time (3 month or so) I thought
I would try 2.5.61. After booting is kernel stopped around where it
should do a init (right after it has loaded the kernel). But something
hangs after freeing memory. So I thought is was because it was 2.5 and
still unstable so I tried 2.4.21pre with the latest acpi patch. Same
problem. Then I tried booting 2.5.61 without acpi and it worked!

Booting without acpi I can see that a lot of the hardware is sharing
the same irq (11) [1]. Also when I booted with acpi I could see that
acpi had trouble with irq, assigning a lot of them irq 0 or 255.
Another thing I noticed was that the dsdt generated some errors.
Booting with debug on didn't help much to discover what the problem
was. When booting my fan normally starts and then stops after a few
seconds but with the hang it keeps running until I kill it. So
something is hogging the cpu.

Let me know if there is anything else I can do.

[1]: cat /proc/interrupts

  0:    1121769          XT-PIC  timer
  1:       6721          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  8:          2          XT-PIC  rtc
 11:       1610          XT-PIC  uhci-hcd, uhci-hcd, YMFPCI, eth0
 12:       8700          XT-PIC  i8042
 14:       6524          XT-PIC  ide0
 15:         14          XT-PIC  ide1

-- 
Anders Rune Jensen



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
