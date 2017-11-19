From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [RFC] iio: light: acpi-als: Enable the light sensor on the
 Zenbook UX430UQ
Date: Sun, 19 Nov 2017 19:11:32 +0100
Message-ID: <2bf0e8c2-efe9-c309-844c-de5392216848@denx.de>
References: <20171116032754.20719-1-kah.listaddress@gmail.com>
 <20171119170341.62e5de3d@archlinux>
 <CABFtUbQm8JMUdo46d4VJR=8gHzphxEs1UofeB+cpxW6xHkSnAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CABFtUbQm8JMUdo46d4VJR=8gHzphxEs1UofeB+cpxW6xHkSnAg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gabriele Mazzotta <gabriele.mzt-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Kiernan Hager <kah.listaddress-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On 11/19/2017 06:38 PM, Gabriele Mazzotta wrote:
> 2017-11-19 18:03 GMT+01:00 Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>:
>> On Wed, 15 Nov 2017 20:27:54 -0700
>> Kiernan Hager <kah.listaddress-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>>
>>> This makes acpi-als properly enable the light sensor on the Zenbook UX430UQ. I don't know if the checking that I do to make sure that the ACPI method exists is sufficient or if it should disable the sensor when the module is unloaded, so input is appreciated on those matters.
>>
>> Please wrap descriptions to around 72 characters (leaves room for indentation
>> in the email thread :)
>>
>> This seems very much like a board specific hack.  I've cc'd people
>> who have worked on the driver recently and the acpi list.
> 
> This is indeed board specific. I know many other laptops of the
> Zenbook line need something similar and if you look at
> drivers/platform/x86/asus-wmi.c or any other asus-* driver you'll
> find several quirks to enable various features.

Maybe that's where it should go . EC0 in the ACPI path seems like
Embedded Controller to me .

> Kiernan, check commit aca234f6378864d85514be558746c0ea6eabfa8e
> ("asus-wmi: provide access to ALS control") in particular.
> 
>>>
>>> Signed-off-by: Kiernan Hager <kah.listaddress-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>> ---
>>>  drivers/iio/light/acpi-als.c | 16 ++++++++++++++++
>>>  1 file changed, 16 insertions(+)
>>>
>>> diff --git a/drivers/iio/light/acpi-als.c b/drivers/iio/light/acpi-als.c
>>> index c35e2f8df339..8fd66166f19f 100644
>>> --- a/drivers/iio/light/acpi-als.c
>>> +++ b/drivers/iio/light/acpi-als.c
>>> @@ -179,6 +179,10 @@ static int acpi_als_add(struct acpi_device *device)
>>>       struct acpi_als *als;
>>>       struct iio_dev *indio_dev;
>>>       struct iio_buffer *buffer;
>>> +     unsigned long long temp_val;
>>> +     acpi_status status;
>>> +     struct acpi_object_list arg_list;
>>> +     union acpi_object arg;
>>>
>>>       indio_dev = devm_iio_device_alloc(&device->dev, sizeof(*als));
>>>       if (!indio_dev)
>>> @@ -203,6 +207,18 @@ static int acpi_als_add(struct acpi_device *device)
>>>
>>>       iio_device_attach_buffer(indio_dev, buffer);
>>>
>>> +     arg_list.count = 1;
>>> +     arg_list.pointer = &arg;
>>> +     arg.type = ACPI_TYPE_INTEGER;
>>> +     arg.integer.value = 1;
>>> +
>>> +     if (acpi_has_method(als->device->handle, "\\_SB.PCI0.LPCB.EC0.ALSC")) {
>> So this is poking something on
>> PCI bus 0
>> LPC bus B
>> Somethingbus 0
>> Ambient light controller.
>>
>> I assume there is a better way of establishing this needs to be set?
>>
>>> +             status = acpi_evaluate_integer(als->device->handle,
>>> +                                            "\\_SB.PCI0.LPCB.EC0.ALSC",
>>> +                                            &arg_list,
>>> +                                            &temp_val);
>>> +     }
>>> +
>>>       return devm_iio_device_register(&device->dev, indio_dev);
>>>  }
>>>
>>


-- 
Best regards,
Marek Vasut
