From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: Toshiba Satellite P10
Date: Sat, 24 Dec 2005 13:49:03 +0100
Message-ID: <20051224124903.GH26351@elf.ucw.cz>
References: <20051223230133.GC16104@elf.ucw.cz> <43AC9127.10007@kroon.co.za> <20051224002527.GA16285@elf.ucw.cz> <43AC97E7.1030800@kroon.co.za> <20051224003808.GB16285@elf.ucw.cz> <43AD0AC6.9060904@kroon.co.za> <43AD2676.10703@roarinelk.homelinux.net> <43AD2F3F.7010003@kroon.co.za> <20051224114758.GD26351@elf.ucw.cz> <43AD407A.5020708@kroon.co.za>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <43AD407A.5020708-P18QfuJFXGPYkQIYctQFYw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jaco Kroon <jaco-P18QfuJFXGPYkQIYctQFYw@public.gmane.org>
Cc: Manuel Lauss <mano-nEyxjcs6f3Vin2gBucwGBecsttgLyre6@public.gmane.org>, Stefan Seyfried <seife-l3A5Bk7waGM@public.gmane.org>, Holger Macht <hmacht-l3A5Bk7waGM@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> I presume you're looking for ide0 and ide1 interrupts, yes, after
> suspending to ram twice the command showed that interrupt 14 (ide0)
> increased from 994 to 1011 and for 15 (ide1) it stayed at 24.  My hdd is
> on hda so that'll be on ide0, dvd-rw is on hdc or ide1.
> 
> The interrupt counts for cascade (irq 2), rtc (irq 8) and acpi (irq 9)
> stayed constant though, at 0, 2 and 4 respectively.
> 
> No NMI or ERR conditions were ever signaled.
> 
> Now, with APIC, but no IO-APIC there is a bug notice during resume.
> Going to type it over (from dmesg):
> 
> Back to C!
> Debug: sleeping function called from invalid context at mm/slab.c:2472
> in_atomic():0, irqs_disabled():1
>  __might_sleep+0x9e/0xa6
>  acpi_os_allocate+0x15/0x26
>  kmem_cache_alloc+0x95/0xad
>  acpi_ut_callocate+0x37/0x79

I know, it is scary, but it is also known and harmless. You can ignore
this one.

> ACPI: PCI Interrupt 0000:00:14.1[A] -> Link [LNK0] -> GSI 11 (level,
> low) -> IRQ 11
> ACPI: PCI Interrupt 0000:02:04.0[A] -> Link [LNK0] -> GSI 11 (level,
> low) -> IRQ 11
> Restarting tasks... done
> 
> Both cases looks identical.  /proc/interrupts doesn't list 11 as an
> interrupt ?!?

Talk to acpi people about that.

> Also, this time round the auto-repeat on the keys is working again after
> resume.  In fact, everything seems to be working.  Just that debug
> stacktrace that bothers me.  Oh, and my console blanking time also seems
> to get lost but I can fix that with the help of echo and /dev/tty*.

Good.

> Anyhow, suspended twice to ram now in succession, make cleaned and
> rebuilt the kernel, installed it, and the only thing that even suggests
> there is a glitch is that trace.
> 
> Looks like I need APIC on and IO-APIC off.  Any explanations very
> welcome:  and don't tell me the IO-APIC is buggy - I've been running
> with both those options on for as long as I've had this notebook now.

I do not know enough explanations, feel free to investigate.

Anyway so both suspend-to-ram and suspend-to-disk now works for you,
right? No need to press keys to make it write image on disk?

Oh and thanks for video.txt diff, applied.
								Pavel
-- 
Thanks, Sharp!


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
