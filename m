From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: swsusp: FATAL: cannot find swap device, try swapon -a!
Date: Thu, 24 Mar 2005 01:26:39 +0100
Message-ID: <4242093F.2080203@gmx.net>
References: <Pine.GSO.4.61.0503231901190.15962@z.glue.umd.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
In-Reply-To: <Pine.GSO.4.61.0503231901190.15962@z.glue.umd.edu>
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
> Hi,
> 
> Swsusp comes back with the following error message on my Toshiba m200
> laptop:
> 
> 
> Stopping tasks:
> ==========================================================================|
> Freeing memory... done (35896 pages freed)
> BUG: using smp_processor_id() in preemptible [00000001] code: acpitool/8191
> caller is disable_nonboot_cpus+0x10/0xdb
>  [<c025c6bf>] smp_processor_id+0xa3/0xb4
>  [<c013a2c5>] disable_nonboot_cpus+0x10/0xdb
>  [<c013a2c5>] disable_nonboot_cpus+0x10/0xdb
>  [<c013a4c7>] free_some_memory+0x5e/0x64
>  [<c013a53b>] prepare+0x2f/0xaf
>  [<c013a5c4>] pm_suspend_disk+0x9/0x73
>  [<c0138cac>] enter_state+0x8e/0x92
>  [<c0138dd4>] state_store+0xa4/0xb7
>  [<c0197015>] subsys_attr_store+0x34/0x3d
>  [<c0197299>] flush_write_buffer+0x3e/0x4a
>  [<c01972fd>] sysfs_write_file+0x58/0x80
>  [<c015da98>] vfs_write+0x148/0x14d
>  [<c015db6e>] sys_write+0x51/0x80
>  [<c010319f>] syscall_call+0x7/0xb

That's another bug. It doesn't correspond to your problems.

> Freezing CPUs (at 0)...ok
> eth1: Going into suspend...
> NVRM: RmPowerManagement: 3
> swsusp: FATAL: cannot find swap device, try swapon -a!

That's the real reason for the failure. Do you have IDE built as modules?
Basically, the kernel checks whether it can access the device at boot
time before mounting anything. For 2.6.11.4 this is not possible with
swap devices which depend on any modules loaded. Compile in every driver
needed to access your swap device.

> I use gentoo linux with kernel-2.6.11.4 kernel (not gentoo-kernel!)
> patched with acpi-20050309-2.6.11.diff.gz and boot with
> resume=swap:/dev/hda3 where hda3 is my swap patition. I have searched
> the web and I see that I am not the 1st one getting the same error
> message; the question is if anybody has come up with a remedy to this
> problem.

Yes, see above.

HTH,
Carl-Daniel
-- 
http://www.hailfinger.org/


-------------------------------------------------------
This SF.net email is sponsored by Microsoft Mobile & Embedded DevCon 2005
Attend MEDC 2005 May 9-12 in Vegas. Learn more about the latest Windows
Embedded(r) & Windows Mobile(tm) platforms, applications & content.  Register
by 3/29 & save $300 http://ads.osdn.com/?ad_id=6883&alloc_id=15149&op=click
