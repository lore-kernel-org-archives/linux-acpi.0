From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [Patch v6 6/7] x86/PCI/ACPI: Use common interface to support
 PCI host bridge
Date: Wed, 07 Oct 2015 16:52:55 +0800
Message-ID: <5614DD67.4070801@linaro.org>
References: <1442218057-4355-1-git-send-email-jiang.liu@linux.intel.com> <1442218057-4355-7-git-send-email-jiang.liu@linux.intel.com> <20151006180144.GC29420@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151006180144.GC29420@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Helgaas <helgaas@kernel.org>, Jiang Liu <jiang.liu@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On 10/07/2015 02:01 AM, Bjorn Helgaas wrote:
> On Mon, Sep 14, 2015 at 04:07:35PM +0800, Jiang Liu wrote:
>> Use common interface to simplify ACPI PCI host bridge implementation.
>>
>> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
>> Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>
>
> Is there a corresponding ia64 patch?  If we're really consolidating
> this code (which I completely support), we need to do the whole job.

Yes, there is a patch for it:

[Patch v6 7/7] ia64/PCI/ACPI: Use common interface to support PCI host 
bridge

which has lots of code simplification [1],

  arch/ia64/pci/pci.c |  232 
++++++++++-----------------------------------------
  1 file changed, 46 insertions(+), 186 deletions(-)

[1]: https://lkml.org/lkml/2015/9/14/84

Thanks
Hanjun
