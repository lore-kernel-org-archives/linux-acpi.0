From: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Subject: Re: [Desktop_portables] Re: [gpm] Untangling the sleep hotkey mess
Date: Mon, 9 Jan 2006 08:14:39 +0100
Message-ID: <20060109071439.GA31974@hell.org.pl>
References: <3ACA40606221794F80A5670F0AF15F840AA37137@pdsmsx403> <200601091113.16092.luming.yu@intel.com> <20060109032717.GA2238@srcf.ucam.org> <200601091155.24380.luming.yu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200601091155.24380.luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yu Luming <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, desktop_portables-qjLDD68F18O7TbgM5vRIOg@public.gmane.org, Richard Hughes <hughsient-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, gnome-power-manager-list-rDKQcyrBJuzYtjvyW6yDsg@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Thus wrote Yu Luming:
> >From practical point of view,  the acpi hotkey won't change for a quite 
> long period. For example, I cannot find too much changes on acpi hotkey from
> Thinkpad T21 and Thinkpad T42.  And, I don't see any reason for ODM to 
> change their well-know ACPI device PNP ID and well-know AML methods names for
> acpi hotkey on new platfrom, because they can just implement any platform 
> changes in AML code. 

Tell me more...

There's already 3 or 4 major variations of method layout for ASUS laptops
hotkey device, subtle differences like method name changes notwithstanding.
One of the reasons the driver's development lags so much is that the
support code has become such a mess. I really wish their BIOS teams would
settle on one scheme, and there was a point when I thought they'd done just
that, but in the end it just didn't happen.

Personally, I'd love to see all the model support code moved to userspace,
and while I think it might just be possible using the generic driver, I
still didn't manage to make the necessary changes.

So as not to be completely off-topic: users expect (and I'm speaking from
experience here) the buttons to be able to generate both system-wide (as in
suspend) and per-session (as in launch firefox) events and given that, I
think uinput is a good direction, provided we keep acpid or at least a
functional replacement.

Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
