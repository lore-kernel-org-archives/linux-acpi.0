From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: Re: [RFC] dev_acpi: support for userspace access to acpi
Date: Wed, 27 Oct 2004 17:31:39 -0600
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200410271731.39077.bjorn.helgaas@hp.com>
References: <3ACA40606221794F80A5670F0AF15F84041ABFF8@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="gb2312"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F84041ABFF8@pdsmsx403>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Alex Williamson <alex.williamson-VXdhtT5mjnY@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wednesday 27 October 2004 11:17 am, Yu, Luming wrote:
>   If don't use acpi_early_init , acpi is initialized in do_basic_setup() in kernel thread --init.
> It is very close to launch first user space process(/sbin/init ..). So, if we can invent 
> acpi_later_init, it is possible to move interpreter out of kernel.

It's true that some early init stuff is based on the static tables
and doesn't require the interpreter.  But there is a lot of stuff
that DOES require the interpreter, like finding PCI root bridges,
PRTs, PCI interrupt link devices, etc.  It's not clear to me that
it's feasible to deal with all these from userspace.

>   The difficulty for inventing userspace interpreter is to eliminate the ACPI-interpreter dependency 
> of drivers for booting. But this dependency is not mandatory. Once kernel booted to be able
> to launch /sbin/init, it is also able to launch /sbin/user_space_interpreter, then kernel can enjoy
> acpi from then on, despite the acpi interpreter is a user space daemon, we just need to invent
> or user a communication method between kernel and user space daemon.

Before the interpreter, you don't have ANY devices (legacy ones are
described via the namespace of course, and PCI devices depend on root
bridges that are also in the namespace).  So you end up at least
requiring a ramdisk, plus a bunch of encoding to communicate resource
information from the interpreter to the drivers.

Maybe not impossible, but it certainly requires a lot of work.  Moving
the interpreter to userspace has been proposed many times, but I've
never seen any indication that anybody is actually working on it.


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
