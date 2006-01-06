From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Keyboard not working before loading ohci-hcd (Acer Aspire 1674)
Date: Fri, 6 Jan 2006 17:02:57 -0500
Message-ID: <d120d5000601061402p628aaadfg671cf47ec0ba4671@mail.gmail.com>
References: <200601061847.27590.laurent.pinchart@skynet.be>
Reply-To: dtor_core-yWtbtysYrB+LZ21kGMrzwg@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200601061847.27590.laurent.pinchart-AgBVmzD5pcezQB+pC5nmwQ@public.gmane.org>
Content-Disposition: inline
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-AgBVmzD5pcezQB+pC5nmwQ@public.gmane.org>
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On 1/6/06, Laurent Pinchart <laurent.pinchart-AgBVmzD5pcezQB+pC5nmwQ@public.gmane.org> wrote:
>
> I'm experiencing a weird problem with the internal keyboard of an Acer Aspire
> 1674 (HyperThreading CPU).
>
> When ACPI is enabled, the keyboard doesn't work at all before ohci-hcd is
> loaded. Modifying PCI interrupt routing (pci=noacpi, pci=routeirq) doesn't
> help, but disabling ACPI completely (acpi=off) gives a functional keyboard
> even before loading ohci-hcd.
>

Does it work if you boot with "usb-handoff" on the kernel command line?

--
Dmitry
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
