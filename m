From: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH V3] ACPI / GED: unregister interrupts during shutdown
Date: Fri, 8 Dec 2017 20:54:15 -0500
Message-ID: <158410c8-2861-a2c9-1246-9604ab9a8e91@codeaurora.org>
References: <1512708033-28180-1-git-send-email-okaya@codeaurora.org>
 <CAJZ5v0iqXz-zBb5Lg_f1FU54-H5hiWcfg-1Qa3hDdbUz=hZD0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:35426 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752660AbdLIByT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 8 Dec 2017 20:54:19 -0500
In-Reply-To: <CAJZ5v0iqXz-zBb5Lg_f1FU54-H5hiWcfg-1Qa3hDdbUz=hZD0g@mail.gmail.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Timur Tabi <timur@codeaurora.org>, linux-arm-msm@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 12/8/2017 8:54 AM, Rafael J. Wysocki wrote:
>> static int ged_remove(struct platform_device *pdev)
>> +{
>> +       struct acpi_ged_device *geddev = platform_get_drvdata(pdev);
>>
>> +       ged_cleanup_irq(geddev);
> Do you really need this duplication?  You may as well call
> ged_shutdown() from here.
> 
> And the local variable is redundant too.
> 
> I guess it would be better to just fold ged_cleanup_irq() into
> ged_shutdown() and call that from ged_remove().
> 

I originally tried to make these two APIs as common as possible and tried
calling shutdown from remove. However, the calling convention of shutdown
and remove are different. 

Shutdown returns void; whereas, remove returns an integer. That's why, I
created a common function and called from both places. 

I can probably make the calling parameter of ged_cleanup_irq() a pdev and
get rid of the additional casting in these two different functions. 

Let me know if you have a better idea.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
