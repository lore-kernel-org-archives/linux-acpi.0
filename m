From: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Subject: Re: [gpm] Untangling the sleep hotkey mess
Date: Mon, 9 Jan 2006 05:24:07 +0000
Message-ID: <20060109052407.GA4213__47602.0234440968$1136784405$gmane$org@srcf.ucam.org>
References: <20060107172446.GA3092@srcf.ucam.org> <1136729632.2444.36.camel@localhost> <1136769294.3059.12.camel@localhost> <200601090007.43578.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200601090007.43578.dtor_core-yWtbtysYrB+LZ21kGMrzwg@public.gmane.org>
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dtor_core-yWtbtysYrB+LZ21kGMrzwg@public.gmane.org>
Cc: Richard Hughes <hughsient-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gnome-power-manager-list-rDKQcyrBJuzYtjvyW6yDsg@public.gmane.org, hal-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, desktop_portables-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Jan 09, 2006 at 12:07:43AM -0500, Dmitry Torokhov wrote:

> Why don't we create an input handler that would feed certain events
> from input layer to acpid via bus_acpi_generate_event().

I'm not convinced that making the input layer depend on ACPI (even 
optionally) would go down terribly well. It also strikes me as *wrong* - 
the sleep key on this keyboard has nothing to do with ACPI, whereas keys 
presented through ACPI are still an input device.

-- 
Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
