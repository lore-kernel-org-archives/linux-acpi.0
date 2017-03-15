From: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v4 16/16] ACPI / DSD: Document references, ports and
 endpoints
Date: Wed, 15 Mar 2017 13:45:48 +0200
Message-ID: <de8e9507-6d62-8a3a-5c4c-5eb3a04b8c55@linux.intel.com>
References: <1629581.fh46rNHz4U@aspire.rjw.lan>
 <20170315082351.GA24531@paasikivi.fi.intel.com>
 <1773cade-654d-f704-0d4a-44a76699ecab@linux.intel.com>
 <1595427.gxrcIpTbyD@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1595427.gxrcIpTbyD-yvgW3jdyMHm1GS7QM15AGw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Cc: "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Al Stone <ahs3-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On 03/15/17 13:28, Rafael J. Wysocki wrote:
> On Wednesday, March 15, 2017 11:33:35 AM Sakari Ailus wrote:
>> On 03/15/17 10:23, Sakari Ailus wrote:
>>> On Wed, Mar 15, 2017 at 12:13:45AM +0100, Rafael J. Wysocki wrote:
>>>> On Tue, Mar 14, 2017 at 11:53 PM, Sakari Ailus
>>>> <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:
>>>>> Rafael J. Wysocki wrote:
>>>>>>
>>>>>> On Tue, Mar 14, 2017 at 10:16 PM, Sakari Ailus
>>>>>> <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:
>>>>>>>
>>>>>>> Rafael J. Wysocki wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On Tue, Mar 14, 2017 at 6:54 PM, Sakari Ailus
>>>>>>>> <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Hi Rafael,
>>>>>>>>>
>>>>>>>>> Rafael J. Wysocki wrote:
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> On Tue, Mar 14, 2017 at 9:09 AM, Sakari Ailus
>>>>>>>>>> <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> On 03/14/17 10:08, Sakari Ailus wrote:
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> How about this instead:
>>>>>>>>>>>>
>>>>>>>>>>>> All port nodes are located under the device's "_DSD" node in the
>>>>>>>>>>>> hierarchical data extension tree. The property extension related to
>>>>>>>>>>>> each port node must contain the key "port" and an integer value
>>>>>>>>>>>> which
>>>>>>>>>>>> is the number of the port.
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> So with matching strings instead of indices, this will change, too...
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> It doesn't have to AFAICS, but the number is just redundant IMO.  You
>>>>>>>>>> only need a boolean property saying "this is a port", so you know that
>>>>>>>>>> you should expect a list of endpoints in that object.
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> No, it's not redundant. It's the number of the physical port in the
>>>>>>>>> device
>>>>>>>>> --- this is how the driver gets to know where the connection has been
>>>>>>>>> made.
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> OK, but what exactly do you mean by "physical port"?
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> The device (or an IP block) has physical interfaces to the world outside.
>>>>>>> There could be just one, but there may be more. For an ISP, there could
>>>>>>> be
>>>>>>> e.g. four CSI-2 receivers to each of which you could connect a camera
>>>>>>> sensor. So for an ISP device, that number tells which of the receivers a
>>>>>>> given sensor is connected to.
>>>>>>>
>>>>>>> The mapping between this number and what the hardware datasheet refers to
>>>>>>> needs to be documented per device.
>>>>>>
>>>>>>
>>>>>> OK, so the number actually is an arbitrary piece of data associated
>>>>>> with the key "port" and the interpretation of that piece of data
>>>>>> depends on whoever asks for that value.
>>>>>>
>>>>>> IOW, the core doesn't care.
>>>>>>
>>>>>> With all due respect to whoever invented this on the DT side, this is
>>>>>> just bad design to me, because it causes the "port" property to serve
>>>>>> two different purposes at the same time.  First, it tells the core
>>>>>> that this object is a port.  Second, it is expected to provide a piece
>>>>>> of data of unspecified interpretation to somebody.  Which means that
>>>>>> the "port" property is both general and device-specific at the same
>>>>>> time and the sanity of that is quite questionable IMO.
>>>>>
>>>>>
>>>>> DT uses a node called either "port" or "ports" to store the port nodes. The
>>>>> reg property tells the number of the port (see
>>>>> Documentation/devicetree/bindings/graph.txt). I'm no DT expert, but my
>>>>> understanding is that the node namespace is different from the property
>>>>> namespace.
>>>>
>>>> So on the DT side it actually looks OK to me.
>>>>
>>>> And the <reg> value is referred to as the port-endpoint identifier, so
>>>> I guess this is used for referring to the port/endpoint instead of an
>>>> index or the key value somewhere?
>>>
>>> The remote-endpoint uses phandles; they're a mechanism in DT to refer to
>>> different nodes in the tree (DT does not differentiate between devices and
>>> non-device nodes). There's a relatively good example here:
>>>
>>> 	arch/arm/boot/dts/omap3-n9.dts
> 
> Yes, I figured that out. :-)
> 
> Still, the <rev> property value is used for something somewhere in the code I gather.
> 
>>>>
>>>>> If you're concerned of possible double meanings, it's entirely possible to
>>>>> put the port nodes under hierarchical data extension named e.g. "ports", and
>>>>> document that this is what the node must be called (single port node could
>>>>> be just called "port"). This way, it should be much more difficult to
>>>>> interpret a non-port node as a port node --- roughly equivalent of the DT
>>>>> ports node.
>>>>>
>>>>> The drawback with this change is that the size of the data structure in ASL
>>>>> (and AML) will grow.
>>>>
>>>> The "ports" thing would only be useful if we had the other properties
>>>> to put in there.
>>>>
>>>> So I guess we can specify that the "port" property value is the
>>>> identifier of the port and then we will use this in the
>>>> "remote-endpoint" property on the other end instead of an index.
>>>
>>> Makes sense.
>>>
>>>>
>>>> And analogously for the "enpoint" property value.
>>>
>>> The endpoint hierarchical data extension node name? There is no endpoint
>>> property being used by this version of the set anymore; I removed it as it
>>> was redundant. However a human readable endpoint node name can be chosen
>>> which that'd be quite practical to identify the endpoint.
>>>
>>> Then the remote-endpoint properties would be:
>>>
>>> 	Package () { device, port (integer), endpoint-node-name (string) }
>>>
>>
>> Oh, well... the device is present there already, so the endpoint
>> reference would well use an index pretty much equally well. Most of the
>> time it'll be zero anyway. I.e.
>>
>> 	Package() { device, port number (integer), endpoint id (integer }
> 
> Yes, I would do that, and actually not using the index for the endpoint too.
> 
> Let ports and endpoints be symmetrical in that respect, that is a port is
> required to have a { "port", id } property and an endpoind is required to
> have a { "endpoint", id } property and let the ids be used in
> "remote-endpoint" properties as per the above.
> 
> Then, in each case, the id would be whatever the value of the <rev> property
> on the DT side would be.

DT graphs only have port numbers, the endpoints are not referred to by
IDs --- just phandles. The closest equivalent we have in ACPI is a
device reference as far as I can tell, and this is why the port number
and some identifier for the endpoint is required.

Adding a numeric ID for the endpoint is somewhat artificial. Most would
just have zero there as there are commonly only a single endpoint in a
port. And if there were more than one, one of the most sensible
approaches to number them would be a monotonically incrementing number
from zero --- which is the same than the index.

So my view is that adding an endpoint property simply adds no value.

-- 
Sakari Ailus
sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
