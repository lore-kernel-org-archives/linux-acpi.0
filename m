From: ole.rohne-vJEk5272eHo@public.gmane.org
Subject: Re: Radeon S3/resume: VGA ROM POST from kernel
Date: 24 Jul 2004 17:26:48 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <yzosmbhpgsn.fsf@localhost.localdomain>
References: <e1c05edd04070109394afd3332@mail.gmail.com>
	<yzoy8lggx6v.fsf_-_@localhost.localdomain>
	<20040724131432.GB3004@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040724131432.GB3004-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, aman-e31a5gnSYeGubukWoKzokaxOck334EZe@public.gmane.org, stefandoesinger-RbZlAiThDcE@public.gmane.org, emmanuel.thome-/zGXu1G9BXs@public.gmane.org, software-v2/BnvaKusE@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Pavel> Agreed, I like this patch.

Cool... Let's see if it's still like that when I've explained how it
works.

Pavel> If you are adding comment with function name, you should at least
Pavel> explain what the function does... or not add the comment at all.

Sure. Ditto for acpi_restore_state from the stock kernel sources that
I started with:-)

Pavel> Please indent using one tab.

Sorry, I must have forgotten to M-x load linux-c-mode

>> (...)
>> +  do_vgapost_lowlevel(acpi_wakeup_address);
>> (...)

Pavel> This needs BUG_ON(num_online_cpus() != 1) to avoid bad
Pavel> disaster, right?

Sounds like a good idea.

>> testl	$1, video_flags - wakeup_code
>> jz	1f
>> +	movw	video_flags - wakeup_code + 2, %ax
>> lcall   $0xc000,$3

Pavel> Are you sure you wanted to touch this code? Zeroing %ax on entry to
Pavel> BIOS might be good idea, but...

It is absolutely necessary, see below for how I've reused the
real->pmode switch. The VGA BIOS expect the PCI bus/slot/function from
%ax and C passes us that information in the upper 16 bits of
acpi_video_flags.

Pavel> Ouch, so you call wakeup_start once again?

Yes, I didn't want to implement yet another real->pmode switch, it
would have been a blue-print copy of wakeup_start and
acpi_copy_wakeup_routine anyway.

Pavel> ...that's certainly interesting design. Does that mean that
Pavel> 'phony return code' is never reached?

It is never reached and should be deleted. It is just a remnant of an
early test stage.

Pavel> How do you manage to return from this routine?

Precisely like do_suspend_lowlevel_s4bios: calling save_registers and
effectively reusing the tail-end of do_suspend_lowlevel.

Ole


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
