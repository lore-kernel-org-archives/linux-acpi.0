From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: swsusp fails with "FATAL: cannot find swap device, try swapon
 -a!"
Date: Mon, 28 Feb 2005 04:04:29 +0100
Message-ID: <42228A3D.6080907@gmx.net>
References: <42225F85.1000302@gmx.net> <20050228000401.GK1441@elf.ucw.cz> <4222640C.7090706@gmx.net> <42227FE9.1080400@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
In-Reply-To: <42227FE9.1080400-hi6Y0CQ0nG0@public.gmane.org>
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
> Carl-Daniel Hailfinger schrieb:
> 
>>Pavel Machek schrieb:
>>
>>
>>>Hi!
>>>
>>>
>>>
>>>
>>>>since 2.6.10-rcsomething (don't know exact revision), suspend-to-disk
>>>>fails on my machine. dmesg excerpt:
>>>>
>>>>[...]
>>>>Adding 530104k swap on /dev/hda6.  Priority:42 extents:1
>>>>[...]
>>>>PM: suspend-to-disk mode set to 'shutdown'
>>>>Stopping tasks: ===================================================|
>>>>Freeing memory... done (60654 pages freed)
>>>>PM: Attempting to suspend to disk.
>>>>PM: snapshotting memory.
>>>>swsusp: FATAL: cannot find swap device, try swapon -a!
>>>>PCI: Setting latency timer of device 0000:00:1d.0 to 64
>>>>PCI: Setting latency timer of device 0000:00:1d.1 to 64
>>>>PCI: Setting latency timer of device 0000:00:1d.2 to 64
>>>>PCI: cache line size of 32 is not supported by device 0000:00:1d.7
>>>>ehci_hcd 0000:00:1d.7: USB 2.0 restarted, EHCI 1.00, driver 10 Dec 2004
>>>>ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 5 (level, low) -> IRQ 5
>>>>ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 5 (level, low) -> IRQ 5
>>>>PCI: Setting latency timer of device 0000:00:1f.5 to 64
>>>>eth0: link down
>>>>ACPI: PCI interrupt 0000:02:01.2[C] -> GSI 5 (level, low) -> IRQ 5
>>>>eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
>>>>Restarting tasks... done
>>>>[...]
>>>>
>>>>And I have absolutely no idea what's going wrong. Kernel is vanilla
>>>>bk tree from 10 days ago. .config is similar to SUSE .config, but I
>>>>left out some drivers I don't need.
>>>>
>>>>Any idea what could be wrong with my setup?
>>>
>>>
>>>And you have resume= on command line, right? CONFIG_..._STD_PARTITION
>>>should not be required, but I have it set like this:
>>>
>>>pavel@amd:~$ cat /proc/cmdline
>>>root=/dev/hda4 resume=/dev/hda1 psmouse.psmouse_proto=imps psmouse_proto=imps psmouse.proto=imps
>>>pavel@amd:~$ grep hda1 /usr/src/linux/.config
>>>CONFIG_PM_STD_PARTITION="/dev/hda1"
>>>pavel@amd:~$
>>
>>cat /proc/cmdline
>>root=/dev/hda5 selinux=0 video=vesa:off resume=/dev/hda6 desktop elevator=as console=ttyS0,115200n8 console=tty0
>>
>>And CONFIG_PM_STD_PARTITION was not set. I'll retry with it being set
>>to "/dev/hda6" and report back.
> 
> Setting CONFIG_PM_STD_PARTITION didn't help at all. Still the same
> message on suspend-to-disk with current -bk tree.

I added the following debugging code:

--- 1.134/kernel/power/swsusp.c 2005-01-21 05:59:15 +01:00
+++ edited/kernel/power/swsusp.c        2005-02-28 03:43:47 +01:00
@@ -169,6 +169,9 @@ static int is_resume_device(const struct
        struct file *file = swap_info->swap_file;
        struct inode *inode = file->f_dentry->d_inode;

+       if (S_ISBLK(inode->i_mode))
+               printk(KERN_WARNING "is_resume_device: checking %i:%i against resume_device %i:%i\n",
+                       imajor(inode), iminor(inode), MAJOR(resume_device), MINOR(resume_device));
        return S_ISBLK(inode->i_mode) &&
                resume_device == MKDEV(imajor(inode), iminor(inode));
 }
@@ -197,8 +200,10 @@ static int swsusp_swap_check(void) /* Th
                                if (is_resume_device(&swap_info[i])) {
                                        swapfile_used[i] = SWAPFILE_SUSPEND;
                                        root_swap = i;
+                                       printk(KERN_WARNING "swapfile %i SUSPEND\n", i);
                                } else {
                                        swapfile_used[i] = SWAPFILE_IGNORED;
+                                       printk(KERN_WARNING "swapfile %i IGNORED\n", i);
                                }
                        }
                }


and the resulting dmesg was:
Linux version 2.6.11-rc5-latest-s3test18 (compiler@p35) (gcc version 3.3.4 (pre 3.3.5 20040809)) #6 Mon Feb 28 03:44:26
CET 2005
[...]
Kernel command line: root=/dev/hda5 selinux=0 video=vesa:off resume=/dev/hda6 desktop elevator=as console=ttyS0,115200n8
console=tty0
[...]
PM: Reading swsusp image.
swsusp: Resume From Partition: /dev/hda6
swsusp: Error -6 resuming
PM: Resume from disk failed.
[...]
PM: suspend-to-disk mode set to 'shutdown'
Stopping tasks: ======================================|
Freeing memory... done (20435 pages freed)
PM: Attempting to suspend to disk.
PM: snapshotting memory.
is_resume_device: checking 3:6 against resume_device 0:0
swapfile 0 IGNORED
swsusp: FATAL: cannot find swap device, try swapon -a!
[...]

So resume_file has a non-zero length, but resume_device is 0:0.
How can that happen?


Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
