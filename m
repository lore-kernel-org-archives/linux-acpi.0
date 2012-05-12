From: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [Resend PATCH V3 6/8] usb: move struct usb_device->children to
 struct usb_hub_port->child
Date: Sat, 12 May 2012 23:31:16 +0800
Message-ID: <4FAE8244.6090402@intel.com>
References: <1336723712-7686-1-git-send-email-tianyu.lan@intel.com> <1336723712-7686-7-git-send-email-tianyu.lan@intel.com> <20120512001027.GA25600@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120512001027.GA25600-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org, mfm-Oo0r1OC9pj9iLUuM0BA3LQ@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On 2012/5/12 8:10, Greg KH wrote:
> On Fri, May 11, 2012 at 04:08:30PM +0800, Lan Tianyu wrote:
>
>> +struct usb_device *usb_get_hub_child_device(struct usb_device *hdev,
>> +	int port1)
>> +{
>> +	struct usb_hub *hub = hdev_to_hub(hdev);
>> +
>> +	if (!hub || port1>  hdev->maxchild || port1<  1)
>> +		return NULL;
>> +	return hub->port_data[port1 - 1].child;
>> +}
>> +EXPORT_SYMBOL_GPL(usb_get_hub_child_device);
> We need kerneldoc documentation for this new public function.  Please
> send a follow-on patch that adds this.
Ok. I will do it later.
> thanks,
>
> greg k-h


-- 
Best Regards
Tianyu Lan
linux kernel enabling team

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
