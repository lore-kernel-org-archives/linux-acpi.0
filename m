From: Cameron Harris <thecwin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Sleep states and swsusp2 on Clevo D410V
Date: Mon, 4 Apr 2005 17:25:19 +0100
Message-ID: <b6d0f5fb050404092558231462@mail.gmail.com>
Reply-To: Cameron Harris <thecwin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Both sleep states and swsusp2 don't work on my Clevo D410V (D4U)
laptop with 2.6.11.3 kernel.
swsusp2 used with the hibernate script oopses on "Thawing SMP &
Drivers 94/127mb":

Oops: 0002 [#1]
PREEMPT SMP
EIP is at _spin_lock+0x1f/0x90

Call trace:
rh_report_status
_spin_unlock
timer_interrupt
rh_report_status
run_timer_softirq
__do_softirq
irq_exit
apic_timer_interrupt
defailt_idle
cpu_idle
start_kernel
unknown_bootoption

Kernel panic - Not syncing: Fatal Exception in interrupt

and sleep states just don't do anything whatsoever,

# cat sleep
S0 S3 S4 S5
# echo "3" > sleep
# echo "0" > sleep
# echo -n "3" > sleep
# cd /sys/power
# cat state 
standby mem disk
# echo "standby" > state
# echo "mem" > state
# echo -n "standby" > state

Nothing happens and nothing is outputted on dmesg....

Included lots of info about laptop: (if someone wants the .config i can get it)

Laptop specs:
2.8GHz P4 (HT enabled), 256mb RAM
SiS 648FX, 800MHz FSB

# lspci
0000:00:00.0 Host bridge: Silicon Integrated Systems [SiS] SiS 645xx (rev 51)
0000:00:01.0 PCI bridge: Silicon Integrated Systems [SiS]: Unknown device 0003
0000:00:02.0 ISA bridge: Silicon Integrated Systems [SiS] SiS963
[MuTIOL Media IO] (rev 14)
0000:00:02.1 SMBus: Silicon Integrated Systems [SiS] SiS961/2 SMBus Controller
0000:00:02.3 FireWire (IEEE 1394): Silicon Integrated Systems [SiS]
FireWire Controller
0000:00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE]
0000:00:02.7 Multimedia audio controller: Silicon Integrated Systems
[SiS] Sound Controller (rev a0)
0000:00:03.0 USB Controller: Silicon Integrated Systems [SiS] USB 1.0
Controller (rev 0f)
0000:00:03.1 USB Controller: Silicon Integrated Systems [SiS] USB 1.0
Controller (rev 0f)
0000:00:03.2 USB Controller: Silicon Integrated Systems [SiS] USB 1.0
Controller (rev 0f)
0000:00:03.3 USB Controller: Silicon Integrated Systems [SiS] USB 2.0
Controller0000:00:0a.0 Ethernet controller: Realtek Semiconductor Co.,
Ltd. RTL-8169 Gigabit Ethernet (rev 10)
0000:00:0c.0 CardBus bridge: ENE Technology Inc CB1410 Cardbus
Controller (rev 01)
0000:01:00.0 VGA compatible controller: ATI Technologies Inc RV350
[Mobility Radeon 9600 M10]
0000:02:00.0 Ethernet controller: Atheros Communications, Inc. AR5212
802.11abg NIC (rev 01)

# lsusb
Bus 004 Device 001: ID 0000:0000
Bus 003 Device 001: ID 0000:0000
Bus 002 Device 002: ID 0ac8:301b Z-Star Microelectronics Corp.
Bus 002 Device 001: ID 0000:0000
Bus 001 Device 002: ID 07c4:a600 Datafab Systems, Inc.
Bus 001 Device 001: ID 0000:0000

# lsmod
Module                  Size  Used by
snd_pcm_oss            49952  0
snd_mixer_oss          18816  1 snd_pcm_oss
snd_seq_oss            35584  0
snd_seq_midi_event      7168  1 snd_seq_oss
snd_seq                53392  5 snd_seq_oss,snd_seq_midi_event
snd_seq_device          8332  2 snd_seq_oss,snd_seq
pcspkr                  4304  0
snd_intel8x0           30272  1
snd_ac97_codec         75896  1 snd_intel8x0
snd_pcm                85252  3 snd_pcm_oss,snd_intel8x0,snd_ac97_codec
snd_timer              22788  2 snd_seq,snd_pcm
snd                    50788  12
snd_pcm_oss,snd_mixer_oss,snd_seq_oss,snd_seq,snd_seq_device,snd_intel8x0,snd_ac97_codec,snd_pcm,snd_timer
snd_page_alloc          8708  2 snd_intel8x0,snd_pcm
wlan_wep                6656  1
fglrx                 238908  7
sis_agp                 7172  1
psmouse                27912  0
r8169                  22924  0
ath_pci                53920  0
ath_rate_onoe           7816  1 ath_pci
wlan                  107228  4 wlan_wep,ath_pci,ath_rate_onoe
ath_hal               132560  2 ath_pci

# cat /proc/acpi/info
version:                 20050211

-- 
Cameron Harris (thecwin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org)


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
