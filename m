From: Mathias Kolehmainen <mathiask-bdq14YP6qtRg9hUCZPvPmw@public.gmane.org>
Subject: Overheating when on AC power (vaio SRX77P)
Date: Tue, 30 Jul 2002 23:36:35 -0700 (PDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.GSO.4.21.0207302335030.7616-100000@crak.roomfullaspies.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
List-Id: linux-acpi@vger.kernel.org

I've got an odd problem on my sony vaio PCG-SRX77P which I think is
related to the ACPI.  When I am running on AC power the system
overheats quite readily.  When running on battery it does not.  More
details follow.  If you are running this laptop without any
overheating problems, I'd love to hear from you.  Maybe it is some
bios setting...

To test out overheating I just run multiple xflame windows.  When on
AC power, two xflame's is enough to send the temperature over 65.  On
battery, I can't make the temperature go about 56 or so-- no matter
how many xflame windows I open.

I'm running RH7.3, with a vanilla 2.4.18 patched with acpi-20020725
patch.  My ACPI settings in the kernel config file are:

CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_BUS=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SYSTEM=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
# CONFIG_ACPI_FAN is not set
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_DEBUG=y


I have not noticed any obvious errors in the syslog.  One interesting
tidbit is that when I am running on ac power, the processor is
reported by the kernel to be running at about 800MHz:

  Jul 30 22:32:02 localhost kernel: Detected 794.939 MHz processor.

...but, when running on battery, it comes in at about 500MHz:

  Jul 30 22:47:17 localhost kernel: Detected 496.843 MHz processor.

Interestingly, the contents of the acpi "performance", "power", and
"throttling" files look the same in both states:

$ cat performance 
state count:             2
active state:            P0
states:
   *P0:                  800 MHz, 9800 mW, 250 uS
    P1:                  500 MHz, 5900 mW, 250 uS


$ cat power 
active state:            C2
default state:           C1
bus master activity:     ffffffff
states:
    C1:                  promotion[C2] demotion[--] latency[000]
usage[00000930]   *C2:                  promotion[C3] demotion[C1]
latency[010] usage[00121466]    C3:                  promotion[--]
demotion[C2] latency[133] usage[00000000]


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



If you have any ideas please let me know.

Thanks,

-mathias.




-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
