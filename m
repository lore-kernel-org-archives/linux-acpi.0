From: Andrew Patterson <andrew.patterson@hp.com>
Subject: Re: [PATCH v2 0/6] call _OSC support during root bridge discovery
Date: Fri, 31 Oct 2008 10:28:58 -0600
Message-ID: <1225470538.9325.3.camel@boris.fwe.com>
References: <20081030052746.10259.22045.stgit@bob.kio>
	 <4909798F.6010604@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <4909798F.6010604@jp.fujitsu.com>
Sender: linux-pci-owner@vger.kernel.org
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, matthew@wil.cx, bjorn.helgaas@hp.com
List-Id: linux-acpi@vger.kernel.org

On Thu, 2008-10-30 at 18:08 +0900, Kenji Kaneshige wrote:
> Andrew Patterson wrote:
> > This is v2 of the "call _OSC support during root bridge discovery"
> > patchset.  At Bjorn Helgaas's suggestion, I have merged all the MSI
> > handling patches into one patch. Kenji Kaneshige also noted that I was
> > not checking aspm_disabled before setting ASPM _OSC capabilities. This
> > has been fixed.
> > 
> > Kenji also noted that the pci_msi_enable can be changed in various
> > quirks after root bridge discovery, resulting in the incorrect setting
> > of the MSI _OSC capability. I do not yet have a solution for this problem.
> > 
> 
> Unfortunately, I don't have good idea about it yet too. In addition,
> I don't understand how to handle the case if a feature is supported
> but disabled by OS, from the PCI firmware spec.


> If we should not set _OSC capabilities when it is supported but
> disabled by OS, maybe we need also consider what we should do for
> OSC_EXT_PCI_CONFIG_SUPPORT and OSC_PCI_SEGMENT_GROUPS_SUPPORT
> if mmconfig is disabled, as well as aspm_disabled and pci_msi_enable.
> 

A good idea. I try and come up with something.

> By the way, Taku Izumi plan to post some patches to reduce _OSC
> evaluation for _OSC control soon. I'm appreciate it if you will try
> it on your big server.
> 

I would be happy to help.  Getting time on this server is sometimes
difficult, so it may take a while before I can run a test.

Andrew

> Thanks,
> Kenji Kaneshige
> 
> 

> 
