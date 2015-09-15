From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] ACPI: tables: simplify acpi_parse_entries
Date: Tue, 15 Sep 2015 14:35:32 +0100
Message-ID: <55F81EA4.7000400@arm.com>
References: <1442243686-15845-1-git-send-email-sudeep.holla@arm.com>
 <1725643.HXZjLoU2vc@vostro.rjw.lan> <55F7E583.2070207@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:50667 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751694AbbIONfh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 15 Sep 2015 09:35:37 -0400
In-Reply-To: <55F7E583.2070207@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Sudeep Holla <Sudeep.Holla@arm.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>



On 15/09/15 10:31, Sudeep Holla wrote:
>
>
> On 15/09/15 00:41, Rafael J. Wysocki wrote:
>> On Monday, September 14, 2015 04:14:46 PM Sudeep Holla wrote:
>>> acpi_parse_entries passes the table end pointer to the sub-table entry
>>> handler. acpi_parse_entries itself could validate the end of an entry
>>> against the table end using the length in the sub-table entry.
>>>
>>> This patch adds the validation of the sub-table entry end using the
>>> length field.This will help to eliminate the need to pass the table end
>>> to the handlers.
>>>
>>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>>

[...]

> I will respin the patch as per your suggestion but needs to go only
> after Al's MADT patches.
>

Alternately we can retain passing table_end to the handlers for now.

Once Al's MADT series removes those BAD_GIC_ENTRY macros, there will be
no users of that second argument in subtable handlers and it can be
completely removed. Let me know your thoughts.

Regards,
Sudeep
