From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: swsusp: FATAL: cannot find swap device, try swapon -a!
Date: Thu, 24 Mar 2005 02:16:47 +0100
Message-ID: <424214FF.3020808@gmx.net>
References: <Pine.GSO.4.61.0503231901190.15962@z.glue.umd.edu> <4242093F.2080203@gmx.net> <Pine.GSO.4.61.0503231942360.5100@y.glue.umd.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
In-Reply-To: <Pine.GSO.4.61.0503231942360.5100@y.glue.umd.edu>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ferenc Szalma <szalmaf-JAjqph6Yjy97jm546uhsrg@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Ferenc Szalma schrieb:
> 
> 
> On Thu, 24 Mar 2005, Carl-Daniel Hailfinger wrote:
> 
>> That's another bug. It doesn't correspond to your problems.
>>
>>> Freezing CPUs (at 0)...ok
>>> eth1: Going into suspend...
>>> NVRM: RmPowerManagement: 3
>>> swsusp: FATAL: cannot find swap device, try swapon -a!
>>
>>
>> That's the real reason for the failure. Do you have IDE built as modules?
>> Basically, the kernel checks whether it can access the device at boot
>> time before mounting anything. For 2.6.11.4 this is not possible with
>> swap devices which depend on any modules loaded. Compile in every driver
>> needed to access your swap device.
>>
> 
> Thanks for the quick reply.
> These are the lines in my kernel config file with "ide" in it (sorry for
> the not appropriate lines). So what should I exactly do?
> 
> mozart linux # more .config|grep -i ide
> # CONFIG_PARIDE is not set
> CONFIG_IDE=y
> CONFIG_BLK_DEV_IDE=y
> # CONFIG_BLK_DEV_IDE_SATA is not set
> # CONFIG_BLK_DEV_HD_IDE is not set
> CONFIG_BLK_DEV_IDEDISK=y
> CONFIG_IDEDISK_MULTI_MODE=y
> CONFIG_BLK_DEV_IDECS=y
> CONFIG_BLK_DEV_IDECD=y
> # CONFIG_BLK_DEV_IDETAPE is not set
> # CONFIG_BLK_DEV_IDEFLOPPY is not set
> # CONFIG_BLK_DEV_IDESCSI is not set
> # CONFIG_IDE_TASK_IOCTL is not set
> # IDE chipset support/bugfixes
> CONFIG_IDE_GENERIC=y
> # CONFIG_BLK_DEV_IDEPNP is not set
> CONFIG_BLK_DEV_IDEPCI=y
> CONFIG_IDEPCI_SHARE_IRQ=y
> CONFIG_BLK_DEV_IDEDMA_PCI=y
> # CONFIG_BLK_DEV_IDEDMA_FORCED is not set
> CONFIG_IDEDMA_PCI_AUTO=y
> # CONFIG_IDEDMA_ONLYDISK is not set
> # CONFIG_IDE_ARM is not set
> # CONFIG_IDE_CHIPSETS is not set
> CONFIG_BLK_DEV_IDEDMA=y
> # CONFIG_IDEDMA_IVB is not set
> CONFIG_IDEDMA_AUTO=y
> # Old CD-ROM drivers (not SCSI, not IDE)
> CONFIG_CD_NO_IDESCSI=y

Very strange. What't your swap device? And please also include
the contents of /proc/cmdline


Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/


-------------------------------------------------------
This SF.net email is sponsored by Microsoft Mobile & Embedded DevCon 2005
Attend MEDC 2005 May 9-12 in Vegas. Learn more about the latest Windows
Embedded(r) & Windows Mobile(tm) platforms, applications & content.  Register
by 3/29 & save $300 http://ads.osdn.com/?ad_id=6883&alloc_id=15149&op=click
