From: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH V6 5/8] vfio: platform: call _RST method when using ACPI
Date: Sun, 12 Jun 2016 23:41:04 -0400
Message-ID: <575E2B50.3040000@codeaurora.org>
References: <1464472878-27176-1-git-send-email-okaya@codeaurora.org>
 <1464472878-27176-6-git-send-email-okaya@codeaurora.org>
 <CAJZ5v0iHxtL3cZVymfz0BqCGjBeBAuEyMXwj5sNBvMQQXgm8rg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0iHxtL3cZVymfz0BqCGjBeBAuEyMXwj5sNBvMQQXgm8rg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: kvm@vger.kernel.org, Timur Tabi <timur@codeaurora.org>, Christopher Covington <cov@codeaurora.org>, Jon Masters <jcm@redhat.com>, eric.auger@linaro.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Andy Gross <agross@codeaurora.org>, linux-arm-msm@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Baptiste Reynal <b.reynal@virtualopensystems.com>, Alex Williamson <alex.williamson@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On 6/8/2016 6:31 PM, Rafael J. Wysocki wrote:
> On Sun, May 29, 2016 at 12:01 AM, Sinan Kaya <okaya@codeaurora.org> wrote:
>> The device tree code checks for the presence of a reset driver and calls
>> the of_reset function pointer by looking up the reset driver as a module.
>>
>> ACPI defines _RST method to perform device level reset. After the _RST
>> method is executed, the OS can resume using the device. _RST method is
>> expected to stop DMA transfers and IRQs.
>>
>> This patch checks the presence of _RST method and calls the _RST
>> method when reset is requested.
> 

A little bit of misinformation here. The current code is checking the presence
during probe time. If the presence of _RST method is required then probe is
aborted. Otherwise, probe will complete execution.

When reset call is to be executed, presence of _RST method is no longer checked.
Instead, the method is directly called. 

I was talking about the contribution of this patch as both here. I'll clarify
the commit message. 

> You could check if _RST is present at probe time and store the ACPI
> handle of it instead of the HID pointer.
> 
> This way you wouldn't need to repeat that check every time reset is used.
> 

Based on the requirement that the code can be executed without the presence
of _RST method for development purposes, I'm hesitant to use the handle of the
reset method as a gating factor.

-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
