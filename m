From: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH] ACPI / GED: unregister interrupts during shutdown
Date: Wed, 6 Dec 2017 11:11:40 -0500
Message-ID: <aa5bcbab-b059-1abf-1553-371fe5750455@codeaurora.org>
References: <1512507705-2411-1-git-send-email-okaya@codeaurora.org>
 <CAJZ5v0jcFqG=Jd19ms7XQMR+rGfdKTEaN7SK91DPzBa=xcMY1w@mail.gmail.com>
 <0b661eec-f9c7-7818-ad09-f3d488adcefe@codeaurora.org>
 <CAJZ5v0hkajauiqEmEVv+k-OYeP+_S4wufjuR7vmhcxARpRpw=g@mail.gmail.com>
 <fe65ff1a-a8b8-c29b-161d-72cbfea5c056@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:51240 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752456AbdLFQLo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Dec 2017 11:11:44 -0500
In-Reply-To: <fe65ff1a-a8b8-c29b-161d-72cbfea5c056@codeaurora.org>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Timur Tabi <timur@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-arm-msm@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 12/6/2017 9:57 AM, Sinan Kaya wrote:
>> Yes, it should, so I'm not sure why you need the list in the first place.
>>
>> Also it looks like something along the lines of devres_release_all()
>> should be sufficient.
> Good suggestion, let me test this.
> 

I tried to pull the code into GED but the API is not public. I also looked
at how it is used. I was afraid to mess up with the internals of base.c by
calling devres_release_all() externally first and by the driver framework
next. I moved away from this approach.

I just fixed the function rename and changed the dev_info() to dev_dbg().

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
