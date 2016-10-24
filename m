From: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH V4 1/3] ACPI, PCI, IRQ: assign ISA IRQ directly during
 early boot stages
Date: Sun, 23 Oct 2016 23:22:02 -0400
Message-ID: <98bb7d24-94db-b585-918e-04f3a64d93f0@codeaurora.org>
References: <1476915664-27231-1-git-send-email-okaya@codeaurora.org>
 <1476915664-27231-2-git-send-email-okaya@codeaurora.org>
 <20161021013930.GB31044@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161021013930.GB31044@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-acpi@vger.kernel.org, rjw@rjwysocki.net, bhelgaas@google.com, ravikanth.nalla@hpe.com, linux@rainbow-software.org, timur@codeaurora.org, cov@codeaurora.org, jcm@redhat.com, alex.williamson@redhat.com, linux-pci@vger.kernel.org, agross@codeaurora.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, wim@djo.tudelft.nl, linux-arm-kernel@lists.infradead.org, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On 10/20/2016 9:39 PM, Bjorn Helgaas wrote:
>> These API need to bypass the acpi_irq_get_penalty function.
> I don't mind this patch, but the changelog doesn't tell me what's
> broken and why we need this fix.  Apparently acpi_irq_get_penalty()
> doesn't work before ACPI is initialized, but I don't see *why* it
> wouldn't work.

I'll update the commit message as you suggested. The code doesn't work
if we apply PATCH V4 2/3 + PATCH V4 3/3 without PATCH V4 1/3 since
the caller is going to end up calling get_penalty function while ACPI
is not initialized. This happened during the debug of this regression.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
