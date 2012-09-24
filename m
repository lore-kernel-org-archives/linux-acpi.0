From: "R, Durgadoss" <durgadoss.r@intel.com>
Subject: RE: HP laptop: fan off until CPU temp near 105 degrees C
Date: Mon, 24 Sep 2012 16:47:32 +0000
Message-ID: <4D68720C2E767A4AA6A8796D42C8EB591C9E51@BGSMSX102.gar.corp.intel.com>
References: <CALHKqSU44q6LakKrBKeNFFu7=xbipAog4URMLT0i5Yturo6w9w@mail.gmail.com>
 <4D68720C2E767A4AA6A8796D42C8EB591C9D47@BGSMSX102.gar.corp.intel.com>
 <CALHKqSXFhf7zoQWMrPDzgS0EGXN5xVxOHLu2j8Ysdtexk5prww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:24410 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756797Ab2IXQr7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Sep 2012 12:47:59 -0400
In-Reply-To: <CALHKqSXFhf7zoQWMrPDzgS0EGXN5xVxOHLu2j8Ysdtexk5prww@mail.gmail.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jack Kelly <jack-list@xlk.org.uk>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>

Hi Jack,

> -----Original Message-----
> From: jack.kelly.productions@googlemail.com
> [mailto:jack.kelly.productions@googlemail.com] On Behalf Of Jack Kelly
> Sent: Monday, September 24, 2012 9:03 PM
> To: R, Durgadoss
> Cc: linux-acpi@vger.kernel.org; Zhang, Rui
> Subject: Re: HP laptop: fan off until CPU temp near 105 degrees C
> 
> Dear Durga,
> 
> Thanks so much for your very quick reply! Sorry my first email was so
> long (and slightly grumpy on re-reading it!)
> 
> Answers to your questions:
> 
> -----------------
> 
> 1. What does your temp2_crit report ?
> 
> $ pwd
> /sys/class/hwmon/hwmon1/device
> 
> $ ls
> driver    name       temp2_crit        temp2_label  temp4_crit_alarm  temp4_max
> hwmon     power      temp2_crit_alarm  temp2_max    temp4_input       uevent
> modalias  subsystem  temp2_input       temp4_crit   temp4_label
> 
> $ cat name temp2_label temp2_input temp2_max temp2_crit
> temp2_crit_alarm
> coretemp <-- name
> Core 0 <-- label
> 104000 <-- input
> 95000 <-- max
> 105000 <-- crit
> 0 <-- crit_alarm

IMO, this crit_alarm should become 1 when your CPU temperature reaches
105 C. Does this happen ?

> 
> (the "cat" command above was run whilst the machine was also running
> "stress -c 8".  The fan had just started).
> 
> 
> ----------------------
> 
> 2. regarding trip_point_0_temp:
> 
> as far as I can tell, none of the 10 directories
> /sys/class/thermal/thermal_zone[0-9]/ contain temperature measurements
> from my CPU.  None of the thermal_zone?/temp files change when I
> heavily load my CPU.

No they won't change. The CPU temperature is reported under the
above hwmon sysfs you mentioned.

> 
> Instead the temp measurements from my CPU appear to live in
> /sys/class/hwmon/hwmon1/device.  There do not appear to be any
> "trip_point" files in /sys/class/hwmon/hwmon1/device.

No there won't be any trip_point files in hwmon.

> 
> --------------------
> 
> 3. Could you please post the output of all cooling_device?/type
> interfaces here ?
> 
> $ cat /sys/class/thermal/cooling_device?/type
> Processor
> Processor
> Processor
> Processor
> LCD

Okay, That explains a bit of it. You have CPU cores and LCD registered as
cooling devices. But I believe throttling these things would require some
intelligence/information from ACPI tables.. Not sure whether your
BIOS has them.. May be Rui can help us here..

> 
> But if I query the current state of each cooling device while the fan
> is running:
> 
> $ cat /sys/class/thermal/cooling_device?/cur_state
> 0
> 0
> 0
> 0
> 24

If we have processor throttling enabled, the first four 0's
should change to something non-zero number.

