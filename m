From: Hanjun Guo <guohanjun@huawei.com>
Subject: Re: [PATCH v11 6/7] ACPI/IORT: Stub out ACS functions when CONFIG_PCI
 is not set
Date: Tue, 18 Dec 2018 15:44:23 +0800
Message-ID: <af6afa64-27b5-3947-387c-5162f190dc3f@huawei.com>
References: <20181218025606.32668-1-okaya@kernel.org>
 <20181218025606.32668-7-okaya@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181218025606.32668-7-okaya@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sinan Kaya <okaya@kernel.org>, linux-acpi@vger.kernel.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On 2018/12/18 10:56, Sinan Kaya wrote:
> Remove PCI dependent code out of iort.c when CONFIG_PCI is not defined.
> A quick search reveals the following functions:
> 1. pci_request_acs()
> 2. pci_domain_nr()
> 3. pci_is_root_bus()
> 4. to_pci_dev()
> 
> Both pci_domain_nr() and pci_is_root_bus() are defined in linux/pci.h.
> pci_domain_nr() is a stub function when CONFIG_PCI is not set and
> pci_is_root_bus() just returns a reference to a structure member which
> is still valid without CONFIG_PCI set.
> 
> to_pci_dev() is a macro that expands to container_of.
> 
> pci_request_acs() is the only code that gets pulled in from drivers/pci/*.c

Actually we have pci_for_each_dma_alias() too which is from
drivers/pci/search.c without stub function in linux/pci.h, but I
didn't get the compile error at link time, I think the compiler
just do some optimization to remove the dead code because
dev_is_pci() is obvious false.

Thanks
Hanjun
