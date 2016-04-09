From: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH 1/4] acpi,pci,irq: reduce resource requirements
Date: Fri, 8 Apr 2016 21:28:42 -0400
Message-ID: <57085ACA.2040108@codeaurora.org>
References: <1457484079-18202-1-git-send-email-okaya@codeaurora.org>
 <20160314185251.GA19703@localhost> <56E7211F.3070203@codeaurora.org>
 <20160314210147.GA11459@localhost> <56E73232.9030704@codeaurora.org>
 <20160315014843.GA16967@localhost> <56E7733B.4050308@codeaurora.org>
 <20160315023632.GA23940@localhost> <56E80F19.7010503@codeaurora.org>
 <56EEE925.7070202@codeaurora.org> <20160405232124.GH15353@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20160405232124.GH15353@localhost>
Sender: linux-pci-owner@vger.kernel.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-acpi@vger.kernel.org, timur@codeaurora.org, cov@codeaurora.org, linux-pci@vger.kernel.org, ravikanth.nalla@hpe.com, lenb@kernel.org, harish.k@hpe.com, ashwin.reghunandanan@hpe.com, bhelgaas@google.com, rjw@rjwysocki.net, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi Bjorn,

On 4/5/2016 7:21 PM, Bjorn Helgaas wrote:
>> I know you want to validate that all PCI interrupts are level, it looks like the code
>> > is allowing other combinations.
> It's not that we need to validate that all PCI interrupts are level.  What
> we need is to make sure all users sharing an IRQ agree on the mode.
> 

I posted v2. Let me know if the implementation feels like what you are looking for.

Sinan

-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
