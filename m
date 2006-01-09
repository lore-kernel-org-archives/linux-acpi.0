From: Richard Hughes <hughsient-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [gpm] Untangling the sleep hotkey mess
Date: Mon, 09 Jan 2006 10:04:00 +0000
Message-ID: <1136801040.19776.34.camel@localhost>
References: <3ACA40606221794F80A5670F0AF15F840AA37137@pdsmsx403>
	 <20060109014350.GA672@srcf.ucam.org>
	 <200601091019.01083.luming.yu@intel.com>
	 <20060109023037.GA1316@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20060109023037.GA1316-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Cc: Yu Luming <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gnome-power-manager-list-rDKQcyrBJuzYtjvyW6yDsg@public.gmane.org, desktop_portables-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, 2006-01-09 at 02:30 +0000, Matthew Garrett wrote:
> On Mon, Jan 09, 2006 at 10:19:00AM +0800, Yu Luming wrote:
> 
> > Re: dev_acpi:
> > The key point is AML code shouldn't be exposed in userspace. It is too ugly.
> 
> It may be ugly, but it /works/. We can't predict what vendors will do in 
> terms of providing hotkey support in future, and exposing a limited 
> interface to userspace would probably just result in it having to be 
> extended later on, which again forces us into kernel patching.
> 
> With my Ubuntu hat on:
> 
> dev_acpi would make life a lot easier for us than the current solutions. 
> A single userspace application has the advantage that it can be 
> maintained in a nice cross-distribution way, and we can rapidly fold in 
> extra support based on testing reports.

With my Redhat on*:

I think maybe dev_acpi may work well for the power-user case (if you
know *exactly* what you are doing), but just using the simple acpi
events (like we can do now on some machines) works well. This means that
we can get bug reports from users for obscure machines and keyboards
just from looking at an acpid log. Adding support for different keys can
be done just by adding values to an FDI xml file, or a small addon.
I think trying to pre-process the information in the kernel is a bad
thing to do -- debugging, and getting a user to test a kernel patch is
much harder than a similar userspace patch.

In my ideal world:

* All ACPI keyboard events would come through /proc/acpi/event as hkey's
* You could change the brightness on *any* lcdpanel by doing a simple
  #echo 3 > /proc/acpi/video/brightness
* You could get the number of brightness levels supported doing
  #cat /proc/acpi/video/brightness_levels

Richard.

* I don't work for Redhat, but I do lots of work with Fedora and HAL.

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
