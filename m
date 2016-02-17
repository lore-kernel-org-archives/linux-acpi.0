From: Jayachandran Chandrashekaran Nair
	<jayachandran.chandrashekaran@broadcom.com>
Subject: Re: [PATCH V5 07/15] pci, acpi: Provide generic way to assign bus
 domain number.
Date: Wed, 17 Feb 2016 19:14:13 +0530
Message-ID: <CAKc_7PU+i2AwOVCyW2VNt4BZCWw=KBMAbV8v9DVQ2Ess3WE=kw@mail.gmail.com>
References: <1455630825-27253-1-git-send-email-tn@semihalf.com> <1455630825-27253-8-git-send-email-tn@semihalf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455630825-27253-8-git-send-email-tn@semihalf.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomasz Nowicki <tn@semihalf.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Arnd Bergmann <arnd@arndb.de>, will.deacon@arm.com, catalin.marinas@arm.com, rafael@kernel.org, hanjun.guo@linaro.org, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, okaya@codeaurora.org, jiang.liu@linux.intel.com, Jayachandran Chandrashekaran Nair <jchandra@broadcom.com>, Stefano.Stabellini@eu.citrix.com, robert.richter@caviumnetworks.com, mw@semihalf.com, Liviu.Dudau@arm.com, ddaney@caviumnetworks.com, wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com, msalter@redhat.com, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, jcm@redhat.com
List-Id: linux-acpi@vger.kernel.org

Tomasz, Lorenzo,

On Tue, Feb 16, 2016 at 7:23 PM, Tomasz Nowicki <tn@semihalf.com> wrote:
> As we now have valid PCI host bridge device reference we can
> introduce code that is going to find its bus domain number using
> ACPI _SEG method.
>
> Note that _SEG method is optional, therefore _SEG absence means
> that all PCI buses belong to domain 0.
>
> While at it, for the sake of code clarity we put ACPI and DT domain
> assign methods into the corresponding helpers.

In my patchset, I had a slightly different and I think better approach for
this without calling the _SEG method again. Please see
http://www.spinics.net/lists/arm-kernel/msg478167.html
at the last part of http://www.spinics.net/lists/arm-kernel/msg478169.html

JC.
