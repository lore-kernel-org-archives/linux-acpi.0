From: Alberto Piai <albeclemit-whZMOeQn8C0@public.gmane.org>
Subject: Re: ACPI S3 resume only reboots
Date: Sun, 17 Oct 2004 23:12:58 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20041017231258.1ec99146.albeclemit@yahoo.it>
References: <88056F38E9E48644A0F562A38C64FB60031D9885@scsmsx403.amr.corp.intel.com>
	<20041015214126.19df9b3c.albeclemit@yahoo.it>
	<20041017194809.GD7476@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20041017194809.GD7476-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sun, 17 Oct 2004 21:48:09 +0200
Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org> wrote:

> Hi!

> You commented out pushl / popfl, right? That looks like workaround. We
> need some stack. Can you try commenting this instead
> 
>         movw    %ax, %ss
>         mov     $(wakeup_stack - wakeup_code), %sp              # Private stack is needed for ASUS board
> 
> ? Maybe bios left us with some usefull stack. (Not all biosen do, but
> you might be lucky).

No, doesn't seem to be my situation... reboot still occurs. 
 
> Ouch and also try what happens if you do 
> 
> 	pushl %eax
> 	popl %eax
> 
> before
> 
> 	pushl $0
> 	popfl

i added 
	pushl %eax
	popl %eax
	hole: jmp hole
and it doesn't fall in the loop, but reboots.

Alberto


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
