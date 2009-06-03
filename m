From: Alex Chiang <achiang@hp.com>
Subject: Re: [PATCH 00/10] Dynamic ACPI-PCI binding
Date: Wed, 3 Jun 2009 13:29:03 -0600
Message-ID: <20090603192903.GA10885@ldl.fc.hp.com>
References: <20090602152351.7346.48697.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20090602152351.7346.48697.stgit@bob.kio>
Sender: linux-pci-owner@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi Len,

* Alex Chiang <achiang@hp.com>:
> This patch series eliminates static boot-time binding of ACPI
> and PCI devices, and introduces an API to perform this lookup
> during runtime.
> 
> This change has the following advantages:
> 
> 	- eliminates struct acpi_device vs struct pci_dev lifetime issues
> 	- lays groundwork for eliminating .bind/.unbind from acpi_device_ops
> 	- lays more groundwork for eliminating .start from acpi_device_ops
> 	  and thus simplifying ACPI drivers
> 	- whacks out a lot of code
> 
> This patchset is based on lenb/test (66c74fa1d4).

I'm going to address Bjorn's comments and respin this series.

Thanks.

/ac
