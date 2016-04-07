From: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH 2/2] pci, acpi: free IO resource during shutdown
Date: Thu, 7 Apr 2016 13:45:19 -0400
Message-ID: <57069CAF.8090803@codeaurora.org>
References: <1457389310-3538-1-git-send-email-okaya@codeaurora.org>
 <1457389310-3538-2-git-send-email-okaya@codeaurora.org>
 <20160407160624.GB8780@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20160407160624.GB8780@localhost>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, timur@codeaurora.org, cov@codeaurora.org, jcm@redhat.com, agross@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On 4/7/2016 12:06 PM, Bjorn Helgaas wrote:
>> __release_pci_root_info function if the region type is IO.
> I don't know what "removing a slot" means.  You're changing
> pci_root.c, so I assume this is really an ACPI host bridge removal?
> 

Correct, I'm removing the host bridge.

> The release should correspond to a mapping, and the changelog should
> point out where that mapping happens so we can see the symmetry.
> 

I apologize. This is based on Tomasz's v5 patch here.

https://github.com/semihalf-nowicki-tomasz/linux/blob/pci-acpi-v5/drivers/acpi/pci_root.c


> You say this is undoing the effect of pci_remap_iospace(), but that's
> only called by native drivers and the generic (OF) driver, not by
> pci_root.c.

See the ACPI root bridge driver above.

> 
> Please combine this with the previous patch so we have the new
> function and its use in the same patch.
> 

I can do that. I was trying to keep the reviews as small as possible.

-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
