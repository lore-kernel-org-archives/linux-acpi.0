From: Heiko Ettelbrueck <hbruckynews-hi6Y0CQ0nG0@public.gmane.org>
Subject: Compaq Evo N160: Fixed DSDT - battstat_applet works now
Date: Sat, 14 Dec 2002 18:36:37 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3DFB6C25.4030805@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
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

Hi all,

in short terms:
---------------
Today I fixed the DSDT of my Compaq Evo N160 so that it knows the design 
capacity of its battery and allows tools like battstat_applet to 
calculate the percentage of remaining capacity.

The fixed DSDT can be retrieved as
- ASL from 
http://www.ettelbrueck.de/linux-acpi/compaq-evo-n160/acpi_dsdt.asl
- AML in a C sourcecode, ready to be compiled into your kernel, from 
http://www.ettelbrueck.de/linux-acpi/compaq-evo-n160/acpi_dsdt.c

In more detail:
---------------
I realized why battstat_applet could not display the remaining capacity 
of my Compaq Evo N160 notebook: The DSDT provided by Compaq does not 
contain any information about the design capacity of the notebook, so 
battstat_applet could not calculate the remaining capacity percentage.

I had a look in the ACPI specification (2.0a) and found, in chapter 
11.2.2.1 on page 289, the following information about the battery 
properties which should be provided by the manufacturer in his DSDT:

BIF --> Battery Information
   Power Unit                     --> DWORD
   Design Capacity                --> DWORD
   Last Full Charge Capacity      --> DWORD
   Battery Technology             --> DWORD
   Design Voltage                 --> DWORD
   Design Capacity of Warning     --> DWORD
   Design Capacity of Low         --> DWORD
   Battery Capacity Granularity 1 --> DWORD
     +-- between "low" and "warning"
   Battery Capacity Granularity 2 --> DWORD
     +-- between "warning" and "full"
   Model Number                   --> ASCIIZ
   Serial Number                  --> ASCIIZ
   Battery Type                   --> ASCIIZ
   OEM Information                --> ASCIIZ

   DWORD  --> double word = four bytes (in hex: 0x00000000)
   ASCIIZ --> ASCII string with null-byte (0x00) at the end

Here we have the original values of the Compaq DSDT together with some 
comments from my side to show what was wrong and how it should be right 
- or let's say: how it should be better ;-

     0x0, --> interpret values as mW or mWh
          --> WRONG! values are mA or mAh
          --> CORRECT: 0x00000001
     0xffffffff, --> design capacity unknown
                 --> WRONG! design capacity is 4000 mAh
                            according to value printed on battery
                 --> CORRECT: 0x00000fa0
     0xffffffff, --> last full charge capacity unknown
                 --> WRONG! my own reaches 3357 mAh at the moment
                 --> CORRECT: 0x00000d1d
     0x1, --> battery technology is rechargeable
          --> CORRECT
     0xffffffff, --> design voltage unknown
                 --> WRONG! design voltage is 14.4V = 14400mV
                 --> CORRECT: 0x00003840
     0x0320, --> design capacity of warning is 800 mAh
             --> CORRECT (?)
     0x0320, --> design capacity of warning is 800 mAh
             --> CORRECT (?)
             --> Why does /proc/acpi/battery/*/info
                 show only _16_ mAh here???
     0x64,   --> battery capacity granularity 1 is 100 mAh
     0x64,   --> battery capacity granularity 2 is 100 mAh
     "BAT1",
     "123",
     "LION",
     "COMPAQ",

Feedback about my conclusions and corrections is welcome :-)

Regards,
Heiko



-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
