From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RESEND] [PATCH 2/3] Introduce acpi_root_table=rsdt boot param and dmi list to force rsdt
Date: Tue, 21 Oct 2008 16:50:30 +0100
Message-ID: <20081021155030.GA32492@srcf.ucam.org>
References: <200810192350.57993.trenn@suse.de> <200810211625.47889.rjw@sisk.pl> <20081021142956.GA29837@srcf.ucam.org> <200810211710.32384.rjw@sisk.pl> <20081021152755.GA30633@srcf.ucam.org> <20081021154615.GA21989@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:39366 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754271AbYJUPug (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 21 Oct 2008 11:50:36 -0400
Content-Disposition: inline
In-Reply-To: <20081021154615.GA21989@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Thomas Renninger <trenn@suse.de>, Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Zhao Yakui <yakui.zhao@intel.com>, me@markdoughty.co.uk, linux-thinkpad <linux-thinkpad@linux-thinkpad.org>, "devel@acpica.org" <devel@acpica.org>

On Tue, Oct 21, 2008 at 01:46:15PM -0200, Henrique de Moraes Holschuh wrote:

> This is all nice and true, HOWEVER apparently all of us lack the hardware
> and lab setup to perform the testing.   And I haven't seen anyone publish
> clear instructions we could ask a Vista user to do, either.

Boot Vista on R40e. If machine hangs after ACPI is brought up, Vista 
uses 64-bit addresses under all circumstances.
-- 
Matthew Garrett | mjg59@srcf.ucam.org
