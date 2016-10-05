From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [RFC 00/15] ACPI graph support
Date: Wed, 5 Oct 2016 16:30:18 +0100
Message-ID: <788f4bcd-605f-2694-5df5-ec7ef1bde233@arm.com>
References: <1475621148-21427-1-git-send-email-sakari.ailus@linux.intel.com>
 <20161005092215.GA20248@red-moon> <20161005114129.GI1765@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:44028 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752389AbcJEPaX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 5 Oct 2016 11:30:23 -0400
In-Reply-To: <20161005114129.GI1765@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, linux-acpi@vger.kernel.org, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com



On 05/10/16 12:41, Mika Westerberg wrote:
> On Wed, Oct 05, 2016 at 10:22:15AM +0100, Lorenzo Pieralisi wrote:
>> [ +MarkR, MarkB, Rob, Al - I suspect they may want to have a say]
>>
>> On Wed, Oct 05, 2016 at 01:45:33AM +0300, Sakari Ailus wrote:
>>> Hello everyone,
>>>
>>> I've been working awhile with my collegue Mika Westerberg to bring
>>> firmware graph support to ACPI based systems. In practice the
>>> functionality achieved by these patches is very similar to what the Device
>>> tree provides: the port and the endpoint concept are being employed. The
>>> patches make use of the _DSD property and data extensions to achieve this.
>>> The fwnode interface is extended by graph functionality; this way graph
>>> information originating from both OF and ACPI may be accessed using the
>>> same interface.
>>
>> There is an ongoing effort to avoid wholesale import of DT bindings
>> into ACPI, I am not a V4L2 expert but it seems to me that with patches
>> like the one you have submitted we are getting closer and closer to
>> achieving it instead of avoiding it.
>
> The whole purpose of PRP0001 ID is to allow DT bindings to be reused in
> ACPI systems, so that the drivers can just call device_property_* and
> get the properties regardless of the underlying firmware interface.
>

Does this also mean if there's some new bindings added to DT which ACPI
specification still lacks, then instead of enhancing ACPI specification
adding that to it, we can take a shortcut method of PRP0001 and
completely ignore ACPI. People are trying to do that as it's simple and
faster.

And yes this has been raised multiple times in past, but worth raising
every-time we head in that direction. And it's increasing day-by-day
which is alarming.

Even though you may say no to that, it absolutely prevents no one
to do so unless we control what bindings can be support using DSD.

-- 
Regards,
Sudeep
