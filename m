From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RESEND] [PATCH 2/3] Introduce acpi_root_table=rsdt boot param and dmi list to force rsdt
Date: Tue, 21 Oct 2008 15:00:14 +0100
Message-ID: <20081021140014.GA29330@srcf.ucam.org>
References: <200810192350.57993.trenn@suse.de> <20081021130836.GA28154@srcf.ucam.org> <200810211534.44226.trenn@suse.de> <200810211601.56527.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:59801 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751347AbYJUOA2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 21 Oct 2008 10:00:28 -0400
Content-Disposition: inline
In-Reply-To: <200810211601.56527.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Thomas Renninger <trenn@suse.de>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Zhao Yakui <yakui.zhao@intel.com>, me@markdoughty.co.uk, linux-thinkpad <linux-thinkpad@linux-thinkpad.org>, "devel@acpica.org" <devel@acpica.org>

On Tue, Oct 21, 2008 at 04:01:55PM +0200, Rafael J. Wysocki wrote:

> Moreover, as soon as the real fix is developed we can remove the DMI list.
> Quite frankly, I don't see any downsides.

The downside is that with the DMI list there's significantly less 
incentive to produce a "real" fix (assuming there is one). We've no idea 
how many other systems may be affected in one way or another.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
