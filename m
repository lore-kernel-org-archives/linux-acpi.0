From: Nigel Nigel <nigels@hotmail.com>
Subject: acpid on gentoo
Date: Sun, 4 Mar 2007 01:06:36 +0000
Message-ID: <BAY123-W126CA0EB3A7FA8C61FD99BD5850@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bay0-omc3-s5.bay0.hotmail.com ([65.54.246.205]:16502 "EHLO
	bay0-omc3-s5.bay0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751380AbXCDBGg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 3 Mar 2007 20:06:36 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


Hello,

I have been trying to get acpid to receive events on gentoo without any success.
I an on kernel 2.6.17 (with rev 10 gentoo patched)
acpid: 1.0.4-r4
Toshiba Tecra M3

I have been following the guide at:
http://www.gentoo.org/doc/en/power-management-guide.xml

I'm on 2.6.17

So, whatever they suggested to compile in the kernel or as a module that is what I have done.

When I look at /var/log/acpi no events are being generated.

With this test :
on_ac_power && echo AC available || echo Running on batteries

It shows "AC available" when the ac is plugged in, take the cable out, and it shows "Running on batteries"

Code:

# acpitool -e   
  Kernel version : 2.6.17   -    ACPI version : 20060127
  -----------------------------------------------------------
  Battery #1     : present
    Remaining capacity : 39441 mWh, 82.47%, 00:27:29
    Design capacity    : 50760 mWh
    Last full capacity : 47822 mWh, 94.21% of design capacity
    Capacity loss      : 5.788%
    Present rate       : 18295 mW
    Charging state     : charging
    Battery type       : rechargeable, Li-ION 
    Model number       : G71C0004G810
    Serial number      : 0100027803
  Battery #2     : slot empty

  AC adapter     : on-line
   Fan :  off

  CPU type               : Intel(R) Pentium(R) M processor 2.13GHz
  CPU speed              : 800.000 MHz
  Cache size             : 2048 KB
  Bogomips               : 1600.29
  Processor ID           : 0
  Bus mastering control  : yes
  Power management       : yes
  Throttling control     : no
  Limit interface        : no
  Active C-state         : C3
  C-states (incl. C0)    : 4
  Usage of state C1      : 10 (0.0 %)
  Usage of state C2      : 161443 (35.8 %)
  Usage of state C3      : 144440 (32.1 %)

  Thermal info   : 

  wakeup devices : 


I can modify this:
/sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
and the processor speed with follow the governor which I set.

I can also run: acpitool -l 4
for example, and dim the lcd display.

Also, I have th battery indicator applet in gnome, this also changes correctly with respect to having the power connected, or not.

Most things seem to work as they should, except acpid is not receiving events.

Code:

 # ls -R /proc/acpi/
/proc/acpi/:
ac_adapter  dsdt                 event  info            processor
battery     embedded_controller  fadt   power_resource  toshiba

/proc/acpi/ac_adapter:
ADP1

/proc/acpi/ac_adapter/ADP1:
state

/proc/acpi/battery:
BAT1  BAT2

/proc/acpi/battery/BAT1:
alarm  info  state

/proc/acpi/battery/BAT2:
alarm  info  state

/proc/acpi/embedded_controller:

/proc/acpi/power_resource:

/proc/acpi/processor:
CPU0

/proc/acpi/processor/CPU0:
info  limit  power  throttling

/proc/acpi/toshiba:
fan  keys  lcd  version  video


Modules at run time :
Code:

 # lsmod
Module                  Size  Used by
cisco_ipsec           545996  0
snd_pcm_oss            16992  0
snd_mixer_oss          12928  1 snd_pcm_oss
snd_seq_oss            23872  0
snd_seq_midi_event      5184  1 snd_seq_oss
snd_seq                37456  4 snd_seq_oss,snd_seq_midi_event
snd_seq_device          5708  2 snd_seq_oss,snd_seq
snd_intel8x0           24924  0
snd_ac97_codec         78496  1 snd_intel8x0
snd_ac97_bus            1792  1 snd_ac97_codec
snd_pcm                54472  3 snd_pcm_oss,snd_intel8x0,snd_ac97_codec
snd_timer              15236  2 snd_seq,snd_pcm
snd_page_alloc          6728  2 snd_intel8x0,snd_pcm
toshiba_acpi            4756  0
speedstep_centrino      5456  1
processor              16896  1 speedstep_centrino
ipw2200               140268  0
nvidia               4541396  12
sky2                   28740  0



The AC and battery modules are compiled in kernel as the guide suggests.


# acpi_available; echo $?
0 

# grep -i "^config_acpi" .config
CONFIG_ACPI=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=m
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=m
CONFIG_ACPI_PROCESSOR=m
CONFIG_ACPI_THERMAL=m
CONFIG_ACPI_TOSHIBA=m
CONFIG_ACPI_BLACKLIST_YEAR=0
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_SYSTEM=y

# lsof |grep "/proc/acpi/event"
acpid     13843       root    3r      REG        0,3        0 4026532088 /proc/acpi/event


Even if I run strace against acpid I can't seen anything happening.


One interesting though, if I do : modprobe button
then every 30 seconds or so I get:
received event "battery BAT1 00000080 00000001"

Even when i do rmmod button I still keep getting these events.
The only way to go back to "normal" behaviour is to reboot.

Any suggestions as to what might be my problem here ?

TIA
Nigel.


_________________________________________________________________
Explore the seven wonders of the world
http://search.msn.com/results.aspx?q=7+wonders+world&mkt=en-US&form=QBRE