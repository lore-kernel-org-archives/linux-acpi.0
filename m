From: David Daney <ddaney.cavm@gmail.com>
Subject: Re: [PATCH] ACPI / property: Export a couple of symbols.
Date: Thu, 17 Mar 2016 13:21:54 -0700
Message-ID: <56EB11E2.6050608@gmail.com>
References: <1458174199-23615-1-git-send-email-ddaney.cavm@gmail.com> <20160317080926.GO1793@lahna.fi.intel.com> <CAJZ5v0gP4uWs8ka8SUGzxJ9GcRKdMiRMpc+OktBTHtug9MAdBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pf0-f173.google.com ([209.85.192.173]:35464 "EHLO
	mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932595AbcCQUV6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Mar 2016 16:21:58 -0400
In-Reply-To: <CAJZ5v0gP4uWs8ka8SUGzxJ9GcRKdMiRMpc+OktBTHtug9MAdBw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Robert Richter <rrichter@cavium.com>, Tomasz Nowicki <tn@semihalf.com>, David Daney <david.daney@cavium.com>

On 03/17/2016 06:00 AM, Rafael J. Wysocki wrote:
> On Thu, Mar 17, 2016 at 9:09 AM, Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
>> On Wed, Mar 16, 2016 at 05:23:19PM -0700, David Daney wrote:
>>> From: David Daney <david.daney@cavium.com>
>>>
>>> The acpi_dev_prop_read() and acpi_dev_prop_read_single() can be called
>>> by drivers.  Add EXPORT_SYMBOL_GPL to them to allow use by modular
>>> drivers.  This makes them consistent with acpi_dev_get_property() and
>>> acpi_node_get_property_reference() which are already exported.
>>>
>>> Signed-off-by: David Daney <david.daney@cavium.com>
>>> ---
>>> FWIW: We hope to submit soon Cavium Thunder networking patches that
>>> fail under modular builds without these exports.
>>
>> You should not be using these functions directly in drivers.
>
> That's exactly my point.
>

OK, for the sake of argument I will concede that my particular use of 
acpi_dev_prop_read_single() is incorrect.

Let me ask you this:

What is the point of the code in drivers/acpi/property.c?

acpi_dev_prop_read() and acpi_dev_prop_read_single() are not used 
anywhere that I can see in the kernel, would you accept a patch to 
remove them?

But from a philosophical point of view, what is the underlying problem 
of having drivers extract property information from the ACPI tables 
corresponding to the devices they control.

Specifically, I am trying to understand how to port drivers that 
currently successfully use OF device tree so that they are usable in 
systems with ACPI based firmware.

Thanks in advance,
David Daney


