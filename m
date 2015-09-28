From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v2 1/2] ACPI / tables: simplify acpi_parse_entries
Date: Mon, 28 Sep 2015 14:37:31 +0100
Message-ID: <5609429B.6070604@arm.com>
References: <1442243686-15845-1-git-send-email-sudeep.holla@arm.com>
 <2184252.JT4i34L2sb@vostro.rjw.lan> <5609123F.7020307@arm.com>
 <3513292.8DqxMl02v0@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:50814 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933762AbbI1Nhg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 28 Sep 2015 09:37:36 -0400
In-Reply-To: <3513292.8DqxMl02v0@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Al Stone <al.stone@linaro.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>



On 28/09/15 14:50, Rafael J. Wysocki wrote:
> On Monday, September 28, 2015 11:11:11 AM Sudeep Holla wrote:
>>
>> On 26/09/15 01:27, Rafael J. Wysocki wrote:
>>> On Wednesday, September 16, 2015 01:58:06 PM Sudeep Holla wrote:
>>>> acpi_parse_entries passes the table end pointer to the sub-table entry
>>>> handler. acpi_parse_entries itself could validate the end of an entry
>>>> against the table end using the length in the sub-table entry.
>>>>
>>>> This patch adds the validation of the sub-table entry end using the
>>>> length field.This will help to eliminate the need to pass the table end
>>>> to the handlers.
>>>>
>>>> It also moves the check for zero length entry early so that execution of
>>>> the handler can be avoided.
>>>>
>>>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>>>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>>>>
>>>> ---
>>>>    drivers/acpi/tables.c | 31 +++++++++++++++----------------
>>>>    1 file changed, 15 insertions(+), 16 deletions(-)
>>>>
>>>> Hi Rafael,
>>>>
>>>> As I mentioned earlier, this needs to be applied after Al's MADT changes
>>>> are merged. You might get simple conflicts in acpi_parse_entries.
>>>
>>> This needs to be rebased on top of some patches in my linux-next branch.
>>>
>>> It probably is better to rebase it on top of my bleeding-edge branch that
>>> contains the Al's patches already, though.
>>>
>>
>> I don't see Al's patches in your linux-next or bleeding-edge
>
> They were there, but I've dropped them due to a 0-day testing failure.
>

Yes I guess we did see this last week, I had ask Al to fix it privately.
It was some discrepancy with ACPIv1.0 specification between different
sections that resulted in failures I saw.

> I think your patches depend on the Al's ones, is that correct?
>

Correct, I think it's easier if I wait for his patches.

Regards,
Sudeep
