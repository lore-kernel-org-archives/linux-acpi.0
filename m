From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH 2/2] gpio / ACPI: add support for GPIO operation regions
Date: Mon, 16 Sep 2013 23:35:56 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E8802463D85@SHSMSX101.ccr.corp.intel.com>
References: <1379085280-2211-1-git-send-email-mika.westerberg@linux.intel.com>
 <1379085280-2211-2-git-send-email-mika.westerberg@linux.intel.com>
 <1AE640813FDE7649BE1B193DEA596E880246367A@SHSMSX101.ccr.corp.intel.com>
 <20130915065151.GK7393@intel.com>
 <1AE640813FDE7649BE1B193DEA596E88024639E4@SHSMSX101.ccr.corp.intel.com>
 <1AE640813FDE7649BE1B193DEA596E8802463A46@SHSMSX101.ccr.corp.intel.com>
 <20130916081048.GM7393@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:12611 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751352Ab3IPXgB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Sep 2013 19:36:01 -0400
In-Reply-To: <20130916081048.GM7393@intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Mathias Nyman <mathias.nyman@linux.intel.com>, Grant Likely <grant.likely@secretlab.ca>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

> From: Mika Westerberg [mailto:mika.westerberg@linux.intel.com]
> Sent: Monday, September 16, 2013 4:11 PM
> 
> On Mon, Sep 16, 2013 at 01:21:53AM +0000, Zheng, Lv wrote:
> > > A pseudo device may be created to access the GPIO operation region fields provided by one GPIO device.
> > > The pseudo device may have other functions to access other GPIO operation region fields provided by other GPIO devices, or even worse
> to
> > > access other ACPI provided value-adds.
> > > So hierarchically the pseudo device only requires CPU, thus should not be under the GPIO device, which means the GPIO operation
> regions
> > > have nothing to do with the GPIO devices' ACPI handle.
> >
> > Sorry for the wording.
> > It's better to say the GPIO operation region users haven't strict
> > relationship to the GPIO operation region providers.
> > As the installation is to provide GPIO operation regions to the users, it
> > shouldn't relate to the providers' ACPI handle.
> 
> If I understand you correctly you mean that there might be multiple users
> (different devices) for the same GPIO operation region, right?

No, this is not what I meant.
Can one vendor device uses two or more GPIO pins from different GPIO ports?

> That shouldn't be a problem as far as I can tell.
> 
> What comes to the hierarchy you refer, I'm not sure if that is a problem
> either (unless I'm missing something). The GPIO can be used anywhere in the
> ASL, it doesn't have to be descendant of the GPIO device. You only need to
> do something like this:
> 
> 	// Assert the GPIO
> 	Store(1, \_SB.PCI0.SHD3)
> 
> In other words, use the fully qualified name.

Yes, which means this line of code can be everywhere in the namespace.
It is not required to be under one particular GPIO device as long as there is an operation region defined in that scope.

The problem is the installation, the first parameter for acpi_install_address_space_handler() is a namespace node, the function will call _REG for all OperationRegions below the scope whose top most node is the specified node.
The nodes out of this scope are not affected.  So if an OperationRegion is defined out of this scope, problem happens.

> Typically when the GPIO device _REG() is called it sets some variable like
> AVBL to true which is then checked in the code that uses the GPIO:
> 
> 	If (LEqual (\_SB.PCI0.GPO0.AVBL, One))
> 	{
> 		Store (Zero, \_SB.PCI0..SHD3)
> 	}
> 
> So if there is no driver, this part of the code is never called.

This can trigger exceptions, which can be used to load the GPIO driver.
This seems to be another topic.

Thanks and best regards
-Lv
