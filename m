From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 3/3] device property: of_property_read_string_array()
 returns number of strings
Date: Tue, 14 Mar 2017 17:57:40 +0100
Message-ID: <CAJZ5v0iNYhqY0VSumBx4-A2YcKcHv6UsXyGpRHgQdM4D-=_9SQ@mail.gmail.com>
References: <1488806791-25488-1-git-send-email-sakari.ailus@linux.intel.com>
 <1488806791-25488-4-git-send-email-sakari.ailus@linux.intel.com>
 <1840694.EMHZKJ1jEg@aspire.rjw.lan> <bf544a26-d551-e5e5-6ca1-513f35d057b4@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ot0-f182.google.com ([74.125.82.182]:35789 "EHLO
        mail-ot0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751036AbdCNQ5m (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 14 Mar 2017 12:57:42 -0400
In-Reply-To: <bf544a26-d551-e5e5-6ca1-513f35d057b4@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Al Stone <ahs3@redhat.com>

On Tue, Mar 14, 2017 at 8:17 AM, Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
> Hi Rafael,
>
> On 03/14/17 00:24, Rafael J. Wysocki wrote:
>> On Monday, March 06, 2017 03:26:31 PM Sakari Ailus wrote:
>>> of_property_read_string_array() returns number of strings read if the
>>> target array of pointers is non-NULL. fwnode_property_read_string_array()
>>> is documented to return 0 in that case. Fix this.
>>
>> Well, if we want people to use fwnode_property_read_string_array() instead of
>> of_property_read_string_array(), it should better behave analogously, shouldn't it?
>
> Not necessarily.
>
> The documentation states that fwnode_property_read_string_array()
> returns 0 on success. That makes sense since the callers often check
> whether the return value is non-zero and then return based on that.
> Returning zero on success is just simpler for the caller.
>
> Often the number of elements to read from an array is known beforehand,
> so there's little use for the actual number read.
>
> Besides the fwnode variants, also the OF integer array access functions
> return zero on success.
>
> Rob had a similar comment but the discussion did not continue after my
> initial reply. I can sure change that if you still think it's better the
> other way.

I understand the argumentation, but if X is supposed to be an easy
replacement for Y, it really should stick to the return value
conventions used by the latter or it is not easy any more.

So yes, please.

Thanks,
Rafael
