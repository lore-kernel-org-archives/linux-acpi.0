From: Petr Olivka <petr.olivka-jmYXjVuSQ4U@public.gmane.org>
Subject: Re: D600: S1 and S3 resume
Date: Fri, 5 Dec 2003 11:05:13 +0100 (CET)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.58.0312051054030.2457@pcd403z.vsb.cz>
References: <Pine.LNX.4.30.0311251150140.19330-100000@pcd403z.vsb.cz>
 <20031203181826.GA28870@tate.loria.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20031203181826.GA28870-xkTd+U360DcAs8EywTwl9A@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Emmanuel =?iso-8859-1?Q?Thom=E9?= <Emmanuel.Thome-/zGXu1G9BXs@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


I did test this patch yesterday, and I have still the same behaviour.
After resume from S1 notebook hang. To not hang I everytime stop usbmbr
and remove all usb modules, but uhci-hcd fail when unloading:

uhci_hcd 0000:00:1d.0: remove, state 1
usb usb1: USB disconnect, address 1
uhci_hcd 0000:00:1d.0: USB bus 1 deregistered
uhci_hcd 0000:00:1d.1: remove, state 1
usb usb2: USB disconnect, address 1
uhci_hcd 0000:00:1d.1: USB bus 2 deregistered
uhci_hcd 0000:00:1d.2: remove, state 1
usb usb3: USB disconnect, address 1
usb 3-2: USB disconnect, address 2
pci_pool_destroy 0000:00:1d.2/uhci_td, def25000 busy
uhci_hcd 0000:00:1d.2: USB bus 3 deregistered
slab error in kmem_cache_destroy(): cache `uhci_urb_priv': Can't free all
objects
Call Trace:
 [<c013866d>] __slab_error+0x21/0x28
 [<c0138fe4>] kmem_cache_destroy+0x8c/0x114
 [<e28e86d0>] uhci_hcd_cleanup+0x18/0x50 [uhci_hcd]
 [<c012e54f>] sys_delete_module+0x17b/0x19c
 [<c0141510>] sys_munmap+0x44/0x64
 [<c0108faf>] syscall_call+0x7/0xb

uhci: not all urb_priv's were freed

I will forward this problem to usb-devel.

thanks
  poli


On Wed, 3 Dec 2003, Emmanuel [iso-8859-1] Thom=E9 wrote:

>
> Regarding your usb problem, you might try the silly patch attached.
> First make sure in any case that you shut down the usb subsystem before
> suspending ! The patch does nothing intelligent, but it helps. On _my_
> dell d600, running 2.6.0-test11, this prevents the uhci controllers #2
> and #3 from waking up, as they are bogus on wakeup (and put unnecessary
> pressure on syslog). Having only one uhci controller active means that
> only the bottom usb plug is functional on S3 resume.
>
> Patch applies to 2.6.0-test9, test10, test11 afaik.
>
> Now note that there seems to be power management patches floating around
> in linux-usb-devel. You might want to try some of them. There has to be
> a proper way of resuming these usb controllers.
>
> If you have some sort of better success with usb, do tell me. I'm
> currently trying to make something decent out of the proprietary
> winmodem driver from linuxant (not sure I'll be succesful: it's such a
> messy crap...). Currently, the winmodem causes a lot of instability with
> S3.
>
> Regards,
>
> E.
>
> On Tue, Nov 25, 2003 at 01:27:01PM +0100, Petr Olivka wrote:
> > Hi !
> >
> >   I have more question and informations about D600 with linux:
> >
> >   I tested the patch for xfree radeon_driver.c, and now video wake up
> > after resume from S3.  But system is terrible slow. CPU is half second
> > working and half second is stopped. I have kernel 2.6-test10, bios A05.
> >
> >
> >   I have problem with resume from S1 and S3, when
> > uhci-hcd and sound card is loaded. When D600 resume from S1, display "b=
ack
> > to C!", "set pci latency 00:1d.0, 00:1d.1 and 00:1d.2 to 64" and hang.
> > When resume from S3 I have black LCD and do not see anything.
> > (I have to say, that 00:1d.0-1-2-7 are usb devices on pci.)
> >
> >
> >   What kernel is at this moment the best choice for D600? 2.4 or 2.6? W=
hat
> > you are using and your experiences with suspend?
> >
> >
> >   And back to patch for X. I debug the code and ax, bx, cx, dx items in
> > Int10 struct are zero. The "->num-0xe6" is little mystery for me.
> >
> >   I did try call Int 10h using "lrmi" - linux real mode interface, but
> > it failed (SIGSEGV), when try outw to some port.
> >
> >
> > And last information: when I suspend to S3 in "Dock", after resume is
> > display ok, even I remove the notebook from dock before wakeup. But CPU=
 is
> > slow.
> >
> >
> > I did ask dell about more technical informations about D600, but they
> > did say me, that all technical delatils are marked internally
> > "confidential" and nobody can share them. I hope Dell will change your
> > restriction and improve support for linux.
> >
> > poli
>



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
