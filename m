From: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH V2 1/3] Revert "ACPI, PCI,
 IRQ: reduce static IRQ array size to 16"
Date: Fri, 14 Oct 2016 23:50:30 -0400
Message-ID: <44177a0c-d608-d6b8-232a-ebe244d932ee@codeaurora.org>
References: <1475615720-31047-1-git-send-email-okaya@codeaurora.org>
 <1475615720-31047-2-git-send-email-okaya@codeaurora.org>
 <20161012221357.GB15116@localhost>
 <09f93442-89c8-7b2c-467d-d29b857739ff@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <09f93442-89c8-7b2c-467d-d29b857739ff@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux@rainbow-software.org, ravikanth.nalla@hpe.com, jcm@redhat.com, timur@codeaurora.org, agross@codeaurora.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, alex.williamson@redhat.com, cov@codeaurora.org, linux-pci@vger.kernel.org, bhelgaas@google.com, wim@djo.tudelft.nl, linux-arm-msm@vger.kernel.org, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On 10/12/2016 6:46 PM, Sinan Kaya wrote:
>> Which API are you thinking about here?  pcibios_penalize_isa_irq() is
>> > called by ACPI and PNP, which should both be after ACPI is started.
> Correct, I was talking about acpi_penalize_sci_irq function here.
> 

Now that I'm looking at the code. There are two more functions that get
called before ACPI start. 

These are acpi_isa_irq_available and acpi_penalize_isa_irq functions. 
We can't rely on iterating the link list.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
