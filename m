From: Herman Sheremetyev <herman-6MNMYbGzEYJWk0Htik3J/w@public.gmane.org>
Subject: Re: Could not suspend device 0000:00:03.3: error -5
Date: Thu, 24 Mar 2005 14:42:59 -0500
Message-ID: <1111693379.24560.12.camel@camel>
References: <15470.1111693059@www7.gmx.net>
Reply-To: herman-6MNMYbGzEYJWk0Htik3J/w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <15470.1111693059-yE5ZZswNLZHk1uMJSBkQmQ@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Mario Ohnewald <mario.Ohnewald-Mmb7MZpHnFY@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Mario,

unload the ehci driver before suspending or upgrade your kernel to
2.6.11.

-Herman

On Thu, 2005-03-24 at 20:37 +0100, Mario Ohnewald wrote:
> Hello List,
> 
> i am running Debian testing with the kernel 2.6.8-2-686 and when i try to
> put my laptop into suspend to ram mode, i get this dmesg error:
> 
> PM: Preparing system for suspend
> Stopping tasks:
> =================================================================|
> NVRM: RmPowerManagement: 3
> Could not suspend device 0000:00:03.3: error -5
> NVRM: RmPowerManagement: 4
> Restarting tasks... done
> apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
> apm: overridden by ACPI.
> eth0: Media Link On 100mbps full-duplex
> 
> 
> 
> lspci:
> --------------------------
> 0000:00:03.3 USB Controller: Silicon Integrated Systems [SiS] USB 2.0
> Controller (prog-if 20 [EHCI])
>         Subsystem: Mitac: Unknown device 8640
>         Flags: bus master, medium devsel, latency 128, IRQ 209
>         Memory at f4001000 (32-bit, non-prefetchable) [size=4K]
>         Capabilities: [50] Power Management version 2
> 
> 
> 
> This is my grub menu:
> title           Debian GNU/Linux, kernel 2.6.8-2-686
> root            (hd0,0)
> kernel          /boot/vmlinuz-2.6.8-2-686 root=/dev/hda1 ro
> initrd          /boot/initrd.img-2.6.8-2-686
> savedefault
> boot
> 
> 
> 
> 
> dmesg | grep -i apm
> ---------------------------------------
> apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
> apm: overridden by ACPI.
> 
> SpiekLap:/home/spiekey# dmesg | grep -i acpi
> ACPI: PCI interrupt 0000:00:02.6[C] -> GSI 18 (level, low) -> IRQ 177
> ACPI: (supports S0 S3 S4 S5)
> ACPI: PCI interrupt 0000:00:09.0[A] -> GSI 17 (level, low) -> IRQ 169
> ACPI: PCI interrupt 0000:00:04.0[A] -> GSI 19 (level, low) -> IRQ 217
> ACPI: PCI interrupt 0000:00:02.7[C] -> GSI 18 (level, low) -> IRQ 177
> ACPI: PCI interrupt 0000:00:03.0[A] -> GSI 20 (level, low) -> IRQ 185
> ACPI: PCI interrupt 0000:00:03.1[B] -> GSI 21 (level, low) -> IRQ 193
> ACPI: PCI interrupt 0000:00:03.2[C] -> GSI 22 (level, low) -> IRQ 201
> shpchp: acpi_shpchprm:\_SB_.PCI0 evaluate _BBN fail=0x5
> shpchp: acpi_shpchprm:get_device PCI ROOT HID fail=0x5
> pciehp: acpi_pciehprm:\_SB_.PCI0 evaluate _BBN fail=0x5
> pciehp: acpi_pciehprm:get_device PCI ROOT HID fail=0x5
> ACPI: PCI interrupt 0000:00:02.3[B] -> GSI 17 (level, low) -> IRQ 169
> ACPI: PCI interrupt 0000:00:03.3[D] -> GSI 23 (level, low) -> IRQ 209
> ACPI: Battery Slot [BAT0] (battery present)
> ACPI: AC Adapter [AC] (on-line)
> ACPI: Processor [CPU0] (supports C1, 8 throttling states)
> ACPI: Power Button (FF) [PWRF]
> ACPI: Sleep Button (CM) [SBTN]
> ACPI: Lid Switch [LID]
> apm: overridden by ACPI.
> apm: overridden by ACPI.
> ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 225
> apm: overridden by ACPI.
> ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 225
> 
> 
> 
> any idea how i could fix this?
> 
> 
> 
> Thanks, Mario
> 
-- 
Herman Sheremetyev <herman-6MNMYbGzEYJWk0Htik3J/w@public.gmane.org>
n/a



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
