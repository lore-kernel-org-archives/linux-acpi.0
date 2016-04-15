From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V6 07/13] PCI: Provide common functions for ECAM mapping
Date: Fri, 15 Apr 2016 20:41:07 +0200
Message-ID: <4434349.LMyShXzXEt@wuerfel>
References: <1460740008-19489-1-git-send-email-tn@semihalf.com> <1460740008-19489-8-git-send-email-tn@semihalf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1460740008-19489-8-git-send-email-tn@semihalf.com>
Sender: linux-pci-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Tomasz Nowicki <tn@semihalf.com>, helgaas@kernel.org, will.deacon@arm.com, catalin.marinas@arm.com, rafael@kernel.org, hanjun.guo@linaro.org, Lorenzo.Pieralisi@arm.com, okaya@codeaurora.org, jiang.liu@linux.intel.com, jchandra@broadcom.com, jcm@redhat.com, linaro-acpi@lists.linaro.org, linux-pci@vger.kernel.org, Liviu.Dudau@arm.com, ddaney@caviumnetworks.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, robert.richter@caviumnetworks.com, Suravee.Suthikulpanit@amd.com, msalter@redhat.com, wangyijing@huawei.com, mw@semihalf.com
List-Id: linux-acpi@vger.kernel.org

On Friday 15 April 2016 19:06:42 Tomasz Nowicki wrote:
> diff --git a/drivers/pci/ecam.h b/drivers/pci/ecam.h
> new file mode 100644
> index 0000000..34c0aba
> --- /dev/null
> +++ b/drivers/pci/ecam.h
> 

You are including this file from device drivers and potentially from ACPI 
code, so I think this needs to go into include/linux/pci*.h

	Arnd
