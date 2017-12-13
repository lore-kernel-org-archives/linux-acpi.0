From: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH V7 0/7] dmaengine: qcom_hidma: add support for bugfixed HW
Date: Tue, 12 Dec 2017 19:09:47 -0500
Message-ID: <0ed35958-22c9-50e5-3b6a-732821de6d20@codeaurora.org>
References: <1512681031-11343-1-git-send-email-okaya@codeaurora.org>
 <20171212053845.GB18649@localhost>
 <CAJZ5v0ijQFO_PuwhBRrKovo4EW9Dck9fiT38wiCw6P5hHUjNuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:39270 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752805AbdLMAJz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Dec 2017 19:09:55 -0500
In-Reply-To: <CAJZ5v0ijQFO_PuwhBRrKovo4EW9Dck9fiT38wiCw6P5hHUjNuw@mail.gmail.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>, Vinod Koul <vinod.koul@intel.com>
Cc: dmaengine <dmaengine@vger.kernel.org>, Timur Tabi <timur@codeaurora.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 12/12/2017 7:36 AM, Rafael J. Wysocki wrote:
> On Tue, Dec 12, 2017 at 6:38 AM, Vinod Koul <vinod.koul@intel.com> wrote:
>> On Thu, Dec 07, 2017 at 04:10:24PM -0500, Sinan Kaya wrote:
>>> Introduce new ACPI and OF device ids for thw HW along with the helper
>>> functions.
>>>
>>> Changes from v6:
>>> * add const to the device callback parameter in fwnode.
>>> * reorganize the callbacks in the code
>>> * rename get_match_data() as device_get_match_data()
>>> * place pointer checks into acpi_get_match_data()
>>
>> This fails for me at 3rd patch. I am on -rc1 is there a dependency?
> 
> There shouldn't be any.
> 
> According to git, all changes to the files touched by the [3/7] are in
> -rc1 already.
> 

Let me know if you were able to resolve the conflict. I can rebase against
a development tree if you can point me to there.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
