From: Brian Gerst <bgerst@didntduck.org>
Subject: Re: [PATCH 03/04] PCI: use the MCFG table to properly access pci
 devices (x86-64)
Date: Thu, 16 Jun 2005 19:49:22 -0400
Message-ID: <42B21002.7090502@didntduck.org>
References: <20050615052916.GA23394@kroah.com> <20050615053031.GB23394@kroah.com> <20050615053120.GC23394@kroah.com> <20050615053214.GD23394@kroah.com> <20050616153404.B5337@unix-os.sc.intel.com> <20050616224223.GA13619@suse.de> <20050616230020.GM7048@bragg.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261841AbVFPXtg@vger.kernel.org>
In-Reply-To: <20050616230020.GM7048@bragg.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: Greg KH <gregkh@suse.de>, Rajesh Shah <rajesh.shah@intel.com>, len.brown@intel.com, acpi-devel@lists.sourceforge.net, linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Andi Kleen wrote:
> On Thu, Jun 16, 2005 at 03:42:23PM -0700, Greg KH wrote:
> 
>>On Thu, Jun 16, 2005 at 03:34:06PM -0700, Rajesh Shah wrote:
>>
>>>On Tue, Jun 14, 2005 at 10:32:14PM -0700, Greg KH wrote:
>>>
>>>>+	for (i = 0; i < pci_mmcfg_config_num; ++i) {
>>>>+		pci_mmcfg_virt[i].cfg = &pci_mmcfg_config[i];
>>>>+		pci_mmcfg_virt[i].virt = ioremap_nocache(pci_mmcfg_config[i].base_address, MMCONFIG_APER_SIZE);
>>>
>>>This will map 256MB for each mmcfg aperture, probably better
>>>to restrict it based on bus number range for this aperture.
>>
>>It should be 1MB per bus number, right?
> 
> 
> It shouldn't make much difference anyways - we have plenty of vmalloc
> space on x86-64

What about excess page table usage?

--
				Brian Gerst
