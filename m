From: Alberto Piai <albeclemit-whZMOeQn8C0@public.gmane.org>
Subject: S3 resume on Fujitsu-Siemens Amilo A7620 (CONTINUES)
Date: Mon, 18 Oct 2004 13:42:38 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20041018134238.4cf1b380.albeclemit@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: pavel-+ZI9xUNit7I@public.gmane.org
Cc: HIROIT-JE5g2YyFxFHQT0dZR+AlfA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Please refer to threads "ACPI S3 resume only reboots" and "[PATCH] GDT table patch for resume only reboots problem" for history on this thread. I moved to a new one because was becoming hard to follow.

Properly using beeping code by Pavel I was able to follow the code after
	wakeup_pmode_return:
		movw	$__KERNEL_DS, %ax
		movw	%ax, %ss
and verified that it doesn't hang at that point.

Wakeup works until:
[...]
# and restore the stack ... but you need gdt for this to work
	movl	saved_context_esp, %esp

	movl	%cs:saved_magic, %eax
	cmpl	$0x12345678, %eax
	jne	bogus_magic

	# jump to place where we left off
	movl	saved_eip,%eax
	jmp	*%eax		###BEFORE THE JMP IT'S STILL ALIVE!
[...]

If i let it enter the jmp, it hangs. How can i follow that jump? Does that mean that we're going out of wakeup.S, finally? That would be a progress.

Current situation is:
with wakeup_addr.patch, wakeup_gdt.patch and 
	movl  %cr0, %eax
	andl  $0xfffffff0, %eax # TS/EM/MP bit off	
	movl  %eax, %cr0
placed at the beginning of wakeup code as suggest by Hiroshi 2 Itoh
the laptop still doesn't survive pushl $0, that causes reboot.
Commenting out pushl $0 and popfl it goes on until the point reported above.

Thanks,
Alberto










-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
