From: Alberto Piai <albeclemit-whZMOeQn8C0@public.gmane.org>
Subject: Re: Re: S3 resume on Fujitsu-Siemens Amilo A7620 (CONTINUES)
Date: Mon, 18 Oct 2004 22:54:12 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20041018225412.397dcd1f.albeclemit@yahoo.it>
References: <20041018134238.4cf1b380.albeclemit@yahoo.it>
	<20041018124756.GA28463@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20041018124756.GA28463-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: HIROIT-JE5g2YyFxFHQT0dZR+AlfA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, 18 Oct 2004 14:47:56 +0200
Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org> wrote:

> Yes, you are going out of wakeup.S... Actually no. You are going to
> ret_point down in do_suspend_lowlevel.

Update: code is executed until
[...]
ENTRY(do_suspend_lowlevel)
	call	save_processor_state
	call	save_registers
	pushl	$3
	call	acpi_enter_sleep_state
	addl	$4,%esp
	ret
	.p2align 4,,7
ret_point:
	call	restore_registers
	call	restore_processor_state
	# Here it's still alive :)
	ret
[...]

So now it's going out of wakeup.S, right?
We should be in drivers/acpi/sleep/main.c at that point
[...]
switch (pm_state)
	{
	case PM_SUSPEND_STANDBY:
		barrier();
		status = acpi_enter_sleep_state(acpi_state);
		break;

	case PM_SUSPEND_MEM:
		do_suspend_lowlevel();
		break;

	case PM_SUSPEND_DISK:
		if (acpi_pm_ops.pm_disk_mode == PM_DISK_PLATFORM)
			status = acpi_enter_sleep_state(acpi_state);
		else
			do_suspend_lowlevel_s4bios();
		break;
	default:
		return -EINVAL;
	}
	local_irq_restore(flags);
	printk(KERN_DEBUG "Back to C!\n");
[...]
right? 
Can i use some beep code from here as well?
I won't sleep until this laptop resumes! ;)

Alberto


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
