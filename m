From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 0/2] ACPI / PMIC: constify platform_device_id
Date: Tue, 28 Nov 2017 21:58:42 +0100
Message-ID: <CAJZ5v0hnPzt8adPOWik9YYFtdkjqzZSuBgQh4QCm1KzhKJn-vA@mail.gmail.com>
References: <cover.1511863076.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ot0-f195.google.com ([74.125.82.195]:39247 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752034AbdK1U6n (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Nov 2017 15:58:43 -0500
In-Reply-To: <cover.1511863076.git.arvind.yadav.cs@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Andy Shevchenko <andy@infradead.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Tue, Nov 28, 2017 at 11:01 AM, Arvind Yadav
<arvind.yadav.cs@gmail.com> wrote:
> platform_device_id are not supposed to change at runtime. All functions
> working with platform_device_id provided by <linux/platform_device.h>
> work with const platform_device_id. So mark the non-const structs as
> const.
>
> Arvind Yadav (2):
>   [PATCH 1/2] ACPI / PMIC: constify platform_device_id
>   [PATCH 2/2] ACPI / PMIC: Constify platform_device_id

Can you please resend the two changes in this series as one patch?

Thanks,
Rafael
