From: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Subject: Re: [gpm] Untangling the sleep hotkey mess
Date: Mon, 9 Jan 2006 01:43:51 +0000
Message-ID: <20060109014350.GA672@srcf.ucam.org>
References: <3ACA40606221794F80A5670F0AF15F840AA37137@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3ACA40606221794F80A5670F0AF15F840AA37137@pdsmsx403>
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Richard Hughes <hughsient-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gnome-power-manager-list-rDKQcyrBJuzYtjvyW6yDsg@public.gmane.org, desktop_portables-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Jan 09, 2006 at 09:37:01AM +0800, Yu, Luming wrote:

> The hotkey.c is NOT like what you said above.
> It is used to support dedicated hotkey device and dedicated hotkey AML methods
> that are used by ODM to implement hotkey function on their own laptops.
> As for hotkey event, hotkey.c doesn't handle it yet.  
> And so-called event_num in hotkey.c are mainly used as a key for searching and storing.

Can we please stop all this madness of trying to support twenty thousand 
weird and wonderful laptop configurations in the kernel, merge dev_acpi 
instead and then do it all in userspace? It strikes me as massively more 
maintainable. That way we don't need vendors to patch kernels every time 
a manufacturer tweaks something - a small userspace update can be pushed 
out instead.

-- 
Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
