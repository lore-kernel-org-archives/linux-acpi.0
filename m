From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v4 16/16] ACPI / DSD: Document references, ports and endpoints
Date: Tue, 14 Mar 2017 23:11:40 +0100
Message-ID: <CAJZ5v0hCvcPgYYV0Hysfu0pEYCzzHp7KKdW3nYyjm7RGS3bHoQ@mail.gmail.com>
References: <1488809970-25568-1-git-send-email-sakari.ailus@linux.intel.com>
 <1488809970-25568-17-git-send-email-sakari.ailus@linux.intel.com>
 <1629581.fh46rNHz4U@aspire.rjw.lan> <3df6ac2a-29cc-52b1-cc0c-4c1bc4198c83@linux.intel.com>
 <d0ce808b-a000-6038-c347-25fae32535dc@linux.intel.com> <CAJZ5v0j1i-tNOdyhhknYCSPbOg7KAQpYgeReH_KwgebO3AcjRA@mail.gmail.com>
 <cf2ab8be-a351-f1ea-28a9-f5cca57061cd@linux.intel.com> <CAJZ5v0i4pEKkz+3Ob42x96YHpPWasH2O8VnDCz8aKw_wxywLyQ@mail.gmail.com>
 <dba2ce05-fc0c-3994-118c-a7de6a5afc78@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ot0-f174.google.com ([74.125.82.174]:33828 "EHLO
        mail-ot0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751196AbdCNWLm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 14 Mar 2017 18:11:42 -0400
In-Reply-To: <dba2ce05-fc0c-3994-118c-a7de6a5afc78@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Al Stone <ahs3@redhat.com>

On Tue, Mar 14, 2017 at 10:16 PM, Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
> Rafael J. Wysocki wrote:
>>
>> On Tue, Mar 14, 2017 at 6:54 PM, Sakari Ailus
>> <sakari.ailus@linux.intel.com> wrote:
>>>
>>> Hi Rafael,
>>>
>>> Rafael J. Wysocki wrote:
>>>>
>>>>
>>>> On Tue, Mar 14, 2017 at 9:09 AM, Sakari Ailus
>>>> <sakari.ailus@linux.intel.com> wrote:
>>>>>
>>>>>
>>>>> On 03/14/17 10:08, Sakari Ailus wrote:
>>>>>>
>>>>>>
>>>>>> How about this instead:
>>>>>>
>>>>>> All port nodes are located under the device's "_DSD" node in the
>>>>>> hierarchical data extension tree. The property extension related to
>>>>>> each port node must contain the key "port" and an integer value which
>>>>>> is the number of the port.
>>>>>
>>>>>
>>>>>
>>>>> So with matching strings instead of indices, this will change, too...
>>>>
>>>>
>>>>
>>>> It doesn't have to AFAICS, but the number is just redundant IMO.  You
>>>> only need a boolean property saying "this is a port", so you know that
>>>> you should expect a list of endpoints in that object.
>>>
>>>
>>>
>>> No, it's not redundant. It's the number of the physical port in the
>>> device
>>> --- this is how the driver gets to know where the connection has been
>>> made.
>>
>>
>> OK, but what exactly do you mean by "physical port"?
>
>
> The device (or an IP block) has physical interfaces to the world outside.
> There could be just one, but there may be more. For an ISP, there could be
> e.g. four CSI-2 receivers to each of which you could connect a camera
> sensor. So for an ISP device, that number tells which of the receivers a
> given sensor is connected to.
>
> The mapping between this number and what the hardware datasheet refers to
> needs to be documented per device.

OK, so the number actually is an arbitrary piece of data associated
with the key "port" and the interpretation of that piece of data
depends on whoever asks for that value.

IOW, the core doesn't care.

With all due respect to whoever invented this on the DT side, this is
just bad design to me, because it causes the "port" property to serve
two different purposes at the same time.  First, it tells the core
that this object is a port.  Second, it is expected to provide a piece
of data of unspecified interpretation to somebody.  Which means that
the "port" property is both general and device-specific at the same
time and the sanity of that is quite questionable IMO.

Thanks,
Rafael
