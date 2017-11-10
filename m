From: Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH V2 2/3] dmaengine: qcom_hidma: add support for the new
 revision
Date: Fri, 10 Nov 2017 08:14:00 -0600
Message-ID: <753b9001-b269-c2b8-be60-9a81f08d60c5@codeaurora.org>
References: <1510158582-5343-1-git-send-email-okaya@codeaurora.org>
 <1510158582-5343-2-git-send-email-okaya@codeaurora.org>
 <e781fe6c-a4ad-4a96-c705-dfcd9a8d10b0@arm.com>
 <3ca59a37-e8f8-a2cf-fa3a-f4ee6d544dcd@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <3ca59a37-e8f8-a2cf-fa3a-f4ee6d544dcd@codeaurora.org>
Content-Language: en-US
Sender: linux-arm-msm-owner@vger.kernel.org
To: Sinan Kaya <okaya@codeaurora.org>, Robin Murphy <robin.murphy@arm.com>, dmaengine@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-acpi@vger.kernel.org

On 11/10/2017 08:03 AM, Sinan Kaya wrote:
> I did post v3 with this approach. However, I could not really find a ACPI function that
> returns the driver data very similar to of_device_get_match_data(). The only thing
> that is closer is acpi_match_device().

This is what I do in the EMAC driver:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/ethernet/qualcomm/emac/emac-sgmii.c#n245

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
