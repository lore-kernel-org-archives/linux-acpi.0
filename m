From: Yu Luming <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [gpm] Untangling the sleep hotkey mess
Date: Mon, 9 Jan 2006 11:55:24 +0800
Message-ID: <200601091155.24380.luming.yu@intel.com>
References: <3ACA40606221794F80A5670F0AF15F840AA37137@pdsmsx403> <200601091113.16092.luming.yu@intel.com> <20060109032717.GA2238@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20060109032717.GA2238-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Content-Disposition: inline
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Cc: Richard Hughes <hughsient-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gnome-power-manager-list-rDKQcyrBJuzYtjvyW6yDsg@public.gmane.org, desktop_portables-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Monday 09 January 2006 11:27, Matthew Garrett wrote:
> On Mon, Jan 09, 2006 at 11:13:15AM +0800, Yu Luming wrote:
>  > Comparing with generic hotkey solution, dev_acpi solution cannot p=
revent
>  > any trouble in terms of supportability, and manageability.
>  >
>  > For dev_acpi,=A0 you won't need kernel patch. But you need to know
>  > everything in AML world from user space.
>
>  We need to know that in any case. The difference is that in the kern=
el
>  case, adding support for new hotkeys requires upgrading the kernel. =
In
=46rom practical point of view,  the acpi hotkey won't change for a qui=
te=20
long period. For example, I cannot find too much changes on acpi hotkey=
 from
Thinkpad T21 and Thinkpad T42.  And, I don't see any reason for ODM to=20
change their well-know ACPI device PNP ID and well-know AML methods nam=
es for
acpi hotkey on new platfrom, because they can just implement any platfo=
rm=20
changes in AML code.=20
=20
>  the case of it adding a new button type that hasn't been seen before=
, it
>  also requires upgrading userspace. If we do it all in userspace, we =
only
>  have one application to fix up in most cases.

>
>  > PS.=A0 According to my testing, windows do have platform specific =
hotkey
>  > drivers.
>
>  In the Windows world, vendors can provide customised distributions o=
n a
>  per-laptop basis. That's not practical in the Linux world.
My points is that if hotkey.c become sucessful, then linux won't need t=
hose=20
platform specific hotkey drivers for common hotkeys  such as brightness=
=20
control, volume control, and output switch..=20
Does it make sense?

Thanks,
Luming
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
