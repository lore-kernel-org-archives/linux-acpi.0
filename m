From: Jon Masters <jcm@redhat.com>
Subject: Re: [PATCHv2] PCI: QDF2432 32 bit config space accessors
Date: Thu, 1 Dec 2016 23:58:52 -0500
Message-ID: <3a386ce0-33df-fb88-33df-88b9ca8816c7@redhat.com>
References: <20160921173129.GA20006@localhost>
 <20160921223805.21652-1-cov@codeaurora.org>
 <20161031214833.GB14603@bhelgaas-glaptop.roam.corp.google.com>
 <dbf40b73baa71155f39e13d6e51073aa@codeaurora.org>
 <20161102160820.GA6568@bhelgaas-glaptop.roam.corp.google.com>
 <3fd26a0d-a5c2-c385-866e-b957dffb7dda@codeaurora.org>
 <20161103140058.GA31142@bhelgaas-glaptop.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33092 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751140AbcLBE7E (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 1 Dec 2016 23:59:04 -0500
In-Reply-To: <20161103140058.GA31142@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <helgaas@kernel.org>, Sinan Kaya <okaya@codeaurora.org>
Cc: cov@codeaurora.org, Tomasz Nowicki <tn@semihalf.com>, will.deacon@arm.com, catalin.marinas@arm.com, rafael@kernel.org, Lorenzo.Pieralisi@arm.com, arnd@arndb.de, hanjun.guo@linaro.org, jchandra@broadcom.com, dhdang@apm.com, ard.biesheuvel@linaro.org, robert.richter@caviumnetworks.com, mw@semihalf.com, Liviu.Dudau@arm.com, ddaney@caviumnetworks.com, wangyijing@huawei.com, msalter@redhat.com, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-acpi@lists.linaro.org, andrea.gallo@linaro.org, jeremy.linton@arm.com, liudongdong3@huawei.com, gabriele.paoloni@huawei.com, jhugo@codeaurora.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On 11/03/2016 10:00 AM, Bjorn Helgaas wrote:

> It turns out that we can't use the _CRS of host bridges because of the
> Producer/Consumer bit screwup [1].  So the fallback is to include the
> ECAM space in the _CRS of a PNP0C02 device.  This is what the PCI
> Firmware spec r3.0, Table 4-2, footnote 2 is talking about.
> 
> Bjorn
> 
> [1] The original ACPI spec intent was that Consumer resources would be
> space like ECAM that is consumed directly by the bridge, and Producer
> resources would be the windows forwarded down to PCI.  But BIOSes
> didn't use the Producer/Consumer bit consistently, so we have to
> assume that all resources in host bridge _CRS are windows, which
> leaves us no way to describe the Consumer resources.

Aside - and now I realize you'd called this out as recently as last
month. Alas the HPE m400 I reference on the other thread about the
APM quirks doesn't have the motherboard resource entry so we're
stuck with exactly the situation you describe above there.

Jon.

-- 
Computer Architect | Sent from my Fedora powered laptop

