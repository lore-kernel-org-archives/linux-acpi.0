From: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH V3 2/4] ACPI / bus: introduce acpi_device_get_match_data()
 function
Date: Wed, 29 Nov 2017 15:49:26 -0500
Message-ID: <7a89f75e-d740-9252-419a-58a7b26b0df2@codeaurora.org>
References: <1510281175-27173-1-git-send-email-okaya@codeaurora.org>
 <1510281175-27173-2-git-send-email-okaya@codeaurora.org>
 <31ef1ea5-ddb6-1a24-980b-7986627cfeca@codeaurora.org>
 <1605519.pfaIp4IsxJ@aspire.rjw.lan> <20171129135536.GD32417@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171129135536.GD32417@localhost>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: dmaengine@vger.kernel.org, timur@codeaurora.org, linux-arm-msm <linux-arm-msm@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, robin.murphy@arm.com, linux-kernel@vger.kernel.org, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On 11/29/2017 8:55 AM, Vinod Koul wrote:
>> While I understand that the name follows the OF convention, I have some
>> doubts on whether it is the best one.
> Perhpas acpi_get_match_data() ?

Will change as recommended unless Rafael has a better idea.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
