From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] ACPI / property: Export a couple of symbols.
Date: Thu, 17 Mar 2016 14:00:46 +0100
Message-ID: <CAJZ5v0gP4uWs8ka8SUGzxJ9GcRKdMiRMpc+OktBTHtug9MAdBw@mail.gmail.com>
References: <1458174199-23615-1-git-send-email-ddaney.cavm@gmail.com>
	<20160317080926.GO1793@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176]:33759 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933267AbcCQNAr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Mar 2016 09:00:47 -0400
In-Reply-To: <20160317080926.GO1793@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>, David Daney <ddaney.cavm@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Robert Richter <rrichter@cavium.com>, Tomasz Nowicki <tn@semihalf.com>, David Daney <david.daney@cavium.com>

On Thu, Mar 17, 2016 at 9:09 AM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> On Wed, Mar 16, 2016 at 05:23:19PM -0700, David Daney wrote:
>> From: David Daney <david.daney@cavium.com>
>>
>> The acpi_dev_prop_read() and acpi_dev_prop_read_single() can be called
>> by drivers.  Add EXPORT_SYMBOL_GPL to them to allow use by modular
>> drivers.  This makes them consistent with acpi_dev_get_property() and
>> acpi_node_get_property_reference() which are already exported.
>>
>> Signed-off-by: David Daney <david.daney@cavium.com>
>> ---
>> FWIW: We hope to submit soon Cavium Thunder networking patches that
>> fail under modular builds without these exports.
>
> You should not be using these functions directly in drivers.

That's exactly my point.
