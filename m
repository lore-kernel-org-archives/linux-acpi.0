From: Yu Luming <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [gpm] Untangling the sleep hotkey mess
Date: Mon, 9 Jan 2006 11:13:15 +0800
Message-ID: <200601091113.16092.luming.yu@intel.com>
References: <3ACA40606221794F80A5670F0AF15F840AA37137@pdsmsx403> <200601091019.01083.luming.yu@intel.com> <20060109023037.GA1316@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20060109023037.GA1316-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Content-Disposition: inline
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Cc: Richard Hughes <hughsient-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gnome-power-manager-list-rDKQcyrBJuzYtjvyW6yDsg@public.gmane.org, desktop_portables-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Monday 09 January 2006 10:30, Matthew Garrett wrote:
> On Mon, Jan 09, 2006 at 10:19:00AM +0800, Yu Luming wrote:
>  > Re: dev_acpi:
>  > The key point is AML code shouldn't be exposed in userspace. It is too
>  > ugly.
>
>  It may be ugly, but it /works/. We can't predict what vendors will do in
>  terms of providing hotkey support in future, and exposing a limited
>  interface to userspace would probably just result in it having to be
>  extended later on, which again forces us into kernel patching.
They should come up with some kinds of specs for hotkey in the future.
Otherwise, the problem won't go away.

>
>  With my Ubuntu hat on:
>
>  dev_acpi would make life a lot easier for us than the current solutions.
>  A single userspace application has the advantage that it can be
>  maintained in a nice cross-distribution way, and we can rapidly fold in
>  extra support based on testing reports.
Comparing with generic hotkey solution, dev_acpi solution cannot prevent any 
trouble in terms of supportability, and manageability.

For dev_acpi,  you won't need kernel patch. But you need to know everything in 
AML world from user space.

For hotkey.c, there is an auto-load-call-back function that will automatically 
detect and install configure data based on well-known acpi device object's 
PNP ID, and well-known hotkey AML method names.
And the manual configure interface is intended to be used as debug tool.

So, if you use hotkey.c you don't need to know anything in AML world from user 
space, if you are lucky. I expect in the future, the well-know acpi device 
PNP ID, and well-know AML methods names would become part of ACPI spec.

PS.  According to my testing, windows do have platform specific hotkey 
drivers.

>
>  --
>  Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org

-- 
Thanks,
Luming
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
