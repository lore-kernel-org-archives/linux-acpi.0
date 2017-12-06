From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] ACPI / GED: unregister interrupts during shutdown
Date: Wed, 6 Dec 2017 14:37:29 +0100
Message-ID: <CAJZ5v0hkajauiqEmEVv+k-OYeP+_S4wufjuR7vmhcxARpRpw=g@mail.gmail.com>
References: <1512507705-2411-1-git-send-email-okaya@codeaurora.org>
 <CAJZ5v0jcFqG=Jd19ms7XQMR+rGfdKTEaN7SK91DPzBa=xcMY1w@mail.gmail.com> <0b661eec-f9c7-7818-ad09-f3d488adcefe@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ot0-f193.google.com ([74.125.82.193]:33765 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751570AbdLFNha (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Dec 2017 08:37:30 -0500
In-Reply-To: <0b661eec-f9c7-7818-ad09-f3d488adcefe@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sinan Kaya <okaya@codeaurora.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Timur Tabi <timur@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-arm-msm@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Wed, Dec 6, 2017 at 2:24 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
> On 12/5/2017 5:18 PM, Rafael J. Wysocki wrote:
>> On Tue, Dec 5, 2017 at 10:01 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
>>> Some GED interrupts could be pending by the time we are doing a reboot.

[cut]

>
>>
>>>         .probe = ged_probe,
>>>         .driver = {
>>>                 .name = MODULE_NAME,
>>> --
>>
>> Overall, it looks like we should just unbind the driver from all
>> devices on shutdown.
>
> I see that shutdown is getting called on all GED instances. That should
> take care of it, right?

Yes, it should, so I'm not sure why you need the list in the first place.

Also it looks like something along the lines of devres_release_all()
should be sufficient.

Thanks,
Rafael
