From: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Subject: Re: Untangling the sleep hotkey mess
Date: Sat, 7 Jan 2006 21:14:50 +0000
Message-ID: <20060107211449.GA6998@srcf.ucam.org>
References: <20060107172446.GA3092@srcf.ucam.org> <20060107192444.GA21915@osgiliath.brixandersen.dk> <20060107205232.GA6445@srcf.ucam.org> <20060107210103.GA5961@osgiliath.brixandersen.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20060107210103.GA5961-GgQh6P/XBPa901fzNV2Eubv56P54cF3WWmv/VHan8Is@public.gmane.org>
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sat, Jan 07, 2006 at 10:01:03PM +0100, Henrik Brix Andersen wrote:

> So what you really propose is to abstract the handling of ACPI events
> by yet another layer, a hotkey daemon?

No, what I propose is that sleep keys end up generating the same 
userspace event no matter how they're connected. The easiest way to 
achieve that (that is, the one which requires the least amount of new 
code to be written) would be to do it through the input layer. If you 
then want to respond to events by running something as root, this would 
require a small daemon that monitors input events.

The current situation (where sleep keys may generate three different 
types of events) is getting somewhat untenable.
-- 
Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