> 
> However, one further issue to mention is that when the core CPU temp
> gets to 105 degrees C under Linux, the fan does not run continuously.
> Instead the motherboard appears to rapidly turn the fan on and off
> (I've checked by applying a volt meter to the fan connector).  The end
> result is that the fan makes a sound a little like a hard disk
> seeking.  My naive guess would be that something like this is
> happening:  the CPU gets to 105 so the fan turns on so the CPU drops
> to 104 so the fan turns off so the CPU gets to 105 etc etc (is this
> called "hysteresis"?)

AFAIK, The coretemp driver does not do/handle any hysteresis like this.
My best guess is again the BIOS has something configured to do like this.

Thanks,
Durga

> 
> The fan runs continuously under Windows.
> 
> Thanks again for responding to my post.  It'd be wonderful to be able
> to fix this issue without having to resort to a soldering iron ;)
> 
> Thanks again,
> Jack
> 
> 
> 
> On 24 September 2012 15:21, R, Durgadoss <durgadoss.r@intel.com> wrote:
> > Hi Jack,
> >
> > That's a really long e-mail to start with..
> >
> > Some of your findings are correct:
> >
> > 1. Coretemp module does not control fan speed. It reports
> > only CPU temperature. Nothing inside /sys/class/thermal/
> > reports CPU temperature. temp2_max is not writeable.
> > What does your temp2_crit report ?
> >
> > 2. trip_point_0_temp is not writeable...But recently there are
> >   patches that make it writeable. If you are interested, please
> > give this patch here, a try:
> > http://www.spinics.net/lists/linux-pm/msg27925.html
> >
> > 3. Could you please post the output of all cooling_device?/type
> > interfaces here ?
> >
> > Thanks,
> > Durga
> >> -----Original Message-----
> >> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> >> owner@vger.kernel.org] On Behalf Of Jack Kelly
> >> Sent: Monday, September 24, 2012 2:43 PM
> >> To: linux-acpi@vger.kernel.org
> >> Subject: HP laptop: fan off until CPU temp near 105 degrees C
> >>
> >> Dear Linux ACPI list,
> >>
> >> I am having a serious problem with the control of the CPU fan on my HP
> >> ProBook 6450b laptop and it has been suggested to me that this may be
> >> a Linux ACPI issue.  When the machine first powers on, the fan runs
> >> (as expected).  If I boot into Windows then the fan continues running
> >> (as expected).  However, if I boot into Linux then the fan turns off
> >> during the boot sequence.  The fan does not turn on again until the
> >> CPU gets close to 105 degrees C, which sounds dangerously hot to me.
> >> I want the fan to run continually but I cannot find a way to make the
> >> fan run continually.
> >>
> >> *********************************
> >> Lots more details of this issue:
> >> *********************************
> >>
> >> This isn't a hardware issue
> >> ----------------------------
> >> The failure of the fan to start isn't a hardware issue: the fan is
> >> free from dust and the fan runs perfectly in Windows 7, grub, and the
> >> laptop BIOS screen.
> >>
> >>
> >> What's so bad about 105 degrees C?
> >> ----------------------------------
> >> The processor's specification sheet states that the processor (an i5)
> >> can handle a max core temp (t_junction) of 105 degrees C. But the
> >> plastic keyboard immediately above the CPU almost certainly can't! And
> >> my lap can't either (the side and the bottom of the laptop literally
> >> get too hot to touch). And the motherboard probably doesn't enjoy the
> >> thermal stresses either. There are reports on various forums of
> >> motherboards needing to be replaced and forced shutdowns due to
> >> overheating. So, however you look at it, the laptop CPU cores should
> >> never be allowed to get anywhere near 105 degrees C IMHO. Windows 7
> >> keeps the CPU below 70 degrees C, even under heavy load.
> >>
> >> The fact that Linux allows the CPU to get so hot is a very serious problem
> >> IMHO.
> >>
> >>
> >> The desired fix
> >> ---------------
> >> The problem is not to do with throttling the CPU. The solution is
> >> simple: the fan should just be on all the time. (I'm seriously
> >> considering just permanently connecting power to the fan.)  Or, even
> >> better, I (the user) should be allowed to specify the CPU temperature
> >> at which the fan turns on.
> >>
> >>
> >> Things I've tried
> >> -----------------
> >> Alternative Linux distros
> >> I'm running Ubuntu 12.04 64-bit so I thought I'd try some
> >> alternatives. They all exhibited exactly the same behaviour of the
> >> fan:
> >>
> >>     Fedora 17    64-bit live CD (kernel 3.3.4)
> >>     Ubuntu 12.10 pre-release 64-bit live CD (kernel 3.5)
> >>     Ubuntu 12.04 32-bit live CD (kernel 3.2.0)
> >>     Ubuntu 11.10 64-bit live CD (kernel 3.0.4)
> >>     Ubuntu 11.04 64-bit live CD (kernel 2.6.38)
> >>     Ubuntu 10.10 64-bit live CD (kernel 2.6.35)
> >>
> >>
> >> lm-sensors and fancontrol
> >> -------------------------
> >> I ran sensors-detect. It told me to add the coretemp module to
> >> /etc/modules, which I did.
> >>  - sensors reports the temperature of both my physical CPU cores.
> >>  - pwmconfig complains that "There are no pwm-capable sensor modules
> >> installed" so I can't use fancontrol.
> >>
> >>
> >> i8kutils
> >> --------
> >> Just reports the fans are set to "-1" and refuses to change them.
> >> (Yes, i8kmon is loaded.)
> >>
> >>
> >> Tinkering with the /proc/ or /sys/ file system
> >> ----------------------------------------------
> >> I don't have a /proc/acpi/fan directory. The directories
> >> /sys/class/thermal/thermal_zone?/ appear to only describe a few heat
> >> sensors on the motherboard (not the CPU temperatures reported by
> >> coretemp) and I can't seem to modify the trip_point_0_temp files.
> >>
> >> The CPU temps reported by coretemp seem to live in
> >> /sys/class/hwmon/hwmon1/device. If I attempt to change the max from
> 95
> >> degrees C to 50 degrees C by running
> >>
> >>    sudo bash -c "echo 50000 >
> >> /sys/class/hwmon/hwmon1/device/temp2_max"
> >>
> >> I get the following error:
> >>
> >>    bash: /sys/class/hwmon/hwmon1/device/temp2_max: Permission
> denied
> >>
> >> When my CPU fan does run (i.e. when the CPU temp gets near to 105
> >> degrees C) nothing changes in
> >> /sys/class/thermal/cooling_device?/cur_state. i.e. Linux doesn't
> >> appear to acknowledge that the fan has started to run.
> >>
> >> Incidentally, Hardware Monitor (running under Windows) can't find my
> >> CPU fan either (but the fan just magically works under Windows). So I
> >> guess my fan isn't exposing itself very clearly to the OS.
> >>
> >>
> >> Boot options
> >> ------------
> >> The following all had no effect:
> >>
> >>  - acpi.power_nocheck=1
> >>  - acpi_osi=Linux
> >>  - acpi_osi=linux
> >>  - acpi_osi=Windows
> >>  - acpi=strict
> >>
> >> The only thing I tried which had any effect on my CPU fan was starting
> >> with the boot option acpi=off. This allowed the fan to continue
> >> spinning even while Ubuntu was running. But completely disabling ACPI
> >> isn't a workable option for a production system.
> >>
> >>
> >> Talking directly to the fan controller over I2C
> >> -----------------------------------------------
> >> I guessed that my fan controller might be connected to the southbridge
> >> via I2C. So I tinkered with i2c-tools but i2cdetect always complained
> >> that the /dev/i2c-? files were not valid I2C devices. I tried loading
> >> a number of i2c-related modules but to no avail.
> >>
> >>
> >> What's controlling my CPU fan? The ACPI subsystem?
> >> --------------------------------------------------
> >> The evidence is somewhat contradictory. On the one hand, setting the
> >> boot option acpi=off successfully enables the fan, which suggests that
> >> the ACPI subsystem is switching off my fan during a normal boot. On
> >> the other hand, there's a bunch of evidence suggesting the fan isn't
> >> controlled by ACPI on this laptop:
> >>
> >> I dissassembled my DSDT and found that PNP0c0b is not present (which
> >> apparently is the code for a fan controller). Also, the evidence above
> >> in the "Tinkering with the /proc/ or /sys/ file system" section would
> >> suggest that my fan's controller isn't exposed over ACPI (or,
> >> alternatively, it is exposed over ACPI but Linux doesn't know how to
> >> handle it).
> >>
> >> I have noticed the following error in dmesg: [Firmware Bug]: ACPI:
> >> BIOS _OSI(Linux) query ignored
> >>
> >> My full dmesg output is at the bottom of this email.
> >>
> >>
> >> My guess at what's happening
> >> ----------------------------
> >> This is total guess work but I think this is how it's working at the
> >> moment: coretemp queries the CPU and finds that it can handle max
> temp
> >> (T_junction) of 105 degrees C. coretemp is not responsible for
> >> controlling the fan (apparently) so some other subsystem (hwmon? acpi?
> >> the BIOS?) must be taking the max temperatures stated by coretemp and
> >> using these as the set points for the fan.
> >>
> >>
> >> My system config
> >> ----------------
> >> HP ProBook 6450b with 4GB of RAM and a magnetic hard disk. I'm running
> >> the latest HP BIOS (version F.23, released 12 June 2012)
> >>
> >> CPU
> >>  - Name = Intel Core i5 450M. Two cores, each with 2 threads.
> >>  - Codename = Arrandale
> >>  - Specification = Intel(R) Core(TM) i5 CPU M 450 @ 2.40GHz
> >>  - Package (platform ID) = Socket 989 rPGA (0x4)
> >>  - CPUID = 6.5.5
> >>  - Extended CPUID = 6.25
> >>  - Core Stepping = K0
> >>
> >> Chipset
> >>  - Northbridge = Intel Havendale/Clarkdale Host Bridge rev. 02
> >>  - Southbridge = Intel HM57 rev. 05
> >>  - Memory Type = DDR3
> >>
> >> Monitoring
> >>  - Mainboard Model = 146D (0x000000DF - 0x00002220)
> >>  - LPCIO Vendor = SMSC
> >>  - LPCIO Vendor ID = 0x55
> >>  - LPCIO Chip ID = 0x4C
> >>
> >>
> >>
> >> Summary
> >> --------
> >> So, in summary: I'm 99% sure there's a bug in there somewhere. The fan
> >> really, really should turn on long before the CPU gets anywhere near
> >> 105 degrees C. I guess I have two questions: firstly, does anyone know
> >> a fix?! If not, can anyone suggest any further diagnostic tests I can
> >> run?
> >>
> >>
> >> Warmest regards,
> >> Jack
> >>
> >>
> >> dmesg:
> >> ------
> >>
> >> [    0.000000] Initializing cgroup subsys cpuset
> >> [    0.000000] Initializing cgroup subsys cpu
> >> [    0.000000] Linux version 3.2.0-31-generic (buildd@allspice) (gcc
> >> version 4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5) ) #50-Ubuntu SMP Fri Sep
> >> 7 16:16:45 UTC 2012 (Ubuntu 3.2.0-31.50-generic 3.2.28)
> >> [    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-3.2.0-31-
> generic
> >> root=UUID=f2ef5bd5-bb5d-484d-a638-ce1d9d6ac5e2 ro
> >> [    0.000000] KERNEL supported cpus:
> >> [    0.000000]   Intel GenuineIntel
> >> [    0.000000]   AMD AuthenticAMD
> >> [    0.000000]   Centaur CentaurHauls
> >> [    0.000000] BIOS-provided physical RAM map:
> >> [    0.000000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
> >> [    0.000000]  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
> >> [    0.000000]  BIOS-e820: 00000000000e0000 - 0000000000100000
> (reserved)
> >> [    0.000000]  BIOS-e820: 0000000000100000 - 00000000bafcf000 (usable)
> >> [    0.000000]  BIOS-e820: 00000000bafcf000 - 00000000bb6cf000 (reserved)
> >> [    0.000000]  BIOS-e820: 00000000bb6cf000 - 00000000bb7cf000 (ACPI
> NVS)
> >> [    0.000000]  BIOS-e820: 00000000bb7cf000 - 00000000bb7ff000 (ACPI
> data)
> >> [    0.000000]  BIOS-e820: 00000000bb7ff000 - 00000000bb800000 (usable)
> >> [    0.000000]  BIOS-e820: 00000000bb800000 - 00000000bc000000
> (reserved)
> >> [    0.000000]  BIOS-e820: 00000000e0000000 - 00000000f0000000
> (reserved)
> >> [    0.000000]  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
> >> [    0.000000]  BIOS-e820: 00000000fed10000 - 00000000fed14000
> (reserved)
> >> [    0.000000]  BIOS-e820: 00000000fed19000 - 00000000fed1a000
> (reserved)
> >> [    0.000000]  BIOS-e820: 00000000fed1b000 - 00000000fed20000
> (reserved)
> >> [    0.000000]  BIOS-e820: 00000000fee00000 - 00000000fee01000
> (reserved)
> >> [    0.000000]  BIOS-e820: 00000000ffd80000 - 0000000100000000 (reserved)
> >> [    0.000000]  BIOS-e820: 0000000100000000 - 0000000138000000 (usable)
> >> [    0.000000] NX (Execute Disable) protection: active
> >> [    0.000000] DMI 2.6 present.
> >> [    0.000000] DMI: Hewlett-Packard HP ProBook 6450b/146D, BIOS 68CDE
> >> Ver. F.23 06/13/2012
> >> [    0.000000] e820 update range: 0000000000000000 - 0000000000010000
> >> (usable) ==> (reserved)
> >> [    0.000000] e820 remove range: 00000000000a0000 - 0000000000100000
> >> (usable)
> >> [    0.000000] No AGP bridge found
> >> [    0.000000] last_pfn = 0x138000 max_arch_pfn = 0x400000000
> >> [    0.000000] MTRR default type: uncachable
> >> [    0.000000] MTRR fixed ranges enabled:
> >> [    0.000000]   00000-9FFFF write-back
> >> [    0.000000]   A0000-BFFFF uncachable
> >> [    0.000000]   C0000-FFFFF write-protect
> >> [    0.000000] MTRR variable ranges enabled:
> >> [    0.000000]   0 base 0FFC00000 mask FFFC00000 write-protect
> >> [    0.000000]   1 base 000000000 mask F80000000 write-back
> >> [    0.000000]   2 base 080000000 mask FC0000000 write-back
> >> [    0.000000]   3 base 0BC000000 mask FFC000000 uncachable
> >> [    0.000000]   4 base 100000000 mask FC0000000 write-back
> >> [    0.000000]   5 base 138000000 mask FF8000000 uncachable
> >> [    0.000000]   6 disabled
> >> [    0.000000]   7 disabled
> >> [    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new
> >> 0x7010600070106
> >> [    0.000000] last_pfn = 0xbb800 max_arch_pfn = 0x400000000
> >> [    0.000000] initial memory mapped : 0 - 20000000
> >> [    0.000000] Base memory trampoline at [ffff88000009a000] 9a000 size
> 20480
> >> [    0.000000] init_memory_mapping: 0000000000000000-
> 00000000bb800000
> >> [    0.000000]  0000000000 - 00bb800000 page 2M
> >> [    0.000000] kernel direct mapping tables up to bb800000 @ 1fffc000-
> >> 20000000
> >> [    0.000000] init_memory_mapping: 0000000100000000-
> 0000000138000000
> >> [    0.000000]  0100000000 - 0138000000 page 2M
> >> [    0.000000] kernel direct mapping tables up to 138000000 @ bafc9000-
> >> bafcf000
> >> [    0.000000] RAMDISK: 35848000 - 36c1c000
> >> [    0.000000] ACPI: RSDP 00000000000fc600 00024 (v02 HPQOEM)
> >> [    0.000000] ACPI: XSDT 00000000bb7fe120 00084 (v01 HPQOEM SLIC-MPC
> >> 0000000F      01000013)
> >> [    0.000000] ACPI: FACP 00000000bb7fc000 000F4 (v03 HPQOEM 146D
> >> 0000000F HP   00000001)
> >> [    0.000000] ACPI: DSDT 00000000bb7d8000 1ED5E (v02 HPQOEM 146D
> >> 00000001 INTL 20060912)
> >> [    0.000000] ACPI: FACS 00000000bb76d000 00040
> >> [    0.000000] ACPI: HPET 00000000bb7fb000 00038 (v01 HPQOEM 146D
> >> 00000001 HP   00000001)
> >> [    0.000000] ACPI: APIC 00000000bb7fa000 000BC (v01 HPQOEM 146D
> >> 00000001 HP   00000001)
> >> [    0.000000] ACPI: MCFG 00000000bb7f9000 0003C (v01 HPQOEM 146D
> >> 00000001 HP   00000001)
> >> [    0.000000] ACPI: ASF! 00000000bb7f8000 000A0 (v32 HPQOEM 146D
> >> 00000001 HP   00000001)
> >> [    0.000000] ACPI: TCPA 00000000bb7f7000 00032 (v02 HPQOEM 146D
> >> 00000000 HP   00000001)
> >> [    0.000000] ACPI: SSDT 00000000bb7d5000 00135 (v01 HPQOEM SataAhci
> >> 00001000 INTL 20060912)
> >> [    0.000000] ACPI: SSDT 00000000bb7d4000 00314 (v01 HPQOEM PtidDevc
> >> 00001000 INTL 20060912)
> >> [    0.000000] ACPI: SLIC 00000000bb7d3000 00176 (v01 HPQOEM SLIC-MPC
> >> 00000001 HP   00000001)
> >> [    0.000000] ACPI: SSDT 00000000bb7d2000 00A10 (v01  PmRef    CpuPm
> >> 00003000 INTL 20060912)
> >> [    0.000000] ACPI: SSDT 00000000bb7d1000 00288 (v01  PmRef  Cpu0Tst
> >> 00003000 INTL 20060912)
> >> [    0.000000] ACPI: SSDT 00000000bb7d0000 00225 (v01  PmRef    ApTst
> >> 00003000 INTL 20060912)
> >> [    0.000000] ACPI: Local APIC address 0xfee00000
> >> [    0.000000] No NUMA configuration found
> >> [    0.000000] Faking a node at 0000000000000000-0000000138000000
> >> [    0.000000] Initmem setup node 0 0000000000000000-0000000138000000
> >> [    0.000000]   NODE_DATA [0000000137ffb000 - 0000000137ffffff]
> >> [    0.000000]  [ffffea0000000000-ffffea0004dfffff] PMD ->
> >> [ffff880133800000-ffff8801375fffff] on node 0
> >> [    0.000000] Zone PFN ranges:
> >> [    0.000000]   DMA      0x00000010 -> 0x00001000
> >> [    0.000000]   DMA32    0x00001000 -> 0x00100000
> >> [    0.000000]   Normal   0x00100000 -> 0x00138000
> >> [    0.000000] Movable zone start PFN for each node
> >> [    0.000000] early_node_map[4] active PFN ranges
> >> [    0.000000]     0: 0x00000010 -> 0x0000009f
> >> [    0.000000]     0: 0x00000100 -> 0x000bafcf
> >> [    0.000000]     0: 0x000bb7ff -> 0x000bb800
> >> [    0.000000]     0: 0x00100000 -> 0x00138000
> >> [    0.000000] On node 0 totalpages: 995167
> >> [    0.000000]   DMA zone: 64 pages used for memmap
> >> [    0.000000]   DMA zone: 5 pages reserved
> >> [    0.000000]   DMA zone: 3914 pages, LIFO batch:0
> >> [    0.000000]   DMA32 zone: 16320 pages used for memmap
> >> [    0.000000]   DMA32 zone: 745488 pages, LIFO batch:31
> >> [    0.000000]   Normal zone: 3584 pages used for memmap
> >> [    0.000000]   Normal zone: 225792 pages, LIFO batch:31
> >> [    0.000000] ACPI: PM-Timer IO Port: 0x408
> >> [    0.000000] ACPI: Local APIC address 0xfee00000
> >> [    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
> >> [    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
> >> [    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x04] enabled)
> >> [    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x05] enabled)
> >> [    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x00] disabled)
> >> [    0.000000] ACPI: LAPIC (acpi_id[0x05] lapic_id[0x00] disabled)
> >> [    0.000000] ACPI: LAPIC (acpi_id[0x06] lapic_id[0x00] disabled)
> >> [    0.000000] ACPI: LAPIC (acpi_id[0x07] lapic_id[0x00] disabled)
> >> [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
> >> [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
> >> [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
> >> [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
> >> [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
> >> [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
> >> [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
> >> [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
> >> [    0.000000] ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
> >> [    0.000000] IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0-23
> >> [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> >> [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
> >> [    0.000000] ACPI: IRQ0 used by override.
> >> [    0.000000] ACPI: IRQ2 used by override.
> >> [    0.000000] ACPI: IRQ9 used by override.
> >> [    0.000000] Using ACPI (MADT) for SMP configuration information
> >> [    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
> >> [    0.000000] SMP: Allowing 8 CPUs, 4 hotplug CPUs
> >> [    0.000000] nr_irqs_gsi: 40
> >> [    0.000000] PM: Registered nosave memory: 000000000009f000 -
> >> 00000000000a0000
> >> [    0.000000] PM: Registered nosave memory: 00000000000a0000 -
> >> 00000000000e0000
> >> [    0.000000] PM: Registered nosave memory: 00000000000e0000 -
> >> 0000000000100000
> >> [    0.000000] PM: Registered nosave memory: 00000000bafcf000 -
> >> 00000000bb6cf000
> >> [    0.000000] PM: Registered nosave memory: 00000000bb6cf000 -
> >> 00000000bb7cf000
> >> [    0.000000] PM: Registered nosave memory: 00000000bb7cf000 -
> >> 00000000bb7ff000
> >> [    0.000000] PM: Registered nosave memory: 00000000bb800000 -
> >> 00000000bc000000
> >> [    0.000000] PM: Registered nosave memory: 00000000bc000000 -
> >> 00000000e0000000
> >> [    0.000000] PM: Registered nosave memory: 00000000e0000000 -
> >> 00000000f0000000
> >> [    0.000000] PM: Registered nosave memory: 00000000f0000000 -
> >> 00000000fec00000
> >> [    0.000000] PM: Registered nosave memory: 00000000fec00000 -
> >> 00000000fec01000
> >> [    0.000000] PM: Registered nosave memory: 00000000fec01000 -
> >> 00000000fed10000
> >> [    0.000000] PM: Registered nosave memory: 00000000fed10000 -
> >> 00000000fed14000
> >> [    0.000000] PM: Registered nosave memory: 00000000fed14000 -
> >> 00000000fed19000
> >> [    0.000000] PM: Registered nosave memory: 00000000fed19000 -
> >> 00000000fed1a000
> >> [    0.000000] PM: Registered nosave memory: 00000000fed1a000 -
> >> 00000000fed1b000
> >> [    0.000000] PM: Registered nosave memory: 00000000fed1b000 -
> >> 00000000fed20000
> >> [    0.000000] PM: Registered nosave memory: 00000000fed20000 -
> >> 00000000fee00000
> >> [    0.000000] PM: Registered nosave memory: 00000000fee00000 -
> >> 00000000fee01000
> >> [    0.000000] PM: Registered nosave memory: 00000000fee01000 -
> >> 00000000ffd80000
> >> [    0.000000] PM: Registered nosave memory: 00000000ffd80000 -
> >> 0000000100000000
> >> [    0.000000] Allocating PCI resources starting at bc000000 (gap:
> >> bc000000:24000000)
> >> [    0.000000] Booting paravirtualized kernel on bare hardware
> >> [    0.000000] setup_percpu: NR_CPUS:256 nr_cpumask_bits:256
> >> nr_cpu_ids:8 nr_node_ids:1
> >> [    0.000000] PERCPU: Embedded 28 pages/cpu @ffff880137c00000 s83136
> >> r8192 d23360 u262144
> >> [    0.000000] pcpu-alloc: s83136 r8192 d23360 u262144 alloc=1*2097152
> >> [    0.000000] pcpu-alloc: [0] 0 1 2 3 4 5 6 7
> >> [    0.000000] Built 1 zonelists in Node order, mobility grouping on.
> >> Total pages: 975194
> >> [    0.000000] Policy zone: Normal
> >> [    0.000000] Kernel command line:
> >> BOOT_IMAGE=/boot/vmlinuz-3.2.0-31-generic
> >> root=UUID=f2ef5bd5-bb5d-484d-a638-ce1d9d6ac5e2 ro
> >> [    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
> >> [    0.000000] Checking aperture...
> >> [    0.000000] No AGP bridge found
> >> [    0.000000] Calgary: detecting Calgary via BIOS EBDA area
> >> [    0.000000] Calgary: Unable to locate Rio Grande table in EBDA - bailing!
> >> [    0.000000] Memory: 3814096k/5111808k available (6558k kernel code,
> >> 1131140k absent, 166572k reserved, 6642k data, 920k init)
> >> [    0.000000] SLUB: Genslabs=15, HWalign=64, Order=0-3, MinObjects=0,
> >> CPUs=8, Nodes=1
> >> [    0.000000] Hierarchical RCU implementation.
> >> [    0.000000]        RCU dyntick-idle grace-period acceleration is enabled.
> >> [    0.000000] NR_IRQS:16640 nr_irqs:744 16
> >> [    0.000000] Extended CMOS year: 2000
> >> [    0.000000] Console: colour VGA+ 80x25
> >> [    0.000000] console [tty0] enabled
> >> [    0.000000] allocated 32505856 bytes of page_cgroup
> >> [    0.000000] please try 'cgroup_disable=memory' option if you don't
> >> want memory cgroups
> >> [    0.000000] hpet clockevent registered
> >> [    0.000000] Fast TSC calibration using PIT
> >> [    0.004000] Detected 2393.981 MHz processor.
> >> [    0.000003] Calibrating delay loop (skipped), value calculated
> >> using timer frequency.. 4787.96 BogoMIPS (lpj=9575924)
> >> [    0.000121] pid_max: default: 32768 minimum: 301
> >> [    0.000198] Security Framework initialized
> >> [    0.000265] AppArmor: AppArmor initialized
> >> [    0.000319] Yama: becoming mindful.
> >> [    0.000673] Dentry cache hash table entries: 524288 (order: 10,
> >> 4194304 bytes)
> >> [    0.001694] Inode-cache hash table entries: 262144 (order: 9, 2097152
> bytes)
> >> [    0.002166] Mount-cache hash table entries: 256
> >> [    0.002337] Initializing cgroup subsys cpuacct
> >> [    0.002396] Initializing cgroup subsys memory
> >> [    0.002455] Initializing cgroup subsys devices
> >> [    0.002511] Initializing cgroup subsys freezer
> >> [    0.002566] Initializing cgroup subsys blkio
> >> [    0.002624] Initializing cgroup subsys perf_event
> >> [    0.002706] CPU: Physical Processor ID: 0
> >> [    0.002761] CPU: Processor Core ID: 0
> >> [    0.002818] mce: CPU supports 9 MCE banks
> >> [    0.002881] CPU0: Thermal monitoring enabled (TM1)
> >> [    0.002943] using mwait in idle threads.
> >> [    0.005022] ACPI: Core revision 20110623
> >> [    0.013522] ftrace: allocating 27008 entries in 106 pages
> >> [    0.021702] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
> >> [    0.061387] CPU0: Intel(R) Core(TM) i5 CPU       M 450  @ 2.40GHz
> stepping
> >> 05
> >> [    0.167594] Performance Events: PEBS fmt1+, Westmere events, Intel
> >> PMU driver.
> >> [    0.167766] ... version:                3
> >> [    0.167827] ... bit width:              48
> >> [    0.167888] ... generic registers:      4
> >> [    0.167948] ... value mask:             0000ffffffffffff
> >> [    0.168012] ... max period:             000000007fffffff
> >> [    0.168077] ... fixed-purpose events:   3
> >> [    0.168138] ... event mask:             000000070000000f
> >> [    0.168399] NMI watchdog enabled, takes one hw-pmu counter.
> >> [    0.168544] Booting Node   0, Processors  #1
> >> [    0.168607] smpboot cpu 1: start_ip = 9a000
> >> [    0.279519] NMI watchdog enabled, takes one hw-pmu counter.
> >> [    0.279701]  #2
> >> [    0.279731] smpboot cpu 2: start_ip = 9a000
> >> [    0.387295] NMI watchdog enabled, takes one hw-pmu counter.
> >> [    0.387461]  #3
> >> [    0.387491] smpboot cpu 3: start_ip = 9a000
> >> [    0.495140] NMI watchdog enabled, takes one hw-pmu counter.
> >> [    0.495251] Brought up 4 CPUs
> >> [    0.495310] Total of 4 processors activated (19151.64 BogoMIPS).
> >> [    0.498269] devtmpfs: initialized
> >> [    0.499160] EVM: security.selinux
> >> [    0.499220] EVM: security.SMACK64
> >> [    0.499278] EVM: security.capability
> >> [    0.499949] PM: Registering ACPI NVS region at bb6cf000 (1048576 bytes)
> >> [    0.500804] print_constraints: dummy:
> >> [    0.500894] RTC time:  9:18:08, date: 09/24/12
> >> [    0.500987] NET: Registered protocol family 16
> >> [    0.501147] Trying to unpack rootfs image as initramfs...
> >> [    0.501152] ACPI FADT declares the system doesn't support PCIe
> >> ASPM, so disable it
> >> [    0.501154] ACPI: bus type pci registered
> >> [    0.501226] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem
> >> 0xe0000000-0xefffffff] (base 0xe0000000)
> >> [    0.501228] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in
> >> E820
> >> [    0.532935] PCI: Using configuration type 1 for base access
> >> [    0.533855] bio: create slab <bio-0> at 0
> >> [    0.534001] ACPI: Added _OSI(Module Device)
> >> [    0.534061] ACPI: Added _OSI(Processor Device)
> >> [    0.534122] ACPI: Added _OSI(3.0 _SCP Extensions)
> >> [    0.534183] ACPI: Added _OSI(Processor Aggregator Device)
> >> [    0.536028] ACPI: EC: Look up EC in DSDT
> >> [    0.560438] ACPI: Executed 1 blocks of module-level executable AML
> code
> >> [    0.602925] [Firmware Bug]: ACPI: BIOS _OSI(Linux) query ignored
> >> [    0.644497] ACPI: SSDT 00000000bb6c8918 003F9 (v01  PmRef  Cpu0Ist
> >> 00003000 INTL 20060912)
> >> [    0.645076] ACPI: Dynamic OEM Table Load:
> >> [    0.645184] ACPI: SSDT           (null) 003F9 (v01  PmRef  Cpu0Ist
> >> 00003000 INTL 20060912)
> >> [    0.645449] ACPI: SSDT 00000000bb6c6018 008AA (v01  PmRef  Cpu0Cst
> >> 00003001 INTL 20060912)
> >> [    0.646006] ACPI: Dynamic OEM Table Load:
> >> [    0.646114] ACPI: SSDT           (null) 008AA (v01  PmRef  Cpu0Cst
> >> 00003001 INTL 20060912)
> >> [    0.690959] ACPI: SSDT 00000000bb6c7a98 00303 (v01  PmRef    ApIst
> >> 00003000 INTL 20060912)
> >> [    0.691576] ACPI: Dynamic OEM Table Load:
> >> [    0.691685] ACPI: SSDT           (null) 00303 (v01  PmRef    ApIst
> >> 00003000 INTL 20060912)
> >> [    0.714785] ACPI: SSDT 00000000bb6c5d98 00119 (v01  PmRef    ApCst
> >> 00003000 INTL 20060912)
> >> [    0.715371] ACPI: Dynamic OEM Table Load:
> >> [    0.715479] ACPI: SSDT           (null) 00119 (v01  PmRef    ApCst
> >> 00003000 INTL 20060912)
> >> [    0.827677] Freeing initrd memory: 20304k freed
> >> [    1.165720] ACPI: Interpreter enabled
> >> [    1.165789] ACPI: (supports S0 S3 S4 S5)
> >> [    1.165968] ACPI: Using IOAPIC for interrupt routing
> >> [    1.167597] ACPI: Power Resource [APPR] (off)
> >> [    1.180859] ACPI: EC: GPE = 0x16, I/O: command/status = 0x66, data =
> 0x62
> >> [    1.181103] ACPI: No dock devices found.
> >> [    1.181164] HEST: Table not found.
> >> [    1.181225] PCI: Using host bridge windows from ACPI; if necessary,
> >> use "pci=nocrs" and report a bug
> >> [    1.182002] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-fe])
> >> [    1.182638] pci_root PNP0A08:00: host bridge window [io  0x0000-0x0cf7]
> >> [    1.182709] pci_root PNP0A08:00: host bridge window [io  0x0d00-0xffff]
> >> [    1.182778] pci_root PNP0A08:00: host bridge window [mem
> >> 0x000a0000-0x000bffff]
> >> [    1.182875] pci_root PNP0A08:00: host bridge window [mem
> >> 0xc0000000-0xdfffffff]
> >> [    1.182971] pci_root PNP0A08:00: host bridge window [mem
> >> 0xf0000000-0xfedfffff]
> >> [    1.183067] pci_root PNP0A08:00: host bridge window [mem
> >> 0xfee01000-0xffffffff]
> >> [    1.183173] pci 0000:00:00.0: [8086:0044] type 0 class 0x000600
> >> [    1.183191] DMAR: BIOS has allocated no shadow GTT; disabling IOMMU
> >> for graphics
> >> [    1.183307] pci 0000:00:02.0: [8086:0046] type 0 class 0x000300
> >> [    1.183317] pci 0000:00:02.0: reg 10: [mem 0xd0000000-0xd03fffff 64bit]
> >> [    1.183323] pci 0000:00:02.0: reg 18: [mem 0xc0000000-0xcfffffff 64bit
> pref]
> >> [    1.183327] pci 0000:00:02.0: reg 20: [io  0x4050-0x4057]
> >> [    1.183390] pci 0000:00:16.0: [8086:3b64] type 0 class 0x000780
> >> [    1.183418] pci 0000:00:16.0: reg 10: [mem 0xd4824000-0xd482400f 64bit]
> >> [    1.183509] pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
> >> [    1.183514] pci 0000:00:16.0: PME# disabled
> >> [    1.183552] pci 0000:00:19.0: [8086:10eb] type 0 class 0x000200
> >> [    1.183576] pci 0000:00:19.0: reg 10: [mem 0xd4800000-0xd481ffff]
> >> [    1.183587] pci 0000:00:19.0: reg 14: [mem 0xd482a000-0xd482afff]
> >> [    1.183599] pci 0000:00:19.0: reg 18: [io  0x4020-0x403f]
> >> [    1.183686] pci 0000:00:19.0: PME# supported from D0 D3hot D3cold
> >> [    1.183690] pci 0000:00:19.0: PME# disabled
> >> [    1.183719] pci 0000:00:1a.0: [8086:3b3c] type 0 class 0x000c03
> >> [    1.183743] pci 0000:00:1a.0: reg 10: [mem 0xd4829000-0xd48293ff]
> >> [    1.183849] pci 0000:00:1a.0: PME# supported from D0 D3hot D3cold
> >> [    1.183854] pci 0000:00:1a.0: PME# disabled
> >> [    1.183884] pci 0000:00:1b.0: [8086:3b56] type 0 class 0x000403
> >> [    1.183904] pci 0000:00:1b.0: reg 10: [mem 0xd4820000-0xd4823fff 64bit]
> >> [    1.183999] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
> >> [    1.184004] pci 0000:00:1b.0: PME# disabled
> >> [    1.184031] pci 0000:00:1c.0: [8086:3b42] type 1 class 0x000604
> >> [    1.184130] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
> >> [    1.184134] pci 0000:00:1c.0: PME# disabled
> >> [    1.184163] pci 0000:00:1c.1: [8086:3b44] type 1 class 0x000604
> >> [    1.184261] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
> >> [    1.184266] pci 0000:00:1c.1: PME# disabled
> >> [    1.184297] pci 0000:00:1c.2: [8086:3b46] type 1 class 0x000604
> >> [    1.184395] pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
> >> [    1.184400] pci 0000:00:1c.2: PME# disabled
> >> [    1.184428] pci 0000:00:1c.3: [8086:3b48] type 1 class 0x000604
> >> [    1.184527] pci 0000:00:1c.3: PME# supported from D0 D3hot D3cold
> >> [    1.184531] pci 0000:00:1c.3: PME# disabled
> >> [    1.184569] pci 0000:00:1d.0: [8086:3b34] type 0 class 0x000c03
> >> [    1.184593] pci 0000:00:1d.0: reg 10: [mem 0xd4828000-0xd48283ff]
> >> [    1.184701] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
> >> [    1.184705] pci 0000:00:1d.0: PME# disabled
> >> [    1.184729] pci 0000:00:1e.0: [8086:2448] type 1 class 0x000604
> >> [    1.184814] pci 0000:00:1f.0: [8086:3b0b] type 0 class 0x000601
> >> [    1.184941] pci 0000:00:1f.2: [8086:3b2f] type 0 class 0x000106
> >> [    1.184967] pci 0000:00:1f.2: reg 10: [io  0x4048-0x404f]
> >> [    1.184978] pci 0000:00:1f.2: reg 14: [io  0x405c-0x405f]
> >> [    1.184988] pci 0000:00:1f.2: reg 18: [io  0x4040-0x4047]
> >> [    1.184999] pci 0000:00:1f.2: reg 1c: [io  0x4058-0x405b]
> >> [    1.185010] pci 0000:00:1f.2: reg 20: [io  0x4000-0x401f]
> >> [    1.185020] pci 0000:00:1f.2: reg 24: [mem 0xd4827000-0xd48277ff]
> >> [    1.185086] pci 0000:00:1f.2: PME# supported from D3hot
> >> [    1.185091] pci 0000:00:1f.2: PME# disabled
> >> [    1.185123] pci 0000:00:1f.6: [8086:3b32] type 0 class 0x001180
> >> [    1.185150] pci 0000:00:1f.6: reg 10: [mem 0xd4826000-0xd4826fff 64bit]
> >> [    1.185301] pci 0000:00:1c.0: PCI bridge to [bus 01-01]
> >> [    1.185371] pci 0000:00:1c.0:   bridge window [mem 0xd4700000-
> 0xd47fffff]
> >> [    1.185431] pci 0000:00:1c.1: PCI bridge to [bus 02-42]
> >> [    1.185498] pci 0000:00:1c.1:   bridge window [io  0x2000-0x3fff]
> >> [    1.185503] pci 0000:00:1c.1:   bridge window [mem 0xd0700000-
> 0xd46fffff]
> >> [    1.185618] pci 0000:43:00.0: [1180:e822] type 0 class 0x000805
> >> [    1.185640] pci 0000:43:00.0: reg 10: [mem 0xd0603000-0xd06030ff]
> >> [    1.185800] pci 0000:43:00.0: supports D1 D2
> >> [    1.185802] pci 0000:43:00.0: PME# supported from D0 D1 D2 D3hot
> D3cold
> >> [    1.185808] pci 0000:43:00.0: PME# disabled
> >> [    1.185862] pci 0000:43:00.1: [1180:e230] type 0 class 0x000880
> >> [    1.185884] pci 0000:43:00.1: reg 10: [mem 0xd0602000-0xd06020ff]
> >> [    1.186048] pci 0000:43:00.1: supports D1 D2
> >> [    1.186049] pci 0000:43:00.1: PME# supported from D0 D1 D2 D3hot
> D3cold
> >> [    1.186055] pci 0000:43:00.1: PME# disabled
> >> [    1.186102] pci 0000:43:00.2: [1180:e852] type 0 class 0x000880
> >> [    1.186124] pci 0000:43:00.2: reg 10: [mem 0xd0601000-0xd06010ff]
> >> [    1.186284] pci 0000:43:00.2: supports D1 D2
> >> [    1.186286] pci 0000:43:00.2: PME# supported from D0 D1 D2 D3hot
> D3cold
> >> [    1.186292] pci 0000:43:00.2: PME# disabled
> >> [    1.186338] pci 0000:43:00.3: [1180:e832] type 0 class 0x000c00
> >> [    1.186360] pci 0000:43:00.3: reg 10: [mem 0xd0600000-0xd06007ff]
> >> [    1.186521] pci 0000:43:00.3: supports D1 D2
> >> [    1.186523] pci 0000:43:00.3: PME# supported from D0 D1 D2 D3hot
> D3cold
> >> [    1.186529] pci 0000:43:00.3: PME# disabled
> >> [    1.193984] pci 0000:00:1c.2: PCI bridge to [bus 43-43]
> >> [    1.194059] pci 0000:00:1c.2:   bridge window [mem 0xd0600000-
> 0xd06fffff]
> >> [    1.194179] pci 0000:44:00.0: [14e4:4727] type 0 class 0x000280
> >> [    1.194210] pci 0000:44:00.0: reg 10: [mem 0xd0500000-0xd0503fff 64bit]
> >> [    1.194368] pci 0000:44:00.0: supports D1 D2
> >> [    1.201943] pci 0000:00:1c.3: PCI bridge to [bus 44-44]
> >> [    1.202013] pci 0000:00:1c.3:   bridge window [mem 0xd0500000-
> 0xd05fffff]
> >> [    1.202092] pci 0000:00:1e.0: PCI bridge to [bus 45-45] (subtractive
> decode)
> >> [    1.202167] pci 0000:00:1e.0:   bridge window [mem 0xd0400000-
> 0xd04fffff]
> >> [    1.202175] pci 0000:00:1e.0:   bridge window [io  0x0000-0x0cf7]
> >> (subtractive decode)
> >> [    1.202176] pci 0000:00:1e.0:   bridge window [io  0x0d00-0xffff]
> >> (subtractive decode)
> >> [    1.202178] pci 0000:00:1e.0:   bridge window [mem
> >> 0x000a0000-0x000bffff] (subtractive decode)
> >> [    1.202180] pci 0000:00:1e.0:   bridge window [mem
> >> 0xc0000000-0xdfffffff] (subtractive decode)
> >> [    1.202182] pci 0000:00:1e.0:   bridge window [mem
> >> 0xf0000000-0xfedfffff] (subtractive decode)
> >> [    1.202184] pci 0000:00:1e.0:   bridge window [mem
> >> 0xfee01000-0xffffffff] (subtractive decode)
> >> [    1.202215] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
> >> [    1.202409] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
> >> [    1.202455] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP01._PRT]
> >> [    1.202482] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP02._PRT]
> >> [    1.202529] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP03._PRT]
> >> [    1.202569] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP04._PRT]
> >> [    1.202951]  pci0000:00: Requesting ACPI _OSC control (0x1d)
> >> [    1.204015]  pci0000:00: ACPI _OSC control (0x1d) granted
> >> [    1.209353] ACPI: PCI Root Bridge [CPBG] (domain 0000 [bus ff])
> >> [    1.209481] pci 0000:ff:00.0: [8086:2c62] type 0 class 0x000600
> >> [    1.209499] pci 0000:ff:00.1: [8086:2d01] type 0 class 0x000600
> >> [    1.209518] pci 0000:ff:02.0: [8086:2d10] type 0 class 0x000600
> >> [    1.209534] pci 0000:ff:02.1: [8086:2d11] type 0 class 0x000600
> >> [    1.209551] pci 0000:ff:02.2: [8086:2d12] type 0 class 0x000600
> >> [    1.209566] pci 0000:ff:02.3: [8086:2d13] type 0 class 0x000600
> >> [    1.209595]  pci0000:ff: Requesting ACPI _OSC control (0x1d)
> >> [    1.209663]  pci0000:ff: ACPI _OSC request failed (AE_NOT_FOUND),
> >> returned control mask: 0x1d
> >> [    1.209762] ACPI _OSC control for PCIe not granted, disabling ASPM
> >> [    1.210028] ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 *10 12 14 15)
> >> [    1.210422] ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 *5 6 7 11 12 14 15)
> >> [    1.210813] ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 *10 12 14 15)
> >> [    1.211206] ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 11 12
> >> 14 15) *10
> >> [    1.211647] ACPI: PCI Interrupt Link [LNKE] (IRQs 1 3 4 5 6 7 *10 12 14 15)
> >> [    1.212040] ACPI: PCI Interrupt Link [LNKF] (IRQs 1 3 4 5 6 7 *11 12 14 15)
> >> [    1.212432] ACPI: PCI Interrupt Link [LNKG] (IRQs 1 3 4 5 6 7 10 12
> >> 14 15) *0, disabled.
> >> [    1.212900] ACPI: PCI Interrupt Link [LNKH] (IRQs 1 3 4 5 6 7 11 12
> >> 14 15) *0, disabled.
> >> [    1.213431] vgaarb: device added:
> >> PCI:0000:00:02.0,decodes=io+mem,owns=io+mem,locks=none
> >> [    1.213535] vgaarb: loaded
> >> [    1.213592] vgaarb: bridge control possible 0000:00:02.0
> >> [    1.213742] i2c-core: driver [aat2870] using legacy suspend method
> >> [    1.213811] i2c-core: driver [aat2870] using legacy resume method
> >> [    1.213936] SCSI subsystem initialized
> >> [    1.214053] libata version 3.00 loaded.
> >> [    1.214091] usbcore: registered new interface driver usbfs
> >> [    1.214164] usbcore: registered new interface driver hub
> >> [    1.214252] usbcore: registered new device driver usb
> >> [    1.214388] PCI: Using ACPI for IRQ routing
> >> [    1.224312] PCI: pci_cache_line_size set to 64 bytes
> >> [    1.224398] reserve RAM buffer: 000000000009fc00 - 000000000009ffff
> >> [    1.224400] reserve RAM buffer: 00000000bafcf000 - 00000000bbffffff
> >> [    1.224402] reserve RAM buffer: 00000000bb800000 - 00000000bbffffff
> >> [    1.224487] NetLabel: Initializing
> >> [    1.224546] NetLabel:  domain hash size = 128
> >> [    1.224602] NetLabel:  protocols = UNLABELED CIPSOv4
> >> [    1.224672] NetLabel:  unlabeled traffic allowed by default
> >> [    1.224784] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
> >> [    1.225071] hpet0: 8 comparators, 64-bit 14.318180 MHz counter
> >> [    1.227154] Switching to clocksource hpet
> >> [    1.232742] AppArmor: AppArmor Filesystem Enabled
> >> [    1.232838] pnp: PnP ACPI init
> >> [    1.232912] ACPI: bus type pnp registered
> >> [    1.233323] pnp 00:00: [bus 00-fe]
> >> [    1.233326] pnp 00:00: [io  0x0000-0x0cf7 window]
> >> [    1.233327] pnp 00:00: [io  0x0cf8-0x0cff]
> >> [    1.233329] pnp 00:00: [io  0x0d00-0xffff window]
> >> [    1.233331] pnp 00:00: [mem 0x000a0000-0x000bffff window]
> >> [    1.233332] pnp 00:00: [mem 0x000c0000-0x000c3fff window]
> >> [    1.233334] pnp 00:00: [mem 0x000c4000-0x000c7fff window]
> >> [    1.233335] pnp 00:00: [mem 0x000c8000-0x000cbfff window]
> >> [    1.233337] pnp 00:00: [mem 0x000cc000-0x000cffff window]
> >> [    1.233338] pnp 00:00: [mem 0x000d0000-0x000d3fff window]
> >> [    1.233340] pnp 00:00: [mem 0x000d4000-0x000d7fff window]
> >> [    1.233341] pnp 00:00: [mem 0x000d8000-0x000dbfff window]
> >> [    1.233343] pnp 00:00: [mem 0x000dc000-0x000dffff window]
> >> [    1.233345] pnp 00:00: [mem 0x000e0000-0x000e3fff window]
> >> [    1.233346] pnp 00:00: [mem 0x000e4000-0x000e7fff window]
> >> [    1.233348] pnp 00:00: [mem 0x000e8000-0x000ebfff window]
> >> [    1.233349] pnp 00:00: [mem 0x000ec000-0x000effff window]
> >> [    1.233351] pnp 00:00: [mem 0x000f0000-0x000fffff window]
> >> [    1.233352] pnp 00:00: [mem 0xc0000000-0xdfffffff window]
> >> [    1.233354] pnp 00:00: [mem 0xf0000000-0xfedfffff window]
> >> [    1.233356] pnp 00:00: [mem 0xfee01000-0xffffffff window]
> >> [    1.233448] pnp 00:00: Plug and Play ACPI device, IDs PNP0a08
> >> PNP0a03 (active)
> >> [    1.233621] pnp 00:01: [mem 0xfed1c000-0xfed1ffff]
> >> [    1.233623] pnp 00:01: [mem 0xfed10000-0xfed13fff]
> >> [    1.233624] pnp 00:01: [mem 0xfed1b000-0xfed1bfff]
> >> [    1.233626] pnp 00:01: [mem 0xfed19000-0xfed19fff]
> >> [    1.233627] pnp 00:01: [mem 0xd4900000-0xd4900fff]
> >> [    1.233629] pnp 00:01: [mem 0xe0000000-0xefffffff]
> >> [    1.233630] pnp 00:01: [mem 0xfed20000-0xfed3ffff]
> >> [    1.233632] pnp 00:01: [mem 0xfed90000-0xfed8ffff disabled]
> >> [    1.233633] pnp 00:01: [mem 0xfed45000-0xfed8ffff]
> >> [    1.233635] pnp 00:01: [mem 0xfec00000-0xfec00fff]
> >> [    1.233687] system 00:01: [mem 0xfed1c000-0xfed1ffff] has been
> reserved
> >> [    1.233758] system 00:01: [mem 0xfed10000-0xfed13fff] has been
> reserved
> >> [    1.233827] system 00:01: [mem 0xfed1b000-0xfed1bfff] has been
> reserved
> >> [    1.233897] system 00:01: [mem 0xfed19000-0xfed19fff] has been
> reserved
> >> [    1.233966] system 00:01: [mem 0xd4900000-0xd4900fff] has been
> reserved
> >> [    1.234035] system 00:01: [mem 0xe0000000-0xefffffff] has been
> reserved
> >> [    1.234105] system 00:01: [mem 0xfed20000-0xfed3ffff] has been
> reserved
> >> [    1.234175] system 00:01: [mem 0xfed45000-0xfed8ffff] has been
> reserved
> >> [    1.234245] system 00:01: [mem 0xfec00000-0xfec00fff] could not be
> >> reserved
> >> [    1.234316] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
> >> [    1.234382] pnp 00:02: [io  0x0000-0x001f]
> >> [    1.234384] pnp 00:02: [io  0x0081-0x0091]
> >> [    1.234387] pnp 00:02: [io  0x0093-0x009f]
> >> [    1.234388] pnp 00:02: [io  0x00c0-0x00df]
> >> [    1.234390] pnp 00:02: [dma 4]
> >> [    1.234418] pnp 00:02: Plug and Play ACPI device, IDs PNP0200 (active)
> >> [    1.234425] pnp 00:03: [mem 0xff000000-0xffffffff]
> >> [    1.234449] pnp 00:03: Plug and Play ACPI device, IDs INT0800 (active)
> >> [    1.234492] pnp 00:04: [io  0xfe00-0xfe0f]
> >> [    1.234494] pnp 00:04: [io  0xfe80-0xfe8f]
> >> [    1.234495] pnp 00:04: [mem 0xfed40000-0xfed44fff]
> >> [    1.234526] pnp 00:04: Plug and Play ACPI device, IDs IFX0102
> >> PNP0c31 (active)
> >> [    1.234592] pnp 00:05: [mem 0xfed00000-0xfed003ff]
> >> [    1.234622] pnp 00:05: Plug and Play ACPI device, IDs PNP0103 (active)
> >> [    1.234630] pnp 00:06: [io  0x00f0]
> >> [    1.234642] pnp 00:06: [irq 13]
> >> [    1.234668] pnp 00:06: Plug and Play ACPI device, IDs PNP0c04 (active)
> >> [    1.234676] pnp 00:07: [io  0x002e-0x002f]
> >> [    1.234678] pnp 00:07: [io  0x004e-0x004f]
> >> [    1.234679] pnp 00:07: [io  0x0061]
> >> [    1.234680] pnp 00:07: [io  0x0063]
> >> [    1.234681] pnp 00:07: [io  0x0065]
> >> [    1.234683] pnp 00:07: [io  0x0067]
> >> [    1.234684] pnp 00:07: [io  0x0070]
> >> [    1.234685] pnp 00:07: [io  0x0080]
> >> [    1.234686] pnp 00:07: [io  0x0092]
> >> [    1.234688] pnp 00:07: [io  0x00b2-0x00b3]
> >> [    1.234689] pnp 00:07: [io  0x0200-0x027f]
> >> [    1.234690] pnp 00:07: [io  0x1000-0x100f]
> >> [    1.234691] pnp 00:07: [io  0xffff]
> >> [    1.234693] pnp 00:07: [io  0xffff]
> >> [    1.234694] pnp 00:07: [io  0x0400-0x047f]
> >> [    1.234695] pnp 00:07: [io  0x0500-0x057f]
> >> [    1.234697] pnp 00:07: [io  0xef80-0xef9f]
> >> [    1.234741] system 00:07: [io  0x0200-0x027f] has been reserved
> >> [    1.234808] system 00:07: [io  0x1000-0x100f] has been reserved
> >> [    1.234875] system 00:07: [io  0xffff] has been reserved
> >> [    1.234941] system 00:07: [io  0xffff] has been reserved
> >> [    1.235005] system 00:07: [io  0x0400-0x047f] has been reserved
> >> [    1.235073] system 00:07: [io  0x0500-0x057f] has been reserved
> >> [    1.235140] system 00:07: [io  0xef80-0xef9f] has been reserved
> >> [    1.235223] system 00:07: Plug and Play ACPI device, IDs PNP0c02 (active)
> >> [    1.235230] pnp 00:08: [io  0x0070-0x0077]
> >> [    1.235236] pnp 00:08: [irq 8]
> >> [    1.235266] pnp 00:08: Plug and Play ACPI device, IDs PNP0b00 (active)
> >> [    1.235378] pnp 00:09: [io  0x0060]
> >> [    1.235380] pnp 00:09: [io  0x0064]
> >> [    1.235386] pnp 00:09: [irq 1]
> >> [    1.235420] pnp 00:09: Plug and Play ACPI device, IDs PNP0303 (active)
> >> [    1.235431] pnp 00:0a: [irq 12]
> >> [    1.235459] pnp 00:0a: Plug and Play ACPI device, IDs SYN0179
> >> SYN0100 SYN0002 PNP0f13 (active)
> >> [    1.235658] pnp 00:0b: [irq 23]
> >> [    1.235696] pnp 00:0b: Plug and Play ACPI device, IDs HPQ0004 (active)
> >> [    1.235808] pnp 00:0c: [bus ff]
> >> [    1.235848] pnp 00:0c: Plug and Play ACPI device, IDs PNP0a03 (active)
> >> [    1.235958] pnp: PnP ACPI: found 13 devices
> >> [    1.236019] ACPI: ACPI bus type pnp unregistered
> >> [    1.242789] PCI: max bus depth: 1 pci_try_num: 2
> >> [    1.242843] pci 0000:00:1c.1: BAR 15: assigned [mem
> >> 0xd4a00000-0xd4bfffff 64bit pref]
> >> [    1.242939] pci 0000:00:1c.0: PCI bridge to [bus 01-01]
> >> [    1.243008] pci 0000:00:1c.0:   bridge window [mem 0xd4700000-
> 0xd47fffff]
> >> [    1.243086] pci 0000:00:1c.1: PCI bridge to [bus 02-42]
> >> [    1.243161] pci 0000:00:1c.1:   bridge window [io  0x2000-0x3fff]
> >> [    1.243233] pci 0000:00:1c.1:   bridge window [mem 0xd0700000-
> 0xd46fffff]
> >> [    1.243305] pci 0000:00:1c.1:   bridge window [mem
> >> 0xd4a00000-0xd4bfffff 64bit pref]
> >> [    1.243407] pci 0000:00:1c.2: PCI bridge to [bus 43-43]
> >> [    1.243475] pci 0000:00:1c.2:   bridge window [mem 0xd0600000-
> 0xd06fffff]
> >> [    1.243553] pci 0000:00:1c.3: PCI bridge to [bus 44-44]
> >> [    1.243621] pci 0000:00:1c.3:   bridge window [mem 0xd0500000-
> 0xd05fffff]
> >> [    1.243699] pci 0000:00:1e.0: PCI bridge to [bus 45-45]
> >> [    1.243769] pci 0000:00:1e.0:   bridge window [mem 0xd0400000-
> 0xd04fffff]
> >> [    1.243861] pci 0000:00:1c.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
> >> [    1.243934] pci 0000:00:1c.0: setting latency timer to 64
> >> [    1.243945] pci 0000:00:1c.1: PCI INT B -> GSI 16 (level, low) -> IRQ 16
> >> [    1.244018] pci 0000:00:1c.1: setting latency timer to 64
> >> [    1.244028] pci 0000:00:1c.2: PCI INT C -> GSI 18 (level, low) -> IRQ 18
> >> [    1.244101] pci 0000:00:1c.2: setting latency timer to 64
> >> [    1.244111] pci 0000:00:1c.3: PCI INT D -> GSI 19 (level, low) -> IRQ 19
> >> [    1.244184] pci 0000:00:1c.3: setting latency timer to 64
> >> [    1.244191] pci 0000:00:1e.0: setting latency timer to 64
> >> [    1.244196] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7]
> >> [    1.244198] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff]
> >> [    1.244199] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff]
> >> [    1.244201] pci_bus 0000:00: resource 7 [mem 0xc0000000-0xdfffffff]
> >> [    1.244203] pci_bus 0000:00: resource 8 [mem 0xf0000000-0xfedfffff]
> >> [    1.244204] pci_bus 0000:00: resource 9 [mem 0xfee01000-0xffffffff]
> >> [    1.244206] pci_bus 0000:01: resource 1 [mem 0xd4700000-0xd47fffff]
> >> [    1.244208] pci_bus 0000:02: resource 0 [io  0x2000-0x3fff]
> >> [    1.244210] pci_bus 0000:02: resource 1 [mem 0xd0700000-0xd46fffff]
> >> [    1.244212] pci_bus 0000:02: resource 2 [mem 0xd4a00000-0xd4bfffff
> >> 64bit pref]
> >> [    1.244214] pci_bus 0000:43: resource 1 [mem 0xd0600000-0xd06fffff]
> >> [    1.244216] pci_bus 0000:44: resource 1 [mem 0xd0500000-0xd05fffff]
> >> [    1.244218] pci_bus 0000:45: resource 1 [mem 0xd0400000-0xd04fffff]
> >> [    1.244220] pci_bus 0000:45: resource 4 [io  0x0000-0x0cf7]
> >> [    1.244222] pci_bus 0000:45: resource 5 [io  0x0d00-0xffff]
> >> [    1.244223] pci_bus 0000:45: resource 6 [mem 0x000a0000-0x000bffff]
> >> [    1.244225] pci_bus 0000:45: resource 7 [mem 0xc0000000-0xdfffffff]
> >> [    1.244227] pci_bus 0000:45: resource 8 [mem 0xf0000000-0xfedfffff]
> >> [    1.244229] pci_bus 0000:45: resource 9 [mem 0xfee01000-0xffffffff]
> >> [    1.244263] NET: Registered protocol family 2
> >> [    1.244441] IP route cache hash table entries: 131072 (order: 8,
> >> 1048576 bytes)
> >> [    1.245240] TCP established hash table entries: 524288 (order: 11,
> >> 8388608 bytes)
> >> [    1.246949] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
> >> [    1.247249] TCP: Hash tables configured (established 524288 bind 65536)
> >> [    1.247319] TCP reno registered
> >> [    1.247387] UDP hash table entries: 2048 (order: 4, 65536 bytes)
> >> [    1.247476] UDP-Lite hash table entries: 2048 (order: 4, 65536 bytes)
> >> [    1.247641] NET: Registered protocol family 1
> >> [    1.247721] pci 0000:00:02.0: Boot video device
> >> [    1.247741] pci 0000:00:1a.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
> >> [    1.247845] pci 0000:00:1a.0: PCI INT A disabled
> >> [    1.247938] pci 0000:00:1d.0: PCI INT A -> GSI 20 (level, low) -> IRQ 20
> >> [    1.248036] pci 0000:00:1d.0: PCI INT A disabled
> >> [    1.248137] PCI: CLS 64 bytes, default 64
> >> [    1.248139] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
> >> [    1.248208] Placing 64MB software IO TLB between ffff8800b6fc9000 -
> >> ffff8800bafc9000
> >> [    1.248304] software IO TLB at phys 0xb6fc9000 - 0xbafc9000
> >> [    1.248841] audit: initializing netlink socket (disabled)
> >> [    1.248920] type=2000 audit(1348478288.088:1): initialized
> >> [    1.269455] HugeTLB registered 2 MB page size, pre-allocated 0 pages
> >> [    1.271294] VFS: Disk quotas dquot_6.5.2
> >> [    1.271401] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
> >> [    1.271887] fuse init (API version 7.17)
> >> [    1.272024] msgmni has been set to 7489
> >> [    1.272476] Block layer SCSI generic (bsg) driver version 0.4
> >> loaded (major 253)
> >> [    1.272601] io scheduler noop registered
> >> [    1.272664] io scheduler deadline registered
> >> [    1.272752] io scheduler cfq registered (default)
> >> [    1.272911] pcieport 0000:00:1c.0: setting latency timer to 64
> >> [    1.272969] pcieport 0000:00:1c.0: irq 40 for MSI/MSI-X
> >> [    1.273051] pcieport 0000:00:1c.1: setting latency timer to 64
> >> [    1.273101] pcieport 0000:00:1c.1: irq 41 for MSI/MSI-X
> >> [    1.273188] pcieport 0000:00:1c.2: setting latency timer to 64
> >> [    1.273237] pcieport 0000:00:1c.2: irq 42 for MSI/MSI-X
> >> [    1.273314] pcieport 0000:00:1c.3: setting latency timer to 64
> >> [    1.273363] pcieport 0000:00:1c.3: irq 43 for MSI/MSI-X
> >> [    1.273459] pcieport 0000:00:1c.0: Signaling PME through PCIe PME
> interrupt
> >> [    1.273533] pcie_pme 0000:00:1c.0:pcie01: service driver pcie_pme
> loaded
> >> [    1.273552] pcieport 0000:00:1c.1: Signaling PME through PCIe PME
> interrupt
> >> [    1.273625] pcie_pme 0000:00:1c.1:pcie01: service driver pcie_pme
> loaded
> >> [    1.273642] pcieport 0000:00:1c.2: Signaling PME through PCIe PME
> interrupt
> >> [    1.273714] pci 0000:43:00.0: Signaling PME through PCIe PME interrupt
> >> [    1.273783] pci 0000:43:00.1: Signaling PME through PCIe PME interrupt
> >> [    1.273852] pci 0000:43:00.2: Signaling PME through PCIe PME interrupt
> >> [    1.274506] pci 0000:43:00.3: Signaling PME through PCIe PME interrupt
> >> [    1.274578] pcie_pme 0000:00:1c.2:pcie01: service driver pcie_pme
> loaded
> >> [    1.274596] pcieport 0000:00:1c.3: Signaling PME through PCIe PME
> interrupt
> >> [    1.274666] pci 0000:44:00.0: Signaling PME through PCIe PME interrupt
> >> [    1.274737] pcie_pme 0000:00:1c.3:pcie01: service driver pcie_pme
> loaded
> >> [    1.274749] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
> >> [    1.274872] pciehp 0000:00:1c.1:pcie04: HPC vendor_id 8086
> >> device_id 3b44 ss_vid 103c ss_did 146d
> >> [    1.274994] pciehp 0000:00:1c.1:pcie04: service driver pciehp loaded
> >> [    1.275000] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
> >> [    1.275131] intel_idle: MWAIT substates: 0x1120
> >> [    1.275133] intel_idle: v0.4 model 0x25
> >> [    1.275134] intel_idle: lapic_timer_reliable_states 0xffffffff
> >> [    1.275279] ACPI: Deprecated procfs I/F for AC is loaded, please
> >> retry with CONFIG_ACPI_PROCFS_POWER cleared
> >> [    1.275464] ACPI: AC Adapter [AC] (on-line)
> >> [    1.275712] input: Sleep Button as
> >> /devices/LNXSYSTM:00/device:00/PNP0C0E:00/input/input0
> >> [    1.275815] ACPI: Sleep Button [SLPB]
> >> [    1.275907] input: Lid Switch as
> >> /devices/LNXSYSTM:00/device:00/PNP0C0D:00/input/input1
> >> [    1.276025] ACPI: Lid Switch [LID]
> >> [    1.276113] input: Power Button as
> >> /devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
> >> [    1.276210] ACPI: Power Button [PWRF]
> >> [    1.283935] thermal LNXTHERM:00: registered as thermal_zone0
> >> [    1.284002] ACPI: Thermal Zone [EXTZ] (23 C)
> >> [    1.284098] thermal LNXTHERM:01: registered as thermal_zone1
> >> [    1.284165] ACPI: Thermal Zone [EX2Z] (0 C)
> >> [    1.284268] thermal LNXTHERM:02: registered as thermal_zone2
> >> [    1.284334] ACPI: Thermal Zone [PWMZ] (0 C)
> >> [    1.286920] thermal LNXTHERM:03: registered as thermal_zone3
> >> [    1.286987] ACPI: Thermal Zone [LOCZ] (24 C)
> >> [    1.287435] thermal LNXTHERM:04: registered as thermal_zone4
> >> [    1.287502] ACPI: Thermal Zone [GFXZ] (0 C)
> >> [    1.298707] thermal LNXTHERM:05: registered as thermal_zone5
> >> [    1.298774] ACPI: Thermal Zone [BATZ] (20 C)
> >> [    1.308382] thermal LNXTHERM:06: registered as thermal_zone6
> >> [    1.308449] ACPI: Thermal Zone [EGXZ] (0 C)
> >> [    1.308757] thermal LNXTHERM:07: registered as thermal_zone7
> >> [    1.308823] ACPI: Thermal Zone [CPUZ] (127 C)
> >> [    1.309028] thermal LNXTHERM:08: registered as thermal_zone8
> >> [    1.309096] ACPI: Thermal Zone [MCHZ] (0 C)
> >> [    1.309296] thermal LNXTHERM:09: registered as thermal_zone9
> >> [    1.309363] ACPI: Thermal Zone [PCHZ] (59 C)
> >> [    1.309445] ACPI: Deprecated procfs I/F for battery is loaded,
> >> please retry with CONFIG_ACPI_PROCFS_POWER cleared
> >> [    1.309554] ACPI: Battery Slot [BAT0] (battery absent)
> >> [    1.309629] ACPI: Deprecated procfs I/F for battery is loaded,
> >> please retry with CONFIG_ACPI_PROCFS_POWER cleared
> >> [    1.309642] ACPI: Battery Slot [BAT0] (battery absent)
> >> [    1.309799] ACPI: Battery Slot [BAT1] (battery absent)
> >> [    1.309864] ACPI: Battery Slot [BAT1] (battery absent)
> >> [    1.309952] ERST: Table is not found!
> >> [    1.310013] GHES: HEST is not enabled!
> >> [    1.310140] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
> >> [    1.503094] Linux agpgart interface v0.103
> >> [    1.503224] agpgart-intel 0000:00:00.0: Intel HD Graphics Chipset
> >> [    1.503380] agpgart-intel 0000:00:00.0: detected gtt size: 2097152K
> >> total, 262144K mappable
> >> [    1.504241] agpgart-intel 0000:00:00.0: detected 32768K stolen memory
> >> [    1.504466] agpgart-intel 0000:00:00.0: AGP aperture is 256M @
> 0xc0000000
> >> [    1.505825] brd: module loaded
> >> [    1.506532] loop: module loaded
> >> [    1.506736] ahci 0000:00:1f.2: version 3.0
> >> [    1.506759] ahci 0000:00:1f.2: PCI INT A -> GSI 21 (level, low) -> IRQ 21
> >> [    1.506880] ahci 0000:00:1f.2: irq 44 for MSI/MSI-X
> >> [    1.506917] ahci: SSS flag set, parallel bus scan disabled
> >> [    1.522717] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 3
> >> Gbps 0x37 impl SATA mode
> >> [    1.522822] ahci 0000:00:1f.2: flags: 64bit ncq sntf stag pm led
> >> clo pio slum part ems sxs apst
> >> [    1.522925] ahci 0000:00:1f.2: setting latency timer to 64
> >> [    1.555071] scsi0 : ahci
> >> [    1.555225] scsi1 : ahci
> >> [    1.555349] scsi2 : ahci
> >> [    1.555474] scsi3 : ahci
> >> [    1.555600] scsi4 : ahci
> >> [    1.555722] scsi5 : ahci
> >> [    1.555973] ata1: SATA max UDMA/133 abar m2048@0xd4827000 port
> >> 0xd4827100 irq 44
> >> [    1.556070] ata2: SATA max UDMA/133 abar m2048@0xd4827000 port
> >> 0xd4827180 irq 44
> >> [    1.556167] ata3: SATA max UDMA/133 abar m2048@0xd4827000 port
> >> 0xd4827200 irq 44
> >> [    1.556264] ata4: DUMMY
> >> [    1.556321] ata5: SATA max UDMA/133 abar m2048@0xd4827000 port
> >> 0xd4827300 irq 44
> >> [    1.556418] ata6: SATA max UDMA/133 abar m2048@0xd4827000 port
> >> 0xd4827380 irq 44
> >> [    1.556811] Fixed MDIO Bus: probed
> >> [    1.556886] tun: Universal TUN/TAP device driver, 1.6
> >> [    1.556950] tun: (C) 1999-2004 Max Krasnyansky
> <maxk@qualcomm.com>
> >> [    1.557086] PPP generic driver version 2.4.2
> >> [    1.557262] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> >> [    1.557346] ehci_hcd 0000:00:1a.0: PCI INT A -> GSI 16 (level, low) -> IRQ
> 16
> >> [    1.557436] ehci_hcd 0000:00:1a.0: setting latency timer to 64
> >> [    1.557440] ehci_hcd 0000:00:1a.0: EHCI Host Controller
> >> [    1.557555] ehci_hcd 0000:00:1a.0: new USB bus registered, assigned
> >> bus number 1
> >> [    1.557679] ehci_hcd 0000:00:1a.0: debug port 2
> >> [    1.561630] ehci_hcd 0000:00:1a.0: cache line size of 64 is not supported
> >> [    1.561645] ehci_hcd 0000:00:1a.0: irq 16, io mem 0xd4829000
> >> [    1.574587] ehci_hcd 0000:00:1a.0: USB 2.0 started, EHCI 1.00
> >> [    1.574784] hub 1-0:1.0: USB hub found
> >> [    1.574848] hub 1-0:1.0: 2 ports detected
> >> [    1.574966] ehci_hcd 0000:00:1d.0: PCI INT A -> GSI 20 (level, low) -> IRQ
> 20
> >> [    1.575049] ehci_hcd 0000:00:1d.0: setting latency timer to 64
> >> [    1.575052] ehci_hcd 0000:00:1d.0: EHCI Host Controller
> >> [    1.575163] ehci_hcd 0000:00:1d.0: new USB bus registered, assigned
> >> bus number 2
> >> [    1.575282] ehci_hcd 0000:00:1d.0: debug port 2
> >> [    1.579242] ehci_hcd 0000:00:1d.0: cache line size of 64 is not supported
> >> [    1.579257] ehci_hcd 0000:00:1d.0: irq 20, io mem 0xd4828000
> >> [    1.594551] ehci_hcd 0000:00:1d.0: USB 2.0 started, EHCI 1.00
> >> [    1.594740] hub 2-0:1.0: USB hub found
> >> [    1.594803] hub 2-0:1.0: 2 ports detected
> >> [    1.594913] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
> >> [    1.594989] uhci_hcd: USB Universal Host Controller Interface driver
> >> [    1.595094] usbcore: registered new interface driver libusual
> >> [    1.595192] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M]
> >> at 0x60,0x64 irq 1,12
> >> [    1.597010] i8042: Detected active multiplexing controller, rev 1.1
> >> [    1.597848] serio: i8042 KBD port at 0x60,0x64 irq 1
> >> [    1.597916] serio: i8042 AUX0 port at 0x60,0x64 irq 12
> >> [    1.597985] serio: i8042 AUX1 port at 0x60,0x64 irq 12
> >> [    1.598090] serio: i8042 AUX2 port at 0x60,0x64 irq 12
> >> [    1.598171] serio: i8042 AUX3 port at 0x60,0x64 irq 12
> >> [    1.598322] mousedev: PS/2 mouse device common for all mice
> >> [    1.598559] rtc_cmos 00:08: RTC can wake from S4
> >> [    1.598728] rtc_cmos 00:08: rtc core: registered rtc_cmos as rtc0
> >> [    1.598826] rtc0: alarms up to one month, y3k, 242 bytes nvram, hpet irqs
> >> [    1.598958] device-mapper: uevent: version 1.0.3
> >> [    1.599084] device-mapper: ioctl: 4.22.0-ioctl (2011-10-19)
> >> initialised: dm-devel@redhat.com
> >> [    1.599266] cpuidle: using governor ladder
> >> [    1.599446] cpuidle: using governor menu
> >> [    1.599506] EFI Variables Facility v0.08 2004-May-17
> >> [    1.599764] TCP cubic registered
> >> [    1.599902] NET: Registered protocol family 10
> >> [    1.600360] NET: Registered protocol family 17
> >> [    1.600426] Registering the dns_resolver key type
> >> [    1.600615] PM: Hibernation image not present or could not be loaded.
> >> [    1.600628] registered taskstats version 1
> >> [    1.610898]   Magic number: 12:47:324
> >> [    1.611016] tty tty49: hash matches
> >> [    1.611110] acpi PNP0B00:00: hash matches
> >> [    1.611269] rtc_cmos 00:08: setting system clock to 2012-09-24
> >> 09:18:09 UTC (1348478289)
> >> [    1.612256] BIOS EDD facility v0.16 2004-Jun-25, 0 devices found
> >> [    1.612323] EDD information not available.
> >> [    1.621072] input: AT Translated Set 2 keyboard as
> >> /devices/platform/i8042/serio0/input/input3
> >> [    1.874156] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> >> [    1.874974] ata1.00: unexpected _GTF length (8)
> >> [    1.875315] ata1.00: ATA-8: Hitachi HTS725032A9A364, PC3OC72E, max
> >> UDMA/100
> >> [    1.875389] ata1.00: 625142448 sectors, multi 16: LBA48 NCQ (depth
> 31/32),
> >> AA
> >> [    1.876412] ata1.00: unexpected _GTF length (8)
> >> [    1.876746] ata1.00: configured for UDMA/100
> >> [    1.877162] scsi 0:0:0:0: Direct-Access     ATA      Hitachi
> >> HTS72503 PC3O PQ: 0 ANSI: 5
> >> [    1.877480] sd 0:0:0:0: Attached scsi generic sg0 type 0
> >> [    1.877527] sd 0:0:0:0: [sda] 625142448 512-byte logical blocks:
> >> (320 GB/298 GiB)
> >> [    1.877680] sd 0:0:0:0: [sda] Write Protect is off
> >> [    1.877770] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
> >> [    1.877844] sd 0:0:0:0: [sda] Write cache: enabled, read cache:
> >> enabled, doesn't support DPO or FUA
> >> [    1.886134] usb 1-1: new high-speed USB device number 2 using
> ehci_hcd
> >> [    1.940007]  sda: sda1 sda2 sda3 < sda5 sda6 >
> >> [    1.941565] sd 0:0:0:0: [sda] Attached SCSI disk
> >> [    2.018847] hub 1-1:1.0: USB hub found
> >> [    2.019040] hub 1-1:1.0: 6 ports detected
> >> [    2.129745] usb 2-1: new high-speed USB device number 2 using
> ehci_hcd
> >> [    2.193604] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> >> [    2.213233] ata2.00: unexpected _GTF length (8)
> >> [    2.213304] ata2.00: ATAPI: hp       CDDVDW TS-L633N, 0300, max
> UDMA/100
> >> [    2.234760] ata2.00: unexpected _GTF length (8)
> >> [    2.234831] ata2.00: configured for UDMA/100
> >> [    2.240009] scsi 1:0:0:0: CD-ROM            hp       CDDVDW
> >> TS-L633N  0300 PQ: 0 ANSI: 5
> >> [    2.245488] Refined TSC clocksource calibration: 2393.996 MHz.
> >> [    2.245562] Switching to clocksource tsc
> >> [    2.248583] sr0: scsi3-mmc drive: 24x/24x writer dvd-ram cd/rw
> >> xa/form2 cdda tray
> >> [    2.248674] cdrom: Uniform CD-ROM driver Revision: 3.20
> >> [    2.248977] sr 1:0:0:0: Attached scsi CD-ROM sr0
> >> [    2.249182] sr 1:0:0:0: Attached scsi generic sg1 type 5
> >> [    2.262328] hub 2-1:1.0: USB hub found
> >> [    2.262465] hub 2-1:1.0: 8 ports detected
> >> [    2.333496] usb 1-1.3: new full-speed USB device number 3 using
> ehci_hcd
> >> [    2.497215] usb 1-1.5: new high-speed USB device number 4 using
> ehci_hcd
> >> [    2.568948] ata3: SATA link down (SStatus 0 SControl 300)
> >> [    2.888390] ata5: SATA link down (SStatus 0 SControl 300)
> >> [    3.207839] ata6: SATA link down (SStatus 0 SControl 300)
> >> [    3.209564] Freeing unused kernel memory: 920k freed
> >> [    3.210355] Write protecting the kernel read-only data: 12288k
> >> [    3.215443] Freeing unused kernel memory: 1616k freed
> >> [    3.219422] Freeing unused kernel memory: 1200k freed
> >> [    3.239703] udevd[109]: starting version 175
> >> [    3.266328] [drm] Initialized drm 1.1.0 20060810
> >> [    3.266529] e1000e: Intel(R) PRO/1000 Network Driver - 1.5.1-k
> >> [    3.266591] e1000e: Copyright(c) 1999 - 2011 Intel Corporation.
> >> [    3.266691] e1000e 0000:00:19.0: PCI INT A -> GSI 20 (level, low) -> IRQ 20
> >> [    3.266771] e1000e 0000:00:19.0: setting latency timer to 64
> >> [    3.266910] e1000e 0000:00:19.0: irq 45 for MSI/MSI-X
> >> [    3.272545] firewire_ohci 0000:43:00.3: PCI INT D -> GSI 17 (level,
> >> low) -> IRQ 17
> >> [    3.272641] firewire_ohci 0000:43:00.3: setting latency timer to 64
> >> [    3.274152] sdhci: Secure Digital Host Controller Interface driver
> >> [    3.274219] sdhci: Copyright(c) Pierre Ossman
> >> [    3.277077] wmi: Mapper loaded
> >> [    3.335711] firewire_ohci: Added fw-ohci device 0000:43:00.3, OHCI
> >> v1.10, 4 IR + 4 IT contexts, quirks 0x11
> >> [    3.335942] sdhci-pci 0000:43:00.0: SDHCI controller found
> >> [1180:e822] (rev 1)
> >> [    3.336053] sdhci-pci 0000:43:00.0: PCI INT A -> GSI 18 (level,
> >> low) -> IRQ 18
> >> [    3.336220] sdhci-pci 0000:43:00.0: Will use DMA mode even though
> >> HW doesn't fully claim to support it.
> >> [    3.336329] sdhci-pci 0000:43:00.0: setting latency timer to 64
> >> [    3.336349] mmc0: no vmmc regulator found
> >> [    3.336442] Registered led device: mmc0::
> >> [    3.337484] mmc0: SDHCI controller on PCI [0000:43:00.0] using DMA
> >> [    3.483459] e1000e 0000:00:19.0: eth0: (PCI Express:2.5GT/s:Width
> >> x1) 1c:c1:de:b2:a6:2e
> >> [    3.483565] e1000e 0000:00:19.0: eth0: Intel(R) PRO/1000 Network
> >> Connection
> >> [    3.483681] e1000e 0000:00:19.0: eth0: MAC: 9, PHY: 10, PBA No: FFFFFF-
> 0FF
> >> [    3.483849] i915 0000:00:02.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
> >> [    3.483923] i915 0000:00:02.0: setting latency timer to 64
> >> [    3.527006] i915 0000:00:02.0: irq 46 for MSI/MSI-X
> >> [    3.527011] [drm] Supports vblank timestamp caching Rev 1 (10.10.2010).
> >> [    3.527084] [drm] Driver supports precise vblank timestamp query.
> >> [    3.527189] vgaarb: device changed decodes:
> >> PCI:0000:00:02.0,olddecodes=io+mem,decodes=io+mem:owns=io+mem
> >> [    3.834963] firewire_core: created device fw0: GUID 5566778811223344,
> >> S400
> >> [    4.059486] fbcon: inteldrmfb (fb0) is primary device
> >> [    4.325380] Console: switching to colour frame buffer device 200x56
> >> [    4.328798] fb0: inteldrmfb frame buffer device
> >> [    4.328800] drm: registered panic notifier
> >> [    4.333758] acpi device:0e: registered as cooling_device4
> >> [    4.334005] input: Video Bus as
> >>
> /devices/LNXSYSTM:00/device:00/PNP0A08:00/LNXVIDEO:01/input/input4
> >> [    4.334122] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post:
> no)
> >> [    4.334223] [drm] Initialized i915 1.6.0 20080730 for 0000:00:02.0 on minor
> 0
> >> [    4.766990] EXT4-fs (sda5): mounted filesystem with ordered data
> >> mode. Opts: (null)
> >> [   24.352058] ADDRCONF(NETDEV_UP): eth0: link is not ready
> >> [   24.372676] udevd[409]: starting version 175
> >> [   24.384405] lp: driver loaded but no devices found
> >> [   24.432637] Adding 4881404k swap on /dev/sda6.  Priority:-1
> >> extents:1 across:4881404k
> >> [   24.456744] tpm_tis 00:04: 1.2 TPM (device-id 0xB, rev-id 16)
> >> [   24.470523] hp_accel: hardware type HPB64xx found
> >> [   24.471766] mei: module is from the staging directory, the quality
> >> is unknown, you have been warned.
> >> [   24.472194] mei 0000:00:16.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
> >> [   24.472202] mei 0000:00:16.0: setting latency timer to 64
> >> [   24.472280] mei 0000:00:16.0: irq 47 for MSI/MSI-X
> >> [   24.472337] lis3lv02d: 8 bits sensor found
> >> [   24.477930] Blacklisted intel_ips for HP ProBook
> >> [   24.484742] lib80211: common routines for IEEE802.11 drivers
> >> [   24.484745] lib80211_crypt: registered algorithm 'NULL'
> >> [   24.493959] wl: module license 'MIXED/Proprietary' taints kernel.
> >> [   24.493963] Disabling lock debugging due to kernel taint
> >> [   24.504026] wl 0000:44:00.0: PCI INT A -> GSI 19 (level, low) -> IRQ 19
> >> [   24.504038] wl 0000:44:00.0: setting latency timer to 64
> >> [   24.527069] input: ST LIS3LV02DL Accelerometer as
> >> /devices/platform/lis3lv02d/input/input5
> >> [   24.527233] Registered led device: hp::hddprotect
> >> [   24.527263] hp_accel: driver loaded
> >> [   24.531646] udevd[425]: renamed network interface eth0 to eth3
> >> [   24.541272] Linux video capture interface: v2.00
> >> [   24.541711] uvcvideo: Found UVC 1.00 device Villem (0461:4db6)
> >> [   24.542995] lib80211_crypt: registered algorithm 'TKIP'
> >> [   24.543303] eth0: Broadcom BCM4727 802.11 Hybrid Wireless
> >> Controller 5.100.82.38
> >> [   24.551061] input: Villem as
> >> /devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.5/1-1.5:1.0/input/input6
> >> [   24.551230] usbcore: registered new interface driver uvcvideo
> >> [   24.551233] USB Video Class driver (1.1.1)
> >> [   24.620129] snd_hda_intel 0000:00:1b.0: power state changed by ACPI to
> D0
> >> [   24.620140] snd_hda_intel 0000:00:1b.0: power state changed by ACPI to
> D0
> >> [   24.620153] snd_hda_intel 0000:00:1b.0: PCI INT A -> GSI 16 (level,
> >> low) -> IRQ 16
> >> [   24.620259] snd_hda_intel 0000:00:1b.0: irq 48 for MSI/MSI-X
> >> [   24.620299] snd_hda_intel 0000:00:1b.0: setting latency timer to 64
> >> [   24.644948] type=1400 audit(1348474712.569:2): apparmor="STATUS"
> >> operation="profile_load" name="/sbin/dhclient" pid=676
> >> comm="apparmor_parser"
> >> [   24.644957] type=1400 audit(1348474712.569:3): apparmor="STATUS"
> >> operation="profile_replace" name="/sbin/dhclient" pid=593
> >> comm="apparmor_parser"
> >> [   24.645422] type=1400 audit(1348474712.569:4): apparmor="STATUS"
> >> operation="profile_load"
> >> name="/usr/lib/NetworkManager/nm-dhcp-client.action" pid=676
> >> comm="apparmor_parser"
> >> [   24.645432] type=1400 audit(1348474712.569:5): apparmor="STATUS"
> >> operation="profile_replace"
> >> name="/usr/lib/NetworkManager/nm-dhcp-client.action" pid=593
> >> comm="apparmor_parser"
> >> [   24.645704] type=1400 audit(1348474712.569:6): apparmor="STATUS"
> >> operation="profile_load"
> >> name="/usr/lib/connman/scripts/dhclient-script" pid=676
> >> comm="apparmor_parser"
> >> [   24.645715] type=1400 audit(1348474712.569:7): apparmor="STATUS"
> >> operation="profile_replace"
> >> name="/usr/lib/connman/scripts/dhclient-script" pid=593
> >> comm="apparmor_parser"
> >> [   24.648408] type=1400 audit(1348474712.573:8): apparmor="STATUS"
> >> operation="profile_load" name="/usr/sbin/ntpd" pid=800
> >> comm="apparmor_parser"
> >> [   24.649172] type=1400 audit(1348474712.573:9): apparmor="STATUS"
> >> operation="profile_replace" name="/usr/sbin/ntpd" pid=802
> >> comm="apparmor_parser"
> >> [   24.679398] udevd[422]: renamed network interface eth0 to eth1
> >> [   24.687350] HDMI status: Codec=3 Pin=4 Presence_Detect=0
> ELD_Valid=0
> >> [   24.687414] HDMI status: Codec=3 Pin=5 Presence_Detect=0
> ELD_Valid=0
> >> [   24.687471] HDMI status: Codec=3 Pin=6 Presence_Detect=0
> ELD_Valid=0
> >> [   24.687569] input: HDA Intel HDMI/DP,pcm=8 as
> >> /devices/pci0000:00/0000:00:1b.0/sound/card0/input7
> >> [   24.688100] input: HDA Intel HDMI/DP,pcm=7 as
> >> /devices/pci0000:00/0000:00:1b.0/sound/card0/input8
> >> [   24.689681] input: HDA Intel HDMI/DP,pcm=3 as
> >> /devices/pci0000:00/0000:00:1b.0/sound/card0/input9
> >> [   24.690034] input: HDA Intel Line as
> >> /devices/pci0000:00/0000:00:1b.0/sound/card0/input10
> >> [   24.690184] input: HDA Intel Mic as
> >> /devices/pci0000:00/0000:00:1b.0/sound/card0/input11
> >> [   24.690333] input: HDA Intel Dock Headphone as
> >> /devices/pci0000:00/0000:00:1b.0/sound/card0/input12
> >> [   24.690485] input: HDA Intel Headphone as
> >> /devices/pci0000:00/0000:00:1b.0/sound/card0/input13
> >> [   24.758861] EXT4-fs (sda5): re-mounted. Opts: errors=remount-
> >> ro,user_xattr
> >> [   24.826745] input: HP WMI hotkeys as /devices/virtual/input/input14
> >> [   25.142935] init: failsafe main process (957) killed by TERM signal
> >> [   25.303817] psmouse serio4: synaptics: Touchpad model: 1, fw: 7.2,
> >> id: 0x1c0b1, caps: 0xd04733/0xa40000/0xa0000
> >> [   25.304623] Bluetooth: Core ver 2.16
> >> [   25.304650] NET: Registered protocol family 31
> >> [   25.304652] Bluetooth: HCI device and connection manager initialized
> >> [   25.304655] Bluetooth: HCI socket layer initialized
> >> [   25.304657] Bluetooth: L2CAP socket layer initialized
> >> [   25.304663] Bluetooth: SCO socket layer initialized
> >> [   25.307802] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
> >> [   25.307806] Bluetooth: BNEP filters: protocol multicast
> >> [   25.313731] Bluetooth: RFCOMM TTY layer initialized
> >> [   25.313737] Bluetooth: RFCOMM socket layer initialized
> >> [   25.313739] Bluetooth: RFCOMM ver 1.11
> >> [   25.341266] type=1400 audit(1348474713.265:10): apparmor="STATUS"
> >> operation="profile_replace" name="/sbin/dhclient" pid=1056
> >> comm="apparmor_parser"
> >> [   25.341719] type=1400 audit(1348474713.269:11): apparmor="STATUS"
> >> operation="profile_replace"
> >> name="/usr/lib/NetworkManager/nm-dhcp-client.action" pid=1056
> >> comm="apparmor_parser"
> >> [   25.349915] input: SynPS/2 Synaptics TouchPad as
> >> /devices/platform/i8042/serio4/input/input15
> >> [   25.383995] ppdev: user-space parallel port driver
> >> [   25.481592] e1000e 0000:00:19.0: irq 45 for MSI/MSI-X
> >> [   25.537333] e1000e 0000:00:19.0: irq 45 for MSI/MSI-X
> >> [   25.537896] ADDRCONF(NETDEV_UP): eth3: link is not ready
> >> [   25.538313] ADDRCONF(NETDEV_UP): eth3: link is not ready
> >> [   25.540084] ADDRCONF(NETDEV_UP): eth1: link is not ready
> >> [   25.607191] init: gdm main process (1159) killed by TERM signal
> >> [   28.726332] e1000e: eth3 NIC Link is Up 1000 Mbps Full Duplex, Flow
> >> Control: Rx
> >> [   28.726737] ADDRCONF(NETDEV_CHANGE): eth3: link becomes ready
> >> [   39.465232] eth3: no IPv6 routers present
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
