From: Richard Hughes <hughsient-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [gpm] Untangling the sleep hotkey mess
Date: Mon, 09 Jan 2006 09:44:55 +0000
Message-ID: <1136799895.19776.14.camel@localhost>
References: <20060107172446.GA3092@srcf.ucam.org>
	 <200601090007.43578.dtor_core@ameritech.net>
	 <20060109052407.GA4213@srcf.ucam.org>
	 <200601090109.05791.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200601090109.05791.dtor_core-yWtbtysYrB+LZ21kGMrzwg@public.gmane.org>
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dtor_core-yWtbtysYrB+LZ21kGMrzwg@public.gmane.org>
Cc: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gnome-power-manager-list-rDKQcyrBJuzYtjvyW6yDsg@public.gmane.org, hal-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, desktop_portables-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, 2006-01-09 at 01:09 -0500, Dmitry Torokhov wrote:
> On Monday 09 January 2006 00:24, Matthew Garrett wrote:
> > On Mon, Jan 09, 2006 at 12:07:43AM -0500, Dmitry Torokhov wrote:
> > 
> > > Why don't we create an input handler that would feed certain events
> > > from input layer to acpid via bus_acpi_generate_event().
> > 
> > I'm not convinced that making the input layer depend on ACPI (even 
> > optionally) would go down terribly well. It also strikes me as *wrong* - 
> > the sleep key on this keyboard has nothing to do with ACPI, whereas keys 
> > presented through ACPI are still an input device.
> > 
> 
> The handler is just for compatibility with present installations.
> New installations will use the new interface, whatver it will be.

Like what?

> But input layer will be a hub of sorts and I am arguing for ACPI
> to be converted to use input layer directly.

What does lkml think of ACPI using the input layer directly? 

Richard

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
