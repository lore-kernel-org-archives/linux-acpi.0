From: Alberto Piai <albeclemit-whZMOeQn8C0@public.gmane.org>
Subject: Re: [PATCH] GDT table patch for resume only reboots problem
Date: Sun, 17 Oct 2004 23:02:05 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20041017230205.2e50de4c.albeclemit@yahoo.it>
References: <OFC0526CFC.7FFB98D1-ON49256F30.0068372D-49256F30.006EF530@jp.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <OFC0526CFC.7FFB98D1-ON49256F30.0068372D-49256F30.006EF530-JE5g2YyFxFHQT0dZR+AlfA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Hiroshi 2 Itoh <HIROIT-JE5g2YyFxFHQT0dZR+AlfA@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, pavel-+ZI9xUNit7I@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, 18 Oct 2004 05:17:21 +0900
Hiroshi 2 Itoh <HIROIT-JE5g2YyFxFHQT0dZR+AlfA@public.gmane.org> wrote:

> I hope most of machines can resume with;
> 
> Kernel 2.6.9 RC4
> +wakeup_addr.patch
> +wakeup_gdt.patch

Sorry, it doesn't work on my system :(
It still reboots on
		mov	$(wakeup_stack - wakeup_code), %sp		# Private stack is needed for ASUS board
		movw	$0x0e00 + 'S', %fs:(0x12)

		pushl	$0			#THIS LINE CAUSES REBOOT			# Kill any dangerous flags
		popfl

If I uncomment pushl and popfl it hangs(but not reboot, like going in an infinite loop) later, on
	wakeup_pmode_return:
		movw	$__KERNEL_DS, %ax
		movw	%ax, %ss           #HANGS HERE
		movw	%ax, %ds

Thanks,
Alberto


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
