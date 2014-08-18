From: Aaron Lu <aaron.lu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH 6/9] gpiolib: add API to get gpio desc and flags
Date: Mon, 18 Aug 2014 15:16:01 +0800
Message-ID: <53F1A831.4090309@intel.com>
References: <1408255459-17625-1-git-send-email-mika.westerberg@linux.intel.com> <20140817130004.4B9FDC4137F@trevor.secretlab.ca> <D016516D.A1AFA%dvhart@linux.intel.com> <1927766.GeLld99ozq@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1927766.GeLld99ozq-sKB8Sp2ER+y1GS7QM15AGw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Darren Hart <dvhart-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Max Eliaser <max.eliaser-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On 08/18/2014 12:57 PM, Rafael J. Wysocki wrote:
> On Sunday, August 17, 2014 12:43:38 PM Darren Hart wrote:
>> On 8/17/14, 6:00, "Grant Likely" <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> wrote:
>>
>>>>
>>>> +	/* Using device tree? */
>>>> +	if (IS_ENABLED(CONFIG_OF) && dev->of_node)
>>>> +		desc = of_find_gpio(dev, NULL, idx, flags);
>>>
>>> of_find_gpio() doesn't exist.
>>
>> Hrm... As of 3.16.0 (e64df3ebe8262c8203d1fe4f541e0241c3112c01)
>>
>> $ git blame -L1455,1456 drivers/gpio/gpiolib.c
>> bae48da2 (Alexandre Courbot 2013-10-17 10:21:38 -0700 1455) static struct
>> gpio_desc *of_find_gpio(struct device *dev, const char *con_id,
>>
>> Have we removed this in -next or something? (on the plane, will verify
>> upon landing)
> 
> In 3.17-rc1:
> 
> rafael@vostro:~/src/linux-pm> grep -r of_find_gpio *
> drivers/gpio/gpiolib.c:static struct gpio_desc *of_find_gpio(struct device *dev, const char *con_id,
> drivers/gpio/gpiolib.c:         desc = of_find_gpio(dev, con_id, idx, &lookupflags);

I also verified the following branch:
git://git.secretlab.ca/git/linux devicetree/next
And of_find_gpio is there.

Regards,
Aaron
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
