From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: Re: [PATCH 0/2] ACPI / PMIC: constify platform_device_id
Date: Wed, 29 Nov 2017 10:02:57 +0530
Message-ID: <06603cb3-8645-c1a2-d222-f8b012a71a46@gmail.com>
References: <cover.1511863076.git.arvind.yadav.cs@gmail.com>
 <CAJZ5v0hnPzt8adPOWik9YYFtdkjqzZSuBgQh4QCm1KzhKJn-vA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pf0-f181.google.com ([209.85.192.181]:40930 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751706AbdK2EdP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Nov 2017 23:33:15 -0500
In-Reply-To: <CAJZ5v0hnPzt8adPOWik9YYFtdkjqzZSuBgQh4QCm1KzhKJn-vA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Andy Shevchenko <andy@infradead.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

Hi Rafael,


On Wednesday 29 November 2017 02:28 AM, Rafael J. Wysocki wrote:
> On Tue, Nov 28, 2017 at 11:01 AM, Arvind Yadav
> <arvind.yadav.cs@gmail.com> wrote:
>> platform_device_id are not supposed to change at runtime. All functions
>> working with platform_device_id provided by <linux/platform_device.h>
>> work with const platform_device_id. So mark the non-const structs as
>> const.
>>
>> Arvind Yadav (2):
>>    [PATCH 1/2] ACPI / PMIC: constify platform_device_id
>>    [PATCH 2/2] ACPI / PMIC: Constify platform_device_id
> Can you please resend the two changes in this series as one patch?
Yes, I will resend as single patch.
> Thanks,
> Rafael
Thanks,
~arvind
