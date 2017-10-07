From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] PM / ACPI: Removed unused function
Date: Sat, 7 Oct 2017 08:44:33 +0200
Message-ID: <CAPDyKFomApGebKqEMzpkiHJxq_YMxWaB6DUB9pjRDc_z-W3G8w@mail.gmail.com>
References: <1507273714-26394-1-git-send-email-ulf.hansson@linaro.org>
 <20171006121230.GA14256@amd> <20171006121455.GA14483@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-it0-f51.google.com ([209.85.214.51]:49385 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750864AbdJGGof (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 7 Oct 2017 02:44:35 -0400
Received: by mail-it0-f51.google.com with SMTP id y15so3660137ita.4
        for <linux-acpi@vger.kernel.org>; Fri, 06 Oct 2017 23:44:35 -0700 (PDT)
In-Reply-To: <20171006121455.GA14483@amd>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Len Brown <lenb@kernel.org>

On 6 October 2017 at 14:14, Pavel Machek <pavel@ucw.cz> wrote:
> On Fri 2017-10-06 14:12:30, Pavel Machek wrote:
>> On Fri 2017-10-06 09:08:34, Ulf Hansson wrote:
>> > acpi_dev_pm_get_node() isn't used or implemented, let's remove it.
>> >
>> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>
>> Acked-by: Pavel Machek <pavel@ucw.cz>
>
> I was too quick sending this.
>
> How is it unused?
>
> ./drivers/acpi/device_pm.c: * acpi_dev_pm_attach - Prepare device for
> ACPI power management.
> ./drivers/acpi/device_pm.c:int acpi_dev_pm_attach(struct device *dev,
> bool power_on)
> ./drivers/acpi/device_pm.c:EXPORT_SYMBOL_GPL(acpi_dev_pm_attach);
> Binary file ./drivers/acpi/device_pm.o matches
> Binary file ./drivers/base/power/common.o matches
> ./drivers/base/power/common.c:            ret =
> acpi_dev_pm_attach(dev, power_on);

I think you searched for the wrong function. It should be
acpi_dev_pm_get_node().

Kind regards
Uffe
