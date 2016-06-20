From: Shanker Donthineni <shankerd@codeaurora.org>
Subject: Re: [PATCH V7 0/8] Introduce ACPI world to ITS irqchip
Date: Mon, 20 Jun 2016 12:31:43 -0500
Message-ID: <5768287F.4040503@codeaurora.org>
References: <1466420541-20101-1-git-send-email-tn@semihalf.com>
Reply-To: shankerd@codeaurora.org
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1466420541-20101-1-git-send-email-tn@semihalf.com>
Sender: linux-pci-owner@vger.kernel.org
To: Tomasz Nowicki <tn@semihalf.com>, marc.zyngier@arm.com, tglx@linutronix.de, jason@lakedaemon.net, rjw@rjwysocki.net, bhelgaas@google.com, lorenzo.pieralisi@arm.com, robert.richter@caviumnetworks.com, shijie.huang@arm.com, Suravee.Suthikulpanit@amd.com, hanjun.guo@linaro.org
Cc: al.stone@linaro.org, graeme.gregory@linaro.org, Catalin.Marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, okaya@codeaurora.org, linux-acpi@vger.kernel.org, ddaney.cavm@gmail.com, linux-pci@vger.kernel.org, mw@semihalf.com, andrea.gallo@linaro.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-acpi@vger.kernel.org

Hi Tomasz,

On 06/20/2016 06:02 AM, Tomasz Nowicki wrote:
> The series builds the PCI/MSI domain stack based on initial IORT driver
> which is added in first place. As a reference please see IORT spec:
> http://infocenter.arm.com/help/topic/com.arm.doc.den0049b/DEN0049B_IO_Rema
> pping_Table.pdf
>
> Tested on Cavium ThunderX server. The patches can be found here:
> https://github.com/semihalf-nowicki-tomasz/linux.git (its-acpi-v7)
>
>

I have tested this patchset on Qualcomm Technologies server platform 
QDF2XXX.

-- 
Shanker Donthineni
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
