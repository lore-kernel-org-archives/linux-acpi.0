From: "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 16/16] ACPI / DSD: Document references, ports and endpoints
Date: Tue, 14 Mar 2017 21:43:55 +0100
Message-ID: <CAJZ5v0i4pEKkz+3Ob42x96YHpPWasH2O8VnDCz8aKw_wxywLyQ@mail.gmail.com>
References: <1488809970-25568-1-git-send-email-sakari.ailus@linux.intel.com>
 <1488809970-25568-17-git-send-email-sakari.ailus@linux.intel.com>
 <1629581.fh46rNHz4U@aspire.rjw.lan> <3df6ac2a-29cc-52b1-cc0c-4c1bc4198c83@linux.intel.com>
 <d0ce808b-a000-6038-c347-25fae32535dc@linux.intel.com> <CAJZ5v0j1i-tNOdyhhknYCSPbOg7KAQpYgeReH_KwgebO3AcjRA@mail.gmail.com>
 <cf2ab8be-a351-f1ea-28a9-f5cca57061cd@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cf2ab8be-a351-f1ea-28a9-f5cca57061cd-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Al Stone <ahs3-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Mar 14, 2017 at 6:54 PM, Sakari Ailus
<sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:
> Hi Rafael,
>
> Rafael J. Wysocki wrote:
>>
>> On Tue, Mar 14, 2017 at 9:09 AM, Sakari Ailus
>> <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:
>>>
>>> On 03/14/17 10:08, Sakari Ailus wrote:
>>>>
>>>> How about this instead:
>>>>
>>>> All port nodes are located under the device's "_DSD" node in the
>>>> hierarchical data extension tree. The property extension related to
>>>> each port node must contain the key "port" and an integer value which
>>>> is the number of the port.
>>>
>>>
>>> So with matching strings instead of indices, this will change, too...
>>
>>
>> It doesn't have to AFAICS, but the number is just redundant IMO.  You
>> only need a boolean property saying "this is a port", so you know that
>> you should expect a list of endpoints in that object.
>
>
> No, it's not redundant. It's the number of the physical port in the device
> --- this is how the driver gets to know where the connection has been made.

OK, but what exactly do you mean by "physical port"?

Thanks,
Rafael
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
