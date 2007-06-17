From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 3/3] ACPI autoloading - Create __mod_acpi_device_table symbol for all acpi drivers.
Date: Sun, 17 Jun 2007 19:49:47 -0300
Message-ID: <20070617224947.GA17951@khazad-dum.debian.net>
References: <1182111863.4204.6.camel@noname>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:33467 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752936AbXFQWtz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 17 Jun 2007 18:49:55 -0400
Content-Disposition: inline
In-Reply-To: <1182111863.4204.6.camel@noname>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Len Brown <lenb@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>

On Sun, 17 Jun 2007, Thomas Renninger wrote:
> Create __mod_acpi_device_table symbol for all acpi drivers.

thinkpad-acpi will autoload by DMI ids in 2.6.23, which is a much better
solution for model-specific drivers like thinkpad-acpi than autoloading by
HID, IMHO.

Thus, I'd prefer if your patches did not make thinkpad-acpi autoload by HID.

I will send a first batch of thinkpad-acpi changes for 2.6.23 to the list
soon, which includes the dmi autoload aliases.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
