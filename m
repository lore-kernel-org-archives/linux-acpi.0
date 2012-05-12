From: Lan Tianyu <tianyu.lan@intel.com>
Subject: Re: [RFC PATCH] usb/acpi: Add support usb port power off mechanism
 for device fixed on the motherboard
Date: Sun, 13 May 2012 01:47:39 +0800
Message-ID: <4FAEA23B.1010009@intel.com>
References: <Pine.LNX.4.44L0.1205111605560.1865-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:10126 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751691Ab2ELRrm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 12 May 2012 13:47:42 -0400
In-Reply-To: <Pine.LNX.4.44L0.1205111605560.1865-100000@iolanthe.rowland.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Sarah Sharp <sarah.a.sharp@linux.intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>

On 2012/5/12 4:20, Alan Stern wrote:
> On Fri, 11 May 2012, Lan, Tianyu wrote:
>
>> On 2012/5/12 1:44, Alan Stern wrote:
>>> On Sat, 12 May 2012, Lan Tianyu wrote:
>>>>    From my opinion, ACPI will tell us whether the port is connectable or not.
>>> ACPI will tell you about some ports, not others (for example, ACPI
>>> knows nothing about the ports on hubs that the user plugs in).  On
>>> other systems, a Device Tree database might provide the same
>>> information.
>> I think we can not power off ports on the hubs that the user plugs in.
> You are wrong.  Some hubs do allow ports to be powered off.  Most
> don't, but some do.
Ok. Thanks for correct. So how to control ports' power on those
hub? via set or clear PORT_POWER?
>>> I still don't see what the problem is.  They don't have to be
>>> synchronized; all you need to do is make sure that the port's state
>>> remains set to "off" until the debouncing is finished and you have
>>> turned off the connect-change and enable-change features.
>>      Do you mean during debouncing, the USB_PORT_FEAT_CONNECTION
> USB_PORT_STAT_C_CONNECTION, not USB_PORT_FEAT_CONNECTION.
>> will be clear. So the hub_irq() will not receive connect-change event?
Sorry. I may misunderstand your statement. I try to make it clear. :)

>All you have to do is turn off the connect-change status bit.  In fact,
>the debounce routine does this already.  Just leave the port state set
>to "off" until the connection is debounced.

I have checked hub_port_debounce(). The routine only clear
port feature USB_PORT_FEAT_C_CONNECTION when connect-change event
is detected.

"turn off the connect-change status bit". you mean unmask the
connect and enable change status bit.
just like:
portchange&= ~(USB_PORT_STAT_C_CONNECTION |
		USB_PORT_STAT_C_ENABLE);
right?

> Why is hub_port_connect_change() going to get called?  hub_event()
> doesn't call hub_port_connect_change() when it doesn't need to.
> In this case it won't need to, because debouncing turns off the
> connect-change status.
in the hub_event(), the routine will get port's status and
port change status every time. How does hub_port_debounce()
turn off the the value of port change status in the hub_event?

hub_event() {
	...
	connect_change = test_bit(i, hub->change_bits);
	if (!test_and_clear_bit(i, hub->event_bits)&&
					!connect_change)
				continue;

	ret = hub_port_status(hub, i,
		&portstatus,&portchange);
	if (ret<  0)
		continue;

	/*
	 * if we unmask the portchange here,
	 * the hub_port_connect_change() will not be
	 * invoked.
	 * portchange&= ~(USB_PORT_STAT_C_CONNECTION |
	 * USB_PORT_STAT_C_ENABLE);
	 */

	if (portchange&  USB_PORT_STAT_C_CONNECTION) {
		clear_port_feature(hdev, i,
			USB_PORT_FEAT_C_CONNECTION);
		connect_change = 1;
	}
	...
}

Is there a way to forbid connect-change or enable-change bits
to be on when these events take place?

> Do you know what a "reset-resume" is? See Documentation/usb/persist.txt.
I know reset-resume. But if hub_port_connect_change() is invoked.
It just like unplug and plug device.

My main question is that how does usb_port_debounce() prevent the
connect-change and enable-change bits to be off.
-- 
Best Regards
Tianyu Lan
linux kernel enabling team

