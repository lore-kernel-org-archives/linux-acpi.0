From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH v3 4/4] device property: Move fwnode graph ops to firmware
 specific locations
Date: Tue, 21 Mar 2017 13:17:21 +0200
Message-ID: <9032e072-17d9-fea1-fe60-888686879f8d@linux.intel.com>
References: <1489671289-20406-1-git-send-email-sakari.ailus@linux.intel.com>
 <1489671289-20406-5-git-send-email-sakari.ailus@linux.intel.com>
 <CAL_JsqK0LeJ7UckS0XRQEikTPcUa-4i9yeyNiMu60SNL+i=d=Q@mail.gmail.com>
 <1484fb17-a0cd-961f-6c85-75de6e662409@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:59105 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752227AbdCUL3y (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 21 Mar 2017 07:29:54 -0400
In-Reply-To: <1484fb17-a0cd-961f-6c85-75de6e662409@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>, Al Stone <ahs3@redhat.com>, Frank Rowand <frowand.list@gmail.com>

Cc Frank. (Oops.)

Sakari Ailus wrote:
> Hi Rob,
>
> Rob Herring wrote:
>> On Thu, Mar 16, 2017 at 8:34 AM, Sakari Ailus
>> <sakari.ailus@linux.intel.com> wrote:
>>> Move firmware specific implementations of the fwnode graph operations to
>>> firmware specific locations.
>>>
>>> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
>>> ---
>>>  drivers/acpi/property.c | 61 ++++++++++++++++++++++++++++++++
>>>  drivers/base/property.c | 92
>>> +++----------------------------------------------
>>>  drivers/of/base.c       | 70 +++++++++++++++++++++++++++++++++++++
>>>  include/linux/fwnode.h  | 16 +++++++++
>>>  4 files changed, 152 insertions(+), 87 deletions(-)
>>
>> As I've mentioned before, this is just propagating APIs I would like
>> to get rid of. See my series cleaning up DRM users[1].
>
> Why would you want to get rid of the existing APIs? They do fit well for
> the purpose they're currently used for on V4L2, at least. That could be
> because the current API was implemented *for* V4L2. If you'd like to add
> a new one, then at least I'd very much like to keep what exists at the
> moment.
>
> Please see e.g. isp_fwnodes_parse() in
> drivers/media/platform/omap3isp/isp.c . That function is generic enough
> to be moved to the V4L2 framework, with a driver callback to handle
> driver specific matters.
>
>>
>>> diff --git a/drivers/of/base.c b/drivers/of/base.c
>>> index e483dd1..a8686a8 100644
>>> --- a/drivers/of/base.c
>>> +++ b/drivers/of/base.c
>>> @@ -2624,6 +2624,71 @@ static struct fwnode_handle
>>> *of_fwnode_get_named_child_node(
>>>         return NULL;
>>>  }
>>>
>>> +static struct fwnode_handle *of_fwnode_graph_get_next_endpoint(
>>> +       struct fwnode_handle *fwnode, struct fwnode_handle *prev)
>>> +{
>>> +       struct device_node *node;
>>> +
>>> +       node = of_graph_get_next_endpoint(to_of_node(fwnode),
>>> +                                         to_of_node(prev));
>>> +       if (node)
>>> +               return of_fwnode_handle(node);
>>> +
>>> +       return NULL;
>>> +}
>>
>> For example, most callers of of_graph_get_next_endpoint really just
>> want port=0, endpoint=0 and then they want the remote node. As the
>> assignment of port and endpoint numbers are fixed for a device,
>> drivers should be explicit about which port/endpoint they want. The
>> actual handle to either the port or endpoint nodes are mostly
>> irrelevant. We only really need the endpoint node handles when we have
>> properties in the endpoints.
>
> I certainly don't mind adding a new API if there are use cases the
> existing one does not serve well. But please don't remove the
> enumeration API. It's simply way more practical.
>
> If you have one or two ports and an endpoint in each, perhaps it's ok
> just to try check if one more more of them are around. Some devices may
> have e.g. six ports today and I don't think that number will go down in
> the future, it's rather going to increase.
>
> The caller can also find the endpoints without knowing the endpoint
> numbers in advance. In a number of devices' DT binding documentation it
> is not explicitly stated that endpoint IDs have a special meaning. I'm
> not fully certain everything would keep on working fine if the drivers
> that previously did not care about endpoint numbers would start e.g.
> requiring zero from now on.
>
> An analogous interface is the _ENUM IOCTLs in V4L2, with the difference
> that it's towards the user space.
>


-- 
Sakari Ailus
sakari.ailus@linux.intel.com
