From: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Subject: Re: Re: 2.6.10-rc1-mm3: ACPI problem due to un-exported hotplug_path
Date: Tue, 9 Nov 2004 16:08:11 -0800
Message-ID: <20041110000811.GA8543@kroah.com>
References: <20041105001328.3ba97e08.akpm@osdl.org> <20041105164523.GC1295@stusta.de> <20041105180513.GA32007@kroah.com> <20041105201012.GA24063@vrfy.org> <20041105204209.GA1204@kroah.com> <20041105211848.A21098@unix-os.sc.intel.com> <20041109225502.GC7618@kroah.com> <d120d5000411091548584bf8c5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <d120d5000411091548584bf8c5-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: dtor_core-yWtbtysYrB+LZ21kGMrzwg@public.gmane.org
Cc: Keshavamurthy Anil S <anil.s.keshavamurthy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Kay Sievers <kay.sievers-tD+1rO4QERM@public.gmane.org>, tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org, motoyuki-tPnzhWqfZ96MLkP6nYsO9A@public.gmane.org, Adrian Bunk <bunk-HeJ8Db2Gnd6zQB+pC5nmwQ@public.gmane.org>, Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, rml-Et1tbQHTxzrQT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Nov 09, 2004 at 06:48:17PM -0500, Dmitry Torokhov wrote:
> On Tue, 9 Nov 2004 14:55:02 -0800, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org> wrote:
> > On Fri, Nov 05, 2004 at 09:18:48PM -0800, Keshavamurthy Anil S wrote:
> > > Also, since you have brought this, I have one another question to you.
> > > Now in the new kernel, I see whenever anybody calls sysdev_register(kobj),
> > > an "ADD" notification is sent. why is this? I would like to call
> > > kobject_hotplug(kobj, ADD) later.
> > 
> > This happens when kobject_add() is called.  You shouldn't ever need to
> > call kobject_hotplug() for an add event yourself.
> > 
> 
> This is not always the case. One might want to postpone ADD event
> until all summpelental object attributes are created. This way userspace
> is presented with object in consistent state.

No, that's a mess.  Let userspace wait for those attributes to show up
if they need to.  That's what the "wait_for_sysfs" program bundled with
udev is for.

thanks,

greg k-h


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
