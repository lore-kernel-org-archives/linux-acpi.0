From: Anders Persson <anders.persson-sT6loi8rTDSci/EUP2OQSw@public.gmane.org>
Subject: Compaq evo n800v
Date: 08 Mar 2003 13:07:03 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1047125223.5077.28.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
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

I have problems with CPU-throttling on my Compaq Evo n800v. 
To get ACPI working I compiled the following kernel+patches and applied
a modified dsdt-table.

2.4.20 kernel +
patch-2.4.21-pre4.gz +
acpi-20030218-2.4.21-pre4.diff.gz +
linux-2.4.18-acpi-20020709-dsdt.patch +
custom dsdt

AC- and battery-status works just fine, as well as the Fn-combinations
for screen-brightness. 

But no matter how low the CPU-load, the clock frequency is always at
max.  Also, the fan(s?) are always on making noise (at relatively low
speed but still too high compared to under Win-XPP).  

I am not really familiar with how this is supposed to work. Can I force
the CPU to run on the low clock-frequency when, e.g., running on
batteries? Can I set load-thresholds when the speed-step functionality
should take action? Grateful for any help on this! 

Some data available below! 

$ cd /proc/acpi/processor/C000

$ cat throttling
state count:             8
active state:            T0
states:
   *T0:                  00%
    T1:                  12%
    T2:                  25%
    T3:                  37%
    T4:                  50%
    T5:                  62%
    T6:                  75%
    T7:                  87%

$ cat limit
active limit:            P0:T0
platform limit:          P0:T0
user limit:              P0:T0
thermal limit:           P0:T0

$ cat info
processor id:            0
acpi id:                 1
bus mastering control:   yes
power management:        yes
throttling control:      yes
performance management:  yes
limit interface:         yes


$ cat performance
state count:             2
active state:            P0
states:
   *P0:                  1900 MHz, 20000 mW, 500 uS
    P1:                  1200 MHz, 10000 mW, 500 uS


$ cat power
active state:            C2
default state:           C1
bus master activity:     04082fff
states:
    C1:                  promotion[C2] demotion[--] latency[000]
usage[00001020]
   *C2:                  promotion[C3] demotion[C1] latency[002]
usage[00348077]
    C3:                  promotion[--] demotion[C2] latency[085]
usage[00002681]





-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
