From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: swsusp fails with "FATAL: cannot find swap device, try swapon
 -a!"
Date: Mon, 28 Feb 2005 03:20:25 +0100
Message-ID: <42227FE9.1080400@gmx.net>
References: <42225F85.1000302@gmx.net> <20050228000401.GK1441@elf.ucw.cz> <4222640C.7090706@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
In-Reply-To: <4222640C.7090706-hi6Y0CQ0nG0@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Cc: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Carl-Daniel Hailfinger schrieb:
> Pavel Machek schrieb:
> 
>>Hi!
>>
>>
>>
>>>since 2.6.10-rcsomething (don't know exact revision), suspend-to-disk
>>>fails on my machine. dmesg excerpt:
>>>
>>>[...]
>>>Adding 530104k swap on /dev/hda6.  Priority:42 extents:1
>>>[...]
>>>PM: suspend-to-disk mode set to 'shutdown'
>>>Stopping tasks: ===================================================|
>>>Freeing memory... done (60654 pages freed)
>>>PM: Attempting to suspend to disk.
>>>PM: snapshotting memory.
>>>swsusp: FATAL: cannot find swap device, try swapon -a!
>>>PCI: Setting latency timer of device 0000:00:1d.0 to 64
>>>PCI: Setting latency timer of device 0000:00:1d.1 to 64
>>>PCI: Setting latency timer of device 0000:00:1d.2 to 64
>>>PCI: cache line size of 32 is not supported by device 0000:00:1d.7
>>>ehci_hcd 0000:00:1d.7: USB 2.0 restarted, EHCI 1.00, driver 10 Dec 2004
>>>ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 5 (level, low) -> IRQ 5
>>>ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 5 (level, low) -> IRQ 5
>>>PCI: Setting latency timer of device 0000:00:1f.5 to 64
>>>eth0: link down
>>>ACPI: PCI interrupt 0000:02:01.2[C] -> GSI 5 (level, low) -> IRQ 5
>>>eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
>>>Restarting tasks... done
>>>[...]
>>>
>>>And I have absolutely no idea what's going wrong. Kernel is vanilla
>>>bk tree from 10 days ago. .config is similar to SUSE .config, but I
>>>left out some drivers I don't need.
>>>
>>>Any idea what could be wrong with my setup?
>>
>>
>>And you have resume= on command line, right? CONFIG_..._STD_PARTITION
>>should not be required, but I have it set like this:
>>
>>pavel@amd:~$ cat /proc/cmdline
>>root=/dev/hda4 resume=/dev/hda1 psmouse.psmouse_proto=imps psmouse_proto=imps psmouse.proto=imps
>>pavel@amd:~$ grep hda1 /usr/src/linux/.config
>>CONFIG_PM_STD_PARTITION="/dev/hda1"
>>pavel@amd:~$
> 
> 
> cat /proc/cmdline
> root=/dev/hda5 selinux=0 video=vesa:off resume=/dev/hda6 desktop elevator=as console=ttyS0,115200n8 console=tty0
> 
> And CONFIG_PM_STD_PARTITION was not set. I'll retry with it being set
> to "/dev/hda6" and report back.

Setting CONFIG_PM_STD_PARTITION didn't help at all. Still the same
message on suspend-to-disk with current -bk tree.


Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
