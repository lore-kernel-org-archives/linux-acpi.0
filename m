From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Subject: Re: [PATCH V6 00/13] Support for generic ACPI based PCI host
 controller
Date: Fri, 22 Apr 2016 15:46:24 -0500
Message-ID: <571A8DA0.3080609@amd.com>
References: <1460740008-19489-1-git-send-email-tn@semihalf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1460740008-19489-1-git-send-email-tn@semihalf.com>
Sender: linux-pci-owner@vger.kernel.org
To: Tomasz Nowicki <tn@semihalf.com>, helgaas@kernel.org, arnd@arndb.de, will.deacon@arm.com, catalin.marinas@arm.com, rafael@kernel.org, hanjun.guo@linaro.org, Lorenzo.Pieralisi@arm.com, okaya@codeaurora.org, jiang.liu@linux.intel.com, jchandra@broadcom.com
Cc: robert.richter@caviumnetworks.com, mw@semihalf.com, Liviu.Dudau@arm.com, ddaney@caviumnetworks.com, wangyijing@huawei.com, msalter@redhat.com, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, jcm@redhat.com
List-Id: linux-acpi@vger.kernel.org

On 04/15/2016 12:06 PM, Tomasz Nowicki wrote:
>  From the functionality point of view this series might be split into the
> following logic parts:
> 1. Necessary fixes as the preparation for using driver on ARM64.
> 2. New ECAM API and update for users of the pci-host-common API
> 3. Use new MCFG interface and implement generic ACPI based PCI host controller driver.
> 4. Enable above driver on ARM64
>
> Patches has been built on top of 4.6-rc2 and can be found here:
> git@github.com:semihalf-nowicki-tomasz/linux.git (pci-acpi-v6)
>
> This has been tested on Cavium ThunderX server. Any help in reviewing and
> testing is very appreciated.

For the whole series (On AMD Seattle):

Tested-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Thanks,
Suravee
