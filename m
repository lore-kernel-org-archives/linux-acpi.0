From: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH V7 00/11] Support for generic ACPI based PCI host
 controller
Date: Mon, 23 May 2016 11:36:14 -0400
Message-ID: <5743236E.6090801@codeaurora.org>
References: <1462893601-8937-1-git-send-email-tn@semihalf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:34415 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754321AbcEWPgT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 23 May 2016 11:36:19 -0400
In-Reply-To: <1462893601-8937-1-git-send-email-tn@semihalf.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tomasz Nowicki <tn@semihalf.com>, helgaas@kernel.org, arnd@arndb.de, will.deacon@arm.com, catalin.marinas@arm.com, rafael@kernel.org, hanjun.guo@linaro.org, Lorenzo.Pieralisi@arm.com, jchandra@broadcom.com
Cc: robert.richter@caviumnetworks.com, mw@semihalf.com, Liviu.Dudau@arm.com, ddaney@caviumnetworks.com, wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com, msalter@redhat.com, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, jcm@redhat.com, andrea.gallo@linaro.org, dhdang@apm.com, jeremy.linton@arm.com, liudongdong3@huawei.com, cov@codeaurora.org

On 5/10/2016 11:19 AM, Tomasz Nowicki wrote:
> From the functionality point of view this series may be split into the
> following logic parts:
> 1. New ECAM API and update for users of the pci-host-common API
> 2. Necessary fixes as the preparation for using driver on ARM64.
> 3. Use new MCFG interface and implement generic ACPI based PCI host controller driver.
> 4. Enable above driver on ARM64
> 
> Patches has been built on top of 4.6-rc7 and can be found here:
> git@github.com:semihalf-nowicki-tomasz/linux.git (pci-acpi-v7)
> 
> This has been tested on Cavium ThunderX server. Any help in reviewing and
> testing is very appreciated.
> 

Tested on Qualcomm QDF2XXX server using Mellanox CX3 and Intel e1000e adapters.

Tested-by: Sinan Kaya <okaya@codeaurora.org>



-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
