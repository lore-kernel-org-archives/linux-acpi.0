From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [RESEND] [PATCH 2/3] Introduce acpi_root_table=rsdt boot param
	and dmi list to force rsdt
Date: Mon, 20 Oct 2008 13:46:28 -0200
Message-ID: <20081020154628.GB18277@khazad-dum.debian.net>
References: <200810192350.57993.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:40606 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751085AbYJTPqd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 20 Oct 2008 11:46:33 -0400
Content-Disposition: inline
In-Reply-To: <200810192350.57993.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Zhao Yakui <yakui.zhao@intel.com>, me@markdoughty.co.uk, linux-thinkpad <linux-thinkpad@linux-thinkpad.org>, Matthew Garrett <mjg59@srcf.ucam.org>, "devel@acpica.org" <devel@acpica.org>

On Sun, 19 Oct 2008, Thomas Renninger wrote:
> The rest share one BIOS and have been added in hope that this bug gets solved,
> but this is not proven:
>   T41p shutting down due to "temperature critical"
>   https://bugzilla.novell.com/show_bug.cgi?id=378327
> I saw a kind of fixed temperature offset with the exact same machine models
> and exact same BIOS. Short after cold boot the one machine showed about 15
> degree C more than the other. This looked like wrong, too high temperature
> values read from EC on the one machine. I never found out why, this could
> explain and fix it, but I did not double check.

How is using the RSDT instead of XSDT going to help with that?

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
