From: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Subject: Re: [gpm] Untangling the sleep hotkey mess
Date: Mon, 9 Jan 2006 02:30:37 +0000
Message-ID: <20060109023037.GA1316@srcf.ucam.org>
References: <3ACA40606221794F80A5670F0AF15F840AA37137@pdsmsx403> <20060109014350.GA672@srcf.ucam.org> <200601091019.01083.luming.yu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200601091019.01083.luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yu Luming <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Richard Hughes <hughsient-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gnome-power-manager-list-rDKQcyrBJuzYtjvyW6yDsg@public.gmane.org, desktop_portables-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Jan 09, 2006 at 10:19:00AM +0800, Yu Luming wrote:

> Re: dev_acpi:
> The key point is AML code shouldn't be exposed in userspace. It is too ugly.

It may be ugly, but it /works/. We can't predict what vendors will do in 
terms of providing hotkey support in future, and exposing a limited 
interface to userspace would probably just result in it having to be 
extended later on, which again forces us into kernel patching.

With my Ubuntu hat on:

dev_acpi would make life a lot easier for us than the current solutions. 
A single userspace application has the advantage that it can be 
maintained in a nice cross-distribution way, and we can rapidly fold in 
extra support based on testing reports.

-- 
Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
