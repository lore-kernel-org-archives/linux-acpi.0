From: Hiromichi Ito <itooon-ez3K6K0nqN9BPp5YB5Ev3w@public.gmane.org>
Subject: Re: CALL FOR TESTING
Date: Fri, 27 Sep 2002 16:43:05 +0900
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020927074308.9717@po.lancenet.or.jp>
References: <EDC461A30AC4D511ADE10002A5072CAD0236DE8C@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <EDC461A30AC4D511ADE10002A5072CAD0236DE8C-OU+JdkIUtvd9zuciVAfUoVDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

>- DOES IT BOOT?

My Supermicro P4DP8-G2 with Xeon(enable HT) CPU boots.

>- DOES IT ASSIGN INTERRUPTS PROPERLY?

It seems to be assigned appropriately.
However, there are some differences.

dmesg of 2.4.20-pre7

 IO-APIC (apicid-pin) 2-0, 2-10, 2-11, 2-17, 2-20, 2-21, 2-22, 2-23, 3-0, 3-1, 3
-2, 3-3, 3-6, 3-7, 3-8, 3-9, 3-10, 3-11, 3-12, 3-13, 3-14, 3-15, 3-16, 3-17, 3-1
8, 3-19, 3-20, 3-21, 3-22, 3-23, 4-0, 4-1, 4-2, 4-3, 4-4, 4-5, 4-6, 4-7, 4-8, 4-
9, 4-10, 4-11, 4-12, 4-13, 4-14, 4-15, 4-16, 4-17, 4-18, 4-19, 4-20, 4-21, 4-22,
 4-23, 5-0, 5-1, 5-2, 5-3, 5-6, 5-7, 5-8, 5-9, 5-10, 5-11, 5-12, 5-13, 5-14, 5-1
5, 5-16, 5-17, 5-18, 5-19, 5-20, 5-21, 5-22, 5-23, 8-0, 8-1, 8-2, 8-3, 8-4, 8-5,
 8-6, 8-7, 8-8, 8-9, 8-10, 8-11, 8-12, 8-13, 8-14, 8-15, 8-16, 8-17, 8-18, 8-19,
 8-20, 8-21, 8-22, 8-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 22.

dmesg of 2.4.20-pre7 + acpi-20020918

 IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23, 3-0, 
3-1, 3-2, 3-3, 3-4, 3-5, 3-6, 3-7, 3-8, 3-9, 3-10, 3-11, 3-12, 3-13, 3-14, 3-15,
 3-16, 3-17, 3-18, 3-19, 3-20, 3-21, 3-22, 3-23, 4-0, 4-1, 4-2, 4-3, 4-4, 4-5, 4
-6, 4-7, 4-8, 4-9, 4-10, 4-11, 4-12, 4-13, 4-14, 4-15, 4-16, 4-17, 4-18, 4-19, 4
-20, 4-21, 4-22, 4-23, 5-0, 5-1, 5-2, 5-3, 5-4, 5-5, 5-6, 5-7, 5-8, 5-9, 5-10, 5
-11, 5-12, 5-13, 5-14, 5-15, 5-16, 5-17, 5-18, 5-19, 5-20, 5-21, 5-22, 5-23, 8-0
, 8-1, 8-2, 8-3, 8-4, 8-5, 8-6, 8-7, 8-8, 8-9, 8-10, 8-11, 8-12, 8-13, 8-14, 8-1
5, 8-16, 8-17, 8-18, 8-19, 8-20, 8-21, 8-22, 8-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 16.


Is this situation OK?


# Lance Inc.                R&D Division # 
# Hiromichi Ito  (itooon-ez3K6K0nqN9BPp5YB5Ev3w@public.gmane.org) #


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
