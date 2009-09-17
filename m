From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH] ACPI: set acpi_driver.owner in all acpi drivers
Date: Thu, 17 Sep 2009 14:10:59 -0300
Message-ID: <20090917171059.GA789@khazad-dum.debian.net>
References: <4AB0FDB7.1050204@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:50500 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752974AbZIQRK7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 17 Sep 2009 13:10:59 -0400
Content-Disposition: inline
In-Reply-To: <4AB0FDB7.1050204@tuffmail.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Cc: Len Brown <lenb@kernel.org>, linux acpi <linux-acpi@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

On Wed, 16 Sep 2009, Alan Jenkins wrote:
> The owner field provides the link between drivers and modules in sysfs,
> but no ACPI driver was setting it.
> 
> After setting the owner field we can see which module provides which
> driver and vice versa by looking at /sys/bus/acpi/driver/*/module and
> /sys/module/*/drivers/acpi:*.
> 
> Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>

For the thinkpad-acpi changes:
Acked-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
