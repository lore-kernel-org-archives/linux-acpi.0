From: Shanker Donthineni <shankerd@codeaurora.org>
Subject: Re: [PATCH] ACPI : Update platform device numa node based on _PXM
 method
Date: Tue, 28 Mar 2017 17:51:20 -0500
Message-ID: <18560c7a-c9c5-1cf1-2e74-cf28c3a16b97@codeaurora.org>
References: <1490108070-24061-1-git-send-email-shankerd@codeaurora.org>
 <1932728.uFK6bUjlgv@aspire.rjw.lan>
 <6b298342-2746-f6d5-0b0e-67c20fd4c002@codeaurora.org>
 <13204058.j7zPSh58G6@aspire.rjw.lan>
Reply-To: shankerd@codeaurora.org
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:43862 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752794AbdC1Wv3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Mar 2017 18:51:29 -0400
In-Reply-To: <13204058.j7zPSh58G6@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Vikram Sethi <vikrams@codeaurora.org>

Hi Rafael,


On 03/28/2017 05:15 PM, Rafael J. Wysocki wrote:
> On Tuesday, March 28, 2017 05:14:13 PM Shanker Donthineni wrote:
>> Hi Rafael,
>>
>>
>> On 03/28/2017 04:43 PM, Rafael J. Wysocki wrote:
>>> On Tuesday, March 21, 2017 09:54:30 AM Shanker Donthineni wrote:
>>>> The optional _PXM method evaluates to an integer that identifies the
>>>> proximity domain of a device object. This patch implements support for
>>>> ACPI _PXM method and updates the platform device numa node id using
>>>> acpi_get_node(), which provides the PXM to NUMA mapping information.
>>>>
>>>> Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
>>> What exactly is the motivation here?
>> We have a couple of platform devices some of them are attached
>> to socket0 and others to a different socket. We would like to covert
>> memory allocations in Qualcomm platform device drivers to a NUMA
>> aware allocation to improve performance.
> All of the above information should be there in the patch changelog and
> presumably the patch should be a part of a larger series so the way this
> feature is going to be used is more clear.

Sorry, I didn't quite get what's larger series? I'm happy to include above information in commit/changelog text. We are trying to allocate memory using standard  function devm_kmalloc() but the function is always allocating memory from NUMA node 0. The inline function dev_to_node(dev) always returns -1 on our system even though we are setting PXM method in ACPI DSDT to non-zero value.

For device tree based kernel, the field 'dev->numa_node' is populated based on the DT property which is specified according to the below document. But in case of ACPI based kernel this NUMA field is always initialized to -1 for platform devices.

https://www.kernel.org/doc/Documentation/devicetree/bindings/numa.txt

Please guide me, should I send v2 patch with the suggested changelog text? otherwise I don't have any other patches to show our use case.

>
> Thanks,
> Rafael
>

-- 
Shanker Donthineni
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

