From: "Lan, Tianyu" <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [RFC PATCH] usb/acpi: Add support usb port power off mechanism
 for device fixed on the motherboard
Date: Fri, 11 May 2012 19:54:04 +0000
Message-ID: <4CFBC02C07DA244CA19D6815A05BE6EE0A6910@SHSMSX101.ccr.corp.intel.com>
References: <4FAD3A51.4010803@intel.com>
 <Pine.LNX.4.44L0.1205111302080.1865-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.1205111302080.1865-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Sarah Sharp <sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On 2012/5/12 1:44, Alan Stern wrote:
> On Sat, 12 May 2012, Lan Tianyu wrote:
>>  From my opinion, ACPI will tell us whether the port is connectable or not.
> ACPI will tell you about some ports, not others (for example, ACPI
> knows nothing about the ports on hubs that the user plugs in).  On
> other systems, a Device Tree database might provide the same
> information.
I think we can not power off ports on the hubs that the user plugs in.
Power off needs platform support.  So those port that can be power
off must be on the motherboard and platform knows these ports.

>>> Makes sense.  (But I foresee a lot of confusion among users when this
>>> box is checked and the ports don't get powered down -- many of
>>> today's laptops are incapable of powering down their USB ports.)
>>>
>> How about to just provide sys files if the usb port can be power off
>> and the checkbox only is selectable when sys files exit.
> The problem is that the kernel doesn't know whether a port can be
> powered off.  For some ports, you may be able to rely on platform
> information like ACPI.  But for other ports, you simply can't tell.
  The same as previous. Platform should know all the port that
Can be power off. These port must be on the motherboard.
>>>> When we turn the power back on, we'll get a connect status change bit
>>>> set.  We don't want the USB core to misinterpret that bit and try to
>>>> logically disconnect the device attached to the port.
>>> All you have to do is turn off the connect-change status bit.  In fact,
>>> the debounce routine does this already.  Just leave the port state set
>>> to "off" until the connection is debounced.
>> This is my original version. :)
>> But after testing, I found that after the connection is debounced,
>> hub_port_connect_change() may not to be invoked or not reach place
>> "disconnect devices".
>>
>> hub_port_connect_change() {
>> ...
>> /* debounce may be completed before here and port's state has becomed
>>   * "on". The device also will be removed.
>>   */	
>> if (hub->port_data[port1 - 1].power_state == USB_PORT_POWER_STATE_OFF) {
>> 	clear_bit(port1, hub->change_bits);
>> 	return;
>> }
>> 	
>> /* Disconnect any existing devices under this port */
>> if (udev)
>> 	usb_disconnect(&hub->port_data[port1-1].child);
>> clear_bit(port1, hub->change_bits);
>>
>> ...
>> }
> This doesn't matter.  Disconnections will be handled by 
> usb_reset_and_verify_device(), when it is called by 
> finish_port_resume().
This will cause the device to be re-enumerated. Just like
unplugged and plugged a device. I think this is not what
we want.  Disconnect and create the same device. device
num is also change.
>
>> I spent a lot of time resolving the problem. At last, I found to add
>> "waiting for connection" state to resolve the problem.
>>
>> After power on the port, hub_irq() invokes kick_khubd() to deal with
>> connect or enable change event. Connect debouncing does in the
>> usb_port_resume() and  connect-change event is processed in hub_thread().
>> It is hard to synchronize them and the port's state should be set to
>> "on" after the connect-change event finishing.
> I still don't see what the problem is.  They don't have to be
> synchronized; all you need to do is make sure that the port's state
> remains set to "off" until the debouncing is finished and you have
> turned off the connect-change and enable-change features.
    Do you mean during debouncing, the USB_PORT_FEAT_CONNECTION
will be clear. So the hub_irq() will not receive connect-change event?

> I don't know; it seems more likely that you'll have a problem when the 
> power is turned off, not when it is turned on.  That's when the connect 
> and enable status changes occur.

Connect-change will occur both in power on and power off. The port
state is different "". Just like unplug and plug.

What I see is that during the deboucing, the connect-change event also
will received. So there are two paths.  The usb_port_resume will set
port state to "on". hub_port_connect_change() needs port state to
determine whether disconnect device. If "on", disconnect device.
If "off", return directly. They are in two threads. So how to make
sure to set port state to "on" after hub_port_connect_change()
make decision whether to disconnect device or not.

 usb_port_resume()
        ||
 power on the port
        ||                                                          
    deboucing                      connect change (connect status => on)
        ||                                       ||
   set port state "on"               hub_irq() kick_khub() (connect-change event received)
                                                 ||
                                          hub_thread() hub_event()
                                           hub_port_connect_change()
																					



-- 
Best Regards
Tianyu Lan
linux kernel enabling team


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
