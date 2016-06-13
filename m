From: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [RFC PATCH V2 1/2] ACPI/PCI: Match PCI config space accessors
 against platfrom specific ECAM quirks
Date: Mon, 13 Jun 2016 10:02:59 -0400
Message-ID: <575EBD13.8080808@codeaurora.org>
References: <1465822923-33599-1-git-send-email-liudongdong3@huawei.com>
 <1465822923-33599-2-git-send-email-liudongdong3@huawei.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E1F782C86@lhreml507-mbx>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E1F782C86@lhreml507-mbx>
Sender: linux-kernel-owner@vger.kernel.org
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>, "liudongdong (C)" <liudongdong3@huawei.com>, "helgaas@kernel.org" <helgaas@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "will.deacon@arm.com" <will.deacon@arm.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "rafael@kernel.org" <rafael@kernel.org>, "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>, "Lorenzo.Pieralisi@arm.com" <Lorenzo.Pieralisi@arm.com>, "jchandra@broadcom.com" <jchandra@broadcom.com>, "tn@semihalf.com" <tn@semihalf.com>
Cc: "robert.richter@caviumnetworks.com" <robert.richter@caviumnetworks.com>, "mw@semihalf.com" <mw@semihalf.com>, "Liviu.Dudau@arm.com" <Liviu.Dudau@arm.com>, "ddaney@caviumnetworks.com" <ddaney@caviumnetworks.com>, Wangyijing <wangyijing@huawei.com>, "Suravee.Suthikulpanit@amd.com" <Suravee.Suthikulpanit@amd.com>, "msalter@redhat.com" <msalter@redhat.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, "jcm@redhat.com" <jcm@redhat.com>, "andrea.gallo@linaro.org" <andrea.gallo@linaro.org>, "dhdang@apm.com" <dhdang@apm.com>, "jeremy.linton@arm.com" <jeremy.linton@arm.com>, "cov@codeaurora.org" <cov@c>
List-Id: linux-acpi@vger.kernel.org

On 6/13/2016 9:54 AM, Gabriele Paoloni wrote:
> As you can see here Liudongdong has replaced oem_revision with
> oem_table_id.
> 
> Now it seems that there are some platforms that have already shipped
> using a matching based on the oem_revision (right Jon?)
> 
> However I guess that if in FW they have defined oem_table_id properly
> they should be able to use this mechanism without needing to a FW update.
> 
> Can these vendors confirm this?
> 
> Tomasz do you think this can work for Cavium Thunder?
> 
> Thanks
> 
> Gab

Why not have all three of them? 

The initial approach was OEM id and revision id. 

Jeff Hugo indicated that addition (not removing any other fields) of table id
would make more sense.

-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
