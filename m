From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 3/3] ACPI autoloading - Create __mod_acpi_device_table
	symbol for all acpi drivers.
Date: Wed, 04 Jul 2007 12:17:06 +0200
Message-ID: <1183544226.16639.142.camel@queen.suse.de>
References: <1182112047.4204.12.camel@noname>
	 <20070620170617.GA3226@inferi.kami.home>
	 <1182361643.28514.708.camel@queen.suse.de>
	 <200707030315.33526.lenb@kernel.org>
	 <20070704073342.GC8338@inferi.kami.home>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:58747 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757539AbXGDKR2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 4 Jul 2007 06:17:28 -0400
In-Reply-To: <20070704073342.GC8338@inferi.kami.home>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mattia Dongili <malattia@linux.it>
Cc: Len Brown <lenb@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, acpi4asus-user <acpi4asus-user@lists.sourceforge.net>

On Wed, 2007-07-04 at 16:33 +0900, Mattia Dongili wrote:
> On Tue, Jul 03, 2007 at 03:15:33AM -0400, Len Brown wrote:
> > 
> > > BTW: I also saw a laptop (IIRC it was a sony) with asus and sony ACPI
> > > device.
> > > When both drivers got loaded things broke.
> > > A solution was to only let the asus driver get active if the device is
> > > known. Currently, not sure whether still (I sent a patch a while ago),
> > > the Asus driver falls back to a default ("M6N"?) configuration. IMO this
> > > is a bit too dangerous and instead a message like "unsupported ASUS
> > > model found, please send acpidump to linux-acpi@vger.kernel.org".
> > 
> > This is pretty scary.
> > Can you drop the acpidump output into a bugzilla?
> 
> and add myself to the cc-list?
I don't have such a machine, opening a bug does not make much sense.
Acpidump and more info is here:
https://bugzilla.novell.com/show_bug.cgi?id=166920

Thanks,

   Thomas

