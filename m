From: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v4 16/16] ACPI / DSD: Document references, ports and
 endpoints
Date: Wed, 15 Mar 2017 00:53:23 +0200
Message-ID: <572ba62c-3168-adcf-f9de-4826b1804f38@linux.intel.com>
References: <1488809970-25568-1-git-send-email-sakari.ailus@linux.intel.com>
 <1488809970-25568-17-git-send-email-sakari.ailus@linux.intel.com>
 <1629581.fh46rNHz4U@aspire.rjw.lan>
 <3df6ac2a-29cc-52b1-cc0c-4c1bc4198c83@linux.intel.com>
 <d0ce808b-a000-6038-c347-25fae32535dc@linux.intel.com>
 <CAJZ5v0j1i-tNOdyhhknYCSPbOg7KAQpYgeReH_KwgebO3AcjRA@mail.gmail.com>
 <cf2ab8be-a351-f1ea-28a9-f5cca57061cd@linux.intel.com>
 <CAJZ5v0i4pEKkz+3Ob42x96YHpPWasH2O8VnDCz8aKw_wxywLyQ@mail.gmail.com>
 <dba2ce05-fc0c-3994-118c-a7de6a5afc78@linux.intel.com>
 <CAJZ5v0hCvcPgYYV0Hysfu0pEYCzzHp7KKdW3nYyjm7RGS3bHoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAJZ5v0hCvcPgYYV0Hysfu0pEYCzzHp7KKdW3nYyjm7RGS3bHoQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Al Stone <ahs3-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Rafael J. Wysocki wrote:
> On Tue, Mar 14, 2017 at 10:16 PM, Sakari Ailus
> <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:
>> Rafael J. Wysocki wrote:
>>>
>>> On Tue, Mar 14, 2017 at 6:54 PM, Sakari Ailus
>>> <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:
>>>>
>>>> Hi Rafael,
>>>>
>>>> Rafael J. Wysocki wrote:
>>>>>
>>>>>
>>>>> On Tue, Mar 14, 2017 at 9:09 AM, Sakari Ailus
>>>>> <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:
>>>>>>
>>>>>>
>>>>>> On 03/14/17 10:08, Sakari Ailus wrote:
>>>>>>>
>>>>>>>
>>>>>>> How about this instead:
>>>>>>>
>>>>>>> All port nodes are located under the device's "_DSD" node in the
>>>>>>> hierarchical data extension tree. The property extension related to
>>>>>>> each port node must contain the key "port" and an integer value which
>>>>>>> is the number of the port.
>>>>>>
>>>>>>
>>>>>>
>>>>>> So with matching strings instead of indices, this will change, too...
>>>>>
>>>>>
>>>>>
>>>>> It doesn't have to AFAICS, but the number is just redundant IMO.  You
>>>>> only need a boolean property saying "this is a port", so you know that
>>>>> you should expect a list of endpoints in that object.
>>>>
>>>>
>>>>
>>>> No, it's not redundant. It's the number of the physical port in the
>>>> device
>>>> --- this is how the driver gets to know where the connection has been
>>>> made.
>>>
>>>
>>> OK, but what exactly do you mean by "physical port"?
>>
>>
>> The device (or an IP block) has physical interfaces to the world outside.
>> There could be just one, but there may be more. For an ISP, there could be
>> e.g. four CSI-2 receivers to each of which you could connect a camera
>> sensor. So for an ISP device, that number tells which of the receivers a
>> given sensor is connected to.
>>
>> The mapping between this number and what the hardware datasheet refers to
>> needs to be documented per device.
>
> OK, so the number actually is an arbitrary piece of data associated
> with the key "port" and the interpretation of that piece of data
> depends on whoever asks for that value.
>
> IOW, the core doesn't care.
>
> With all due respect to whoever invented this on the DT side, this is
> just bad design to me, because it causes the "port" property to serve
> two different purposes at the same time.  First, it tells the core
> that this object is a port.  Second, it is expected to provide a piece
> of data of unspecified interpretation to somebody.  Which means that
> the "port" property is both general and device-specific at the same
> time and the sanity of that is quite questionable IMO.

DT uses a node called either "port" or "ports" to store the port nodes. 
The reg property tells the number of the port (see 
Documentation/devicetree/bindings/graph.txt). I'm no DT expert, but my 
understanding is that the node namespace is different from the property 
namespace.

If you're concerned of possible double meanings, it's entirely possible 
to put the port nodes under hierarchical data extension named e.g. 
"ports", and document that this is what the node must be called (single 
port node could be just called "port"). This way, it should be much more 
difficult to interpret a non-port node as a port node --- roughly 
equivalent of the DT ports node.

The drawback with this change is that the size of the data structure in 
ASL (and AML) will grow.

-- 
Sakari Ailus
sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
