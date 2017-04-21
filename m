From: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH] ACPI / GED: use late init to allow other drivers init
Date: Fri, 21 Apr 2017 18:48:55 -0400
Message-ID: <f352be8c-fc38-4b56-5932-e82f112b86d3@codeaurora.org>
References: <1492813704-32280-1-git-send-email-okaya@codeaurora.org>
 <CAJZ5v0gtLajqCsw0HTS=sL_=cU1aSFzUk6e_kAPAfreuCpak7g@mail.gmail.com>
 <bf1ce91f-b232-4dce-5ed7-597b0ef46f92@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:51028 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162655AbdDUWs5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Apr 2017 18:48:57 -0400
In-Reply-To: <bf1ce91f-b232-4dce-5ed7-597b0ef46f92@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Timur Tabi <timur@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 4/21/2017 6:48 PM, Sinan Kaya wrote:
> On 4/21/2017 6:43 PM, Rafael J. Wysocki wrote:
>>> +late_initcall(ged_init);
>> Does this fix the problem?
>>
>> What about if the module in question is loaded after running late_initcalls?
> 
> This fixed the issue for me where I had dependencies for QUP I2C driver and GHES
> drivers. Both of them are modules and get probed via normal module execution path.
> 
> However, I'm open to improvements.  Do you have a better suggestion? I can try
> to add some _DEP stuff if it is present, but I remember Linux doesn't like _DEP
> stuff too much.
> 

I forgot to mention that GED driver is a built-in module.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
