From: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC PATCH] usb/acpi: Add support usb port power off mechanism
 for device fixed on the motherboard
Date: Thu, 17 May 2012 15:42:52 +0400
Message-ID: <4FB4E43C.60507@mvista.com>
References: <4FB348AB.5050308@intel.com> <Pine.LNX.4.44L0.1205161033340.1852-100000@iolanthe.rowland.org> <20120516143958.GA612@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120516143958.GA612-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Sarah Sharp <sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Dan Williams <dcbw-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello.

On 16-05-2012 18:39, Greg KH wrote:

>>> Ok. Let me reconfirm the meaning of these opinions.

>>> "auto"
>>> 	if port without device, turn off power directly.
>>> 	if port with device, turn off power when the device is suspended.

>>> "on"	the port's power must be on.

>>> "off"	the port's power must be off.

>>> Right?

>> Maybe the "auto" setting should be renamed "active".  Then "auto" can
>> be used for:

>> 	If the port has a device, turn the power on.
>> 	If the port doesn't have a device, turn the power off.

> And plugging a new device into a port that was powered off is going to
> cause the power to come back on, right?

    How plugging a device can be detected on unpowered port?

WBR, Sergei
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
