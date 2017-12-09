From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH V3] ACPI / GED: unregister interrupts during shutdown
Date: Sat, 9 Dec 2017 15:12:23 +0100
Message-ID: <CAJZ5v0gnoZZhpCa4ttyEyVA6vKKSiCrQx8bVVKWWH_+O1uYTLA@mail.gmail.com>
References: <1512708033-28180-1-git-send-email-okaya@codeaurora.org>
 <CAJZ5v0iqXz-zBb5Lg_f1FU54-H5hiWcfg-1Qa3hDdbUz=hZD0g@mail.gmail.com> <158410c8-2861-a2c9-1246-9604ab9a8e91@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:35691 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751261AbdLIOMY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 9 Dec 2017 09:12:24 -0500
In-Reply-To: <158410c8-2861-a2c9-1246-9604ab9a8e91@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sinan Kaya <okaya@codeaurora.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Timur Tabi <timur@codeaurora.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Sat, Dec 9, 2017 at 2:54 AM, Sinan Kaya <okaya@codeaurora.org> wrote:
> On 12/8/2017 8:54 AM, Rafael J. Wysocki wrote:
>>> static int ged_remove(struct platform_device *pdev)
>>> +{
>>> +       struct acpi_ged_device *geddev = platform_get_drvdata(pdev);
>>>
>>> +       ged_cleanup_irq(geddev);
>> Do you really need this duplication?  You may as well call
>> ged_shutdown() from here.
>>
>> And the local variable is redundant too.
>>
>> I guess it would be better to just fold ged_cleanup_irq() into
>> ged_shutdown() and call that from ged_remove().
>>
>
> I originally tried to make these two APIs as common as possible and tried
> calling shutdown from remove. However, the calling convention of shutdown
> and remove are different.

Look at the code in your patch: ged_shutdown() does exactly the same
things as ged_remove(), except that ged_remove() returns 0 in addition
to that, so you can do it this way:

static int int ged_remove(struct platform_device *pdev)
{
       ged_shutdown(pdev);
       return 0;
}

Why wouldn't that work?

> Shutdown returns void; whereas, remove returns an integer. That's why, I
> created a common function and called from both places.
>
> I can probably make the calling parameter of ged_cleanup_irq() a pdev and
> get rid of the additional casting in these two different functions.
>
> Let me know if you have a better idea.

And with the above, you can fold your ged_cleanup_irq() into
ged_shutdown(), can't you?
