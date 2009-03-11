From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH]: ACPI: Add the dmi check to make
	acpi_enforce_resources strict
Date: Wed, 11 Mar 2009 10:34:45 +0800
Message-ID: <1236738885.2820.168.camel@rzhang-dt>
References: <1236687873.7060.31.camel@localhost.localdomain>
	 <20090310123950.GA30016@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:5333 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755728AbZCKCdu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 10 Mar 2009 22:33:50 -0400
In-Reply-To: <20090310123950.GA30016@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: "Zhao, Yakui" <yakui.zhao@intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Tue, 2009-03-10 at 20:39 +0800, Matthew Garrett wrote:
> On Tue, Mar 10, 2009 at 08:24:33PM +0800, yakui_zhao wrote:
> > Subject: ACPI: Add the dmi check to make acpi_enforce_resources strict
> > From: Zhao Yakui <yakui.zhao@intel.com>
> > 
> >    On some boxes the SMBus PCI controller is not hidden. The SMbus I/O port
> > will be accessed in AML code. If the i2c driver is still loaded for the SMbus
> > PCI device, there is no synchronization between OS and BIOS. And the conflict
> > will happen.
> >    So the dmi check is added so that the acpi_enforce_resources is strict when
> > the box falls into the dmi check table. In such case the i2c driver won't be
> > loaded for the SMbus pci device.
> 
> I think the only safe behaviour here is to default to strict on all 
> hardware.
> 
we've discussed this with Len,
he thinks that we should first generate a DMI patch to fix the eeepc901
regression, which can be shipped upstream soon.
then we'll cook up another patch, to set acpi_enforce_resources=strict
by default, which should be shipped to len's test tree first, and see if
there are any objections from the SMBus driver side.

Yakui will send the second patch out soon.

thanks,
rui.

