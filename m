From: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Subject: Re: [gpm] Untangling the sleep hotkey mess
Date: Mon, 9 Jan 2006 04:07:51 +0000
Message-ID: <20060109040751.GA2880@srcf.ucam.org>
References: <3ACA40606221794F80A5670F0AF15F840AA37137@pdsmsx403> <200601091113.16092.luming.yu@intel.com> <20060109032717.GA2238@srcf.ucam.org> <200601091155.24380.luming.yu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200601091155.24380.luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yu Luming <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Richard Hughes <hughsient-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gnome-power-manager-list-rDKQcyrBJuzYtjvyW6yDsg@public.gmane.org, desktop_portables-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Jan 09, 2006 at 11:55:24AM +0800, Yu Luming wrote:

> From practical point of view,  the acpi hotkey won't change for a quite 
> long period. For example, I cannot find too much changes on acpi hotkey from
> Thinkpad T21 and Thinkpad T42.  And, I don't see any reason for ODM to 
> change their well-know ACPI device PNP ID and well-know AML methods names for
> acpi hotkey on new platfrom, because they can just implement any platform 
> changes in AML code. 

Toshiba have entirely changed their ACPI hotkey setup with the new Tecra 
range. The BIOS bears almost no resemblance to the previous one. Sony 
have changed their brightness handling code in newer machines - it seems 
to be impossible to change it through ACPI now.

Rule 1 of laptops: Vendors will do unpredictable and hard to understand 
things. They don't consider what they're providing to be well-known. As 
far as vendors are concerned, it's an internal implementation detail and 
they'll change it whenever they feel like it.

If Intel would like a single driver able to support all future laptops, 
then Intel need to specify hotkey behaviour in the ACPI spec and refuse 
to allow people to claim ACPI compliance unless they implement it. Until 
that happens there's no way of claiming that this stuff will just carry 
on working.

> >  In the Windows world, vendors can provide customised distributions on a
> >  per-laptop basis. That's not practical in the Linux world.
> My points is that if hotkey.c become sucessful, then linux won't need those 
> platform specific hotkey drivers for common hotkeys  such as brightness 
> control, volume control, and output switch.. 

It *will*, it's just they'll all be in a single driver that special 
cases a bunch of manufacturers. The fact that all of this is in one file 
rather than 20 doesn't make it inherently better.
-- 
Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
