From: Paulo Marques <pmarques-TSnNRl9vlf1Wk0Htik3J/w@public.gmane.org>
Subject: Re: [RFC] Reliable video POSTing on resume
Date: Mon, 07 Feb 2005 15:39:03 +0000
Message-ID: <42078B97.6030300@grupopie.com>
References: <e796392205020221387d4d8562@mail.gmail.com>  <420217DB.709@gmx.net> <4202A972.1070003@gmx.net>  <20050203225410.GB1110@elf.ucw.cz>  <1107474198.5727.9.camel@desktop.cunninghams> <4202DF7B.2000506@gmx.net>  <1107485504.5727.35.camel@desktop.cunninghams>  <9e4733910502032318460f2c0c@mail.gmail.com>  <20050204074454.GB1086@elf.ucw.cz>  <9e473391050204093837bc50d3@mail.gmail.com>  <20050205093550.GC1158@elf.ucw.cz> <1107695583.14847.167.camel@localhost.localdomain> <Pine.BSF.4.62.0502062107000.26868@www.missl.cs.umd.edu> <42077AC4.5030103@grupopie.com> <42077CFD.7030607@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
In-Reply-To: <42077CFD.7030607-hi6Y0CQ0nG0@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>
Cc: Adam Sulmicki <adam-VEv2qz67h9X2fBVCVOL8/A@public.gmane.org>, Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, ncunningham-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org, ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Li-Ta Lo <ollie-YOWKrPYUwWM@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Carl-Daniel Hailfinger wrote:
> Paulo Marques schrieb:
>[...]
>>It seems to me that x86 emulation in the kernel is the way to go because:
>>
>>[...]
>>
>>3 - it's always there and can be executed at *any* time: booting,
>>returning from suspend, etc. Also it would allow the VESA framebuffer
>>driver to change graphics mode at any time (for instance).
> 
> 
> OK, and what would force you to do the above in the kernel? If the code
> lives in initramfs, it can be called very early, too.

Not as early, anyway, and it would make the setup for the initramfs (at 
boot) and the resume much more complex.

The line line between what should go in the kernel and what should live 
in user space as always been a fuzzy one, and it's been moving in a 
dangerous direction lately, IMHO.

In my opinion there are 3 major factors for something to go into the kernel:

1 - resource management between user space processes (this includes 
locking, etc.)

2 - performance

3 - hardware abstraction

This latest point is being more and more ignored by kernel developers.

In a previous thread about using the frame buffer accelerated operations 
from user space, Jammes Simmons wrote:

"You can mmap the mmio address space and program the registers yourself."

and just 3 minutes later, Geert Uytterhoeven wrote too:

"mmap() the MMIO registers to userspace, and program the acceleration 
engine from userspace, like DirectFB (and XF*_FBDev 3.x for Matrox and 
Mach64) does."

This is a even more horrid example, because the drivers in the kernel 
already have the code to do the accelerated functions, and we just don't 
have the interface for them to be called from user space.

It is another example of "this can be done from user space, so why put 
it in the kernel". To have a consistent interface for similar operations 
without having to know the underlying hardware, perhaps?

At least Helge Hafting wrote on the same thread:

"I believe you also can write a small driver that connects to the
framebuffer the same way the fbconsole does.  It could then
export all the operations so userspace actually can call them."

Which seemed a much better solution to me.

> And how many competing implementations of video helpers/emulation code
> do we have now?
> 
> - scitechsoft emu
> - linuxbios emu

I think these two are the same (or at least that is what Li-Ta Lo is 
working on)

> - etc. (I surely forgot some)

This one I've never heard of :)

Anyway, as it happens with anything in the kernel, several different 
solutions for the same problem get selected by "natural" selection, and 
evolve "genetically" into the final version.

-- 
Paulo Marques - www.grupopie.com

All that is necessary for the triumph of evil is that good men do nothing.
Edmund Burke (1729 - 1797)


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
