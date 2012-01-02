From: Jonathan Nieder <jrnieder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: ACPI I/O resource conflicts with ACPI region SMBI
Date: Mon, 2 Jan 2012 13:11:58 -0600
Message-ID: <20120102191158.GC30183@elie.hsd1.il.comcast.net>
References: <CA+7wUszDweffRXgBQz0Mzv74Bk+OAVcdduAHLi_tB5EwJidoJA@mail.gmail.com>
 <20111216102758.GD5974@elie.hsd1.il.comcast.net>
 <CA+7wUsxRg52yC+wu7uO-YChPEbQ3vaYWG6F7ee=iPx8YX7omWQ@mail.gmail.com>
 <20111222195243.GB18208@xanatos>
 <CA+7wUswZph6iOKVZS5y9S-LPf72ToYPrG6ExXawhqQs_1KM5DQ@mail.gmail.com>
 <20120102181430.GA8562@xanatos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120102181430.GA8562@xanatos>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sarah Sharp <sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Mathieu Malaterre <mathieu.malaterre-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, 644174-61a8vm9lEZVf4u+23C9RwQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wojtek Zabolotny <W.Zabolotny-ZGDBLhmm9VR4rM3dGMyr8Q@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Quick side question:

Sarah Sharp wrote:

> Yeah, don't try to blacklist xhci-hcd.  It's not useful.

How else do you suggest that people figure out whether symptoms are
produced by the xhci-hcd driver or something else?  However, I agree
that it's not useful _any more_, since Mathieu tried that test
already.

[...]
> The log messages seem to indicate that it's either an ACPI or a BIOS
> issue.  I really can't suggest any other tests without some input from
> the ACPI folks.  The best solution I can suggest is not boot with a USB
> device plugged into your USB 3.0 port.

Hm.  Mathieu, is it possible to suspend-to-disk ("echo disk >/sys/power/state")
and resume with a USB device plugged into the USB 3.0 port?

Please also attach output from "acpidump" after a successful boot.

Can you reproduce this when booting in recovery mode with
i915.modeset=0 appended to the kernel command line?

Thanks,
Jonathan
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
