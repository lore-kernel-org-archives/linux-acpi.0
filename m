From: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Subject: Re: Untangling the sleep hotkey mess
Date: Sat, 7 Jan 2006 20:52:32 +0000
Message-ID: <20060107205232.GA6445@srcf.ucam.org>
References: <20060107172446.GA3092@srcf.ucam.org> <20060107192444.GA21915@osgiliath.brixandersen.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20060107192444.GA21915-GgQh6P/XBPa901fzNV2Eubv56P54cF3WWmv/VHan8Is@public.gmane.org>
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sat, Jan 07, 2006 at 08:24:44PM +0100, Henrik Brix Andersen wrote:
> On Sat, Jan 07, 2006 at 05:24:46PM +0000, Matthew Garrett wrote:
> > a) Hal should assume that all hardware has a sleep key, since there's no 
> > way to actually tell.
> 
> Why bring Hal into this equation?

Because, over time, applications are likely to start worrying about what 
hal thinks in this respect. gnome-power-manager already listens for hal 
events related to the sleep button.

> > b) Events generated in cases (1) and (2) should, for now, be caught by 
> > acpid (or something similar) and then fed back into the input layer via 
> > uinput. This should be scancode 142, which will end up as X keycode 223.
> 
> And how would this work for users who doesn't have Hal installed?

I'm sorry, I don't understand the question. This is entirely independent 
of hal.

> Having ACPI hotkey events delivered as normal keyboard input makes it
> difficult to run system scripts as root:root.

But that does nothing to help systems which only expose sleep keys via 
the keyboard controller. It's not practical to get them to generate ACPI 
events - however, it /is/ practical to get ACPI events to generate input 
events. At that point there's nothing to stop a hotkey daemon running as 
root.
-- 
Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
