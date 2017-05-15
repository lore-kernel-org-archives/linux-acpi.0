From: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH] ACPI / GED: use late init to allow other drivers init
Date: Sun, 14 May 2017 22:36:58 -0400
Message-ID: <b864973e-d52b-12f7-32b2-78ec0b132a0b@codeaurora.org>
References: <1492813704-32280-1-git-send-email-okaya@codeaurora.org>
 <1874042.5bWzSJ73x0@aspire.rjw.lan>
 <0a368676-d01a-5ac8-179d-b6e7507fd500@codeaurora.org>
 <7848366.O4PImzsRl1@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:56250 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751166AbdEOChD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 14 May 2017 22:37:03 -0400
In-Reply-To: <7848366.O4PImzsRl1@aspire.rjw.lan>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Lukas Wunner <lukas@wunner.de>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Timur Tabi <timur@codeaurora.org>, Len Brown <lenb@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Abdulhamid, Harb" <harba@codeaurora.org>

Hi Rafael,

On 5/11/2017 10:52 AM, Rafael J. Wysocki wrote:
>> OK. I'll reach out to Harb and let's see where the proposal goes. 
> It looks like this is about operation regions after all, however, so _DEP as is
> should be sufficient here.
> 
> There is some limited _DEP support in the ACPI layer, but we were missing
> a way to represent those dependencies in the driver core.
> 
> That can be done through device_link objects now, so we may be able to support
> _DEP in a more meaningful way, but the cases when _DEP is used for something
> different from operation regions in practice need to be treated with caution.
> 
> 

_DEP could certainly help here. However, _DEP doesn't answer the loose binding question.
If one driver is missing in one operating system, _GED driver will never load due 
to unsatisfied dependency. This forces us into all or none condition. We have operating
systems that we need to support and do not have vendor I2C or GPIO drivers. That's why,
we are hesitant to place _DEP into ACPI tables.

The problem is that there is no concept of per event dependency. This could have helped
us figure out if such an interrupt should be enabled or not.

Another solution for operating regions is _REG if FW wants to ignore the event during
boot. This is the one we are looking into at this moment for non-critical events. 

late_init proposed in this patch helps for built-in drivers such as GHES where we do
not want to ignore events. Since GHES is not an actual device, this has to be solved
in ACPI.


Sinan

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
