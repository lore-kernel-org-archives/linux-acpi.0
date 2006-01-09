From: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Subject: Re: [gpm] Untangling the sleep hotkey mess
Date: Mon, 9 Jan 2006 22:04:05 +0000
Message-ID: <20060109220404.GA20463@srcf.ucam.org>
References: <3ACA40606221794F80A5670F0AF15F840AA37137@pdsmsx403> <20060109014350.GA672@srcf.ucam.org> <200601091019.01083.luming.yu@intel.com> <20060109023037.GA1316@srcf.ucam.org> <1136801040.19776.34.camel@localhost> <d120d5000601091314g7cef73fk445976b14c549a04@mail.gmail.com> <20060109214050.GA19974@srcf.ucam.org> <d120d5000601091352m19ba5eb0n80c462cba49bd2a6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <d120d5000601091352m19ba5eb0n80c462cba49bd2a6-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dtor_core-yWtbtysYrB+LZ21kGMrzwg@public.gmane.org
Cc: Richard Hughes <hughsient-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Yu Luming <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gnome-power-manager-list-rDKQcyrBJuzYtjvyW6yDsg@public.gmane.org, desktop_portables-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Jan 09, 2006 at 04:52:11PM -0500, Dmitry Torokhov wrote:

> I probably was not clear in my original message. The new input handler
> for ACPI would be only used for compatibility with cirrent
> installations relying on ACPID. This will allow gradual conversion of
> ACPI drivers to use input layer instead of sending events dircetly to
> /proc/acpi/events.

Ah, I see what you mean. However, there's still some slight awkwardness 
here, since userspace will be expecting the events to come from the 
button driver (the regexp used is generally button[ /]sleep), and 
that'll be registered even if there's no sleep button (the lid switch 
and power button are still handled via it). I don't believe you can 
register two drivers with the same name, so without gross hacks I can't 
see an easy way to provide this functionality through /proc/acpi without 
requiring userspace to be fixed up /anyway/...

> OTOH there should probably be anotehr generic power interface
> filtering out power-related input events from the stream of all input
> events in the system and making them available to userspace without
> requiring applications (be it individual applications or HAL) to open
> zillion of raw /dev/input/evenX devices.

Sure. As mentioned before, we basically just want keycodes 116, 142 and 
205 (POWER, SLEEP and SUSPEND) - I guess that's not too difficult?
-- 
Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
