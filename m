From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 1/3] of: Move OF property and graph API from base.c to property.c
Date: Mon, 22 May 2017 09:38:59 -0500
Message-ID: <CAL_JsqJswk78Be6xJvK0i9y+53XhY+1XkfPSd+3S8ub_Cnm17Q@mail.gmail.com>
References: <1495440698-22260-1-git-send-email-sakari.ailus@linux.intel.com>
 <1495440698-22260-2-git-send-email-sakari.ailus@linux.intel.com>
 <CAL_JsqLwdi-oFxxF9rh4KzKim_ouQ8eDwZ5uicwtjb5-9eWHBw@mail.gmail.com> <91b4159b-cb5b-fd9a-8e9c-c37c2acd1814@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934401AbdEVOj1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 22 May 2017 10:39:27 -0400
In-Reply-To: <91b4159b-cb5b-fd9a-8e9c-c37c2acd1814@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Frank Rowand <frowand.list@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>, Al Stone <ahs3@redhat.com>

On Mon, May 22, 2017 at 9:33 AM, Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
> Hi Rob,
>
> Thanks for the review!
>
> On 05/22/17 17:22, Rob Herring wrote:
>> On Mon, May 22, 2017 at 3:11 AM, Sakari Ailus
>> <sakari.ailus@linux.intel.com> wrote:
>>> base.c contains both core OF functions and increasingly other
>>> functionality such as accessing properties and graphs, including
>>> convenience functions. In the near future this would also include OF
>>> specific implementation of the fwnode property and graph APIs.
>>>
>>> Create driver/of/property.c to contain procedures for accessing and
>>> interpreting device tree properties. The procedures are moved from
>>> drivers/of/base.c, with no changes other than copying only the includes
>>> required by the moved procedures.
>>>
>>> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
>>> ---
>>>  drivers/of/Makefile   |   2 +-
>>>  drivers/of/base.c     | 733 ------------------------------------------------
>>>  drivers/of/property.c | 763 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>
>> Please put graph functions in graph.c unless there is some reason not to.
>
> There will be a single fwnode ops struct which will contain both
> property and graph API primitives. The functions implementing the
> operations will be private, albeit the corresponding OF functions they
> will use are global.
>
> If I split current properties.c, which of these should the fwnode ops
> struct and the function callbacks be put? The patch is here (and the
> previous one; both were submitted earlier today):

Okay, makes sense. The filename is a bit confusing, but I don't have a
better suggestion.

Rob
