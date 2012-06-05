From: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH V3 3/3] usb : Add sysfs files to control usb port's
 power
Date: Tue, 05 Jun 2012 16:30:51 +0800
Message-ID: <4FCDC3BB.50809@intel.com>
References: <Pine.LNX.4.44L0.1206041040510.1555-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.1206041040510.1555-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On 2012=E5=B9=B406=E6=9C=8804=E6=97=A5 23:02, Alan Stern wrote:
> On Mon, 4 Jun 2012, Lan Tianyu wrote:
> s/attribue/attribute/  -- here and below
>
>> +		allows the user space to control the power policy on the usb port
>> +
>> +		All ports have one of the following three values for portX/contro=
l
>> +		"auto" - For ports with device, if the device was not in the susp=
end
>> +			at that pointer, the power would remain on but it would power
>> +			off when it was suspended. If the the device was in the suspend,
>> +			"auto" means the device could be put into much lower state so
>> +			the device would be resumed and suspended again.
>
> The patch does not implement anything at all for "auto".  It should d=
o
> _something_.
>
Yeah, if we don't power off port without device when echo "auto" > port=
X/control,
this patch does nothing about "auto". Original plan is to deal with por=
t without
devices firstly. Do you mean I should add the process of port with devi=
ce in this
patch?


--=20
Best Regards
Tianyu Lan
linux kernel enabling team
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
