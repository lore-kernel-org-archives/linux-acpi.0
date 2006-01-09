From: Richard Hughes <hughsient-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [Desktop_portables] Re: [gpm] Untangling the sleep hotkey mess
Date: Mon, 09 Jan 2006 09:48:06 +0000
Message-ID: <1136800086.19776.18.camel@localhost>
References: <3ACA40606221794F80A5670F0AF15F840AA37137@pdsmsx403>
	 <200601091155.24380.luming.yu@intel.com>
	 <20060109071439.GA31974@hell.org.pl>
	 <200601091547.43439.luming.yu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200601091547.43439.luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yu Luming <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>, Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, desktop_portables-qjLDD68F18O7TbgM5vRIOg@public.gmane.org, gnome-power-manager-list-rDKQcyrBJuzYtjvyW6yDsg@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, 2006-01-09 at 15:47 +0800, Yu Luming wrote:
> On Monday 09 January 2006 15:14, Karol Kozimor wrote:
> > Thus wrote Yu Luming:
> >  > >From practical point of view,  the acpi hotkey won't change for a quite
> >  >
> >  > long period. For example, I cannot find too much changes on acpi hotkey
> >  > from Thinkpad T21 and Thinkpad T42.  And, I don't see any reason for ODM
> >  > to change their well-know ACPI device PNP ID and well-know AML methods
> >  > names for acpi hotkey on new platfrom, because they can just implement
> >  > any platform changes in AML code.
> >
> >  Tell me more...
> 
> I just want to say the hot-keys on keyboard for brightness, sound
> volume, display output switching won't change too much, 
> because user needs these buttons. And almost all laptops implement them.
> 
> For each ODM, if they implement hot-keys with dedicated ACPI devices and
> dedicated AML methods. It doesn't make any sense to change
> the name on new platforms for supporting same hot-keys.
> >
> >  There's already 3 or 4 major variations of method layout for ASUS laptops
> >  hotkey device, subtle differences like method name changes
> > notwithstanding. One of the reasons the driver's development lags so much
> > is that the support code has become such a mess. I really wish their BIOS
> > teams would settle on one scheme, and there was a point when I thought
> > they'd done just that, but in the end it just didn't happen.
> >
> We need a hotkey spec for those well-know hot-keys now,
> Then, we can look forward to a clean hotkey driver in the future.

What spec would that be? Surely we *just* need a way to get the hotkeys
to userspace as early as possible? Be they KEY_BRIGHTNESSDOWN or some
random value like 0x140.
Why make this complicated, or am I missing a trick?

Thanks, Richard.

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
