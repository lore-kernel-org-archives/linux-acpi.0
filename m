From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 3/3] ACPI autoloading - Create __mod_acpi_device_table symbol for all acpi drivers.
Date: Tue, 3 Jul 2007 03:15:33 -0400
Message-ID: <200707030315.33526.lenb@kernel.org>
References: <1182112047.4204.12.camel@noname> <20070620170617.GA3226@inferi.kami.home> <1182361643.28514.708.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:45751 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756013AbXGCHPw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 3 Jul 2007 03:15:52 -0400
In-Reply-To: <1182361643.28514.708.camel@queen.suse.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trenn@suse.de
Cc: Mattia Dongili <malattia@linux.it>, linux-kernel <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, acpi4asus-user <acpi4asus-user@lists.sourceforge.net>


> BTW: I also saw a laptop (IIRC it was a sony) with asus and sony ACPI
> device.
> When both drivers got loaded things broke.
> A solution was to only let the asus driver get active if the device is
> known. Currently, not sure whether still (I sent a patch a while ago),
> the Asus driver falls back to a default ("M6N"?) configuration. IMO this
> is a bit too dangerous and instead a message like "unsupported ASUS
> model found, please send acpidump to linux-acpi@vger.kernel.org".

This is pretty scary.
Can you drop the acpidump output into a bugzilla?

thanks,
-Len
