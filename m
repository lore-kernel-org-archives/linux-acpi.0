From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: another discrete nvidia switch on/off for an assortment of
	laptops
Date: Wed, 6 Jan 2010 14:33:15 +0000
Message-ID: <20100106143315.GA13984@srcf.ucam.org>
References: <358f4d650912291430u5e266764jd98a814621659c1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:46375 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755767Ab0AFOdW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Jan 2010 09:33:22 -0500
Content-Disposition: inline
In-Reply-To: <358f4d650912291430u5e266764jd98a814621659c1@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Albert Vilella <avilella@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Tue, Dec 29, 2009 at 10:30:47PM +0000, Albert Vilella wrote:
> Hi again,
> 
> In this occasion not providing a working module, but just a grep to
> show 5 different laptop
> models that use an almost identical ACPI call to report on the
> discrete nvidia graphics switch:

The NVIF interface is not the correct one to use. There's a _DSM method 
on the Nvidia PCI device that will call the appropriate methods. nouveau 
should support this in the current kernels - right now it'll just set 
the graphics to whatever state the BIOS has programmed. A module 
parameter to change the default might be interesting.

If you want to do this with the nvidia binary driver, you'll need to get 
nvidia to add support.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
