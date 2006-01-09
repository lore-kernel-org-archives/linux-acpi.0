From: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Subject: Re: [gpm] Untangling the sleep hotkey mess
Date: Mon, 9 Jan 2006 03:27:18 +0000
Message-ID: <20060109032717.GA2238@srcf.ucam.org>
References: <3ACA40606221794F80A5670F0AF15F840AA37137@pdsmsx403> <200601091019.01083.luming.yu@intel.com> <20060109023037.GA1316@srcf.ucam.org> <200601091113.16092.luming.yu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200601091113.16092.luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yu Luming <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Richard Hughes <hughsient-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gnome-power-manager-list-rDKQcyrBJuzYtjvyW6yDsg@public.gmane.org, desktop_portables-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Jan 09, 2006 at 11:13:15AM +0800, Yu Luming wrote:

> Comparing with generic hotkey solution, dev_acpi solution cannot prevent any 
> trouble in terms of supportability, and manageability.
> 
> For dev_acpi,  you won't need kernel patch. But you need to know everything in 
> AML world from user space.

We need to know that in any case. The difference is that in the kernel 
case, adding support for new hotkeys requires upgrading the kernel. In 
the case of it adding a new button type that hasn't been seen before, it 
also requires upgrading userspace. If we do it all in userspace, we only 
have one application to fix up in most cases.

> PS.  According to my testing, windows do have platform specific hotkey 
> drivers.

In the Windows world, vendors can provide customised distributions on a 
per-laptop basis. That's not practical in the Linux world.

-- 
Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
