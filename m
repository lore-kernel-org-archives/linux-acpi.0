From: Thomas Renninger <trenn@suse.de>
Subject: Re: [RESEND] [PATCH 2/3] Introduce acpi_root_table=rsdt boot param and dmi list to force rsdt
Date: Tue, 21 Oct 2008 15:34:42 +0200
Message-ID: <200810211534.44226.trenn@suse.de>
References: <200810192350.57993.trenn@suse.de> <200810211505.34657.trenn@suse.de> <20081021130836.GA28154@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns1.suse.de ([195.135.220.2]:56703 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750916AbYJUNeq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 21 Oct 2008 09:34:46 -0400
In-Reply-To: <20081021130836.GA28154@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Zhao Yakui <yakui.zhao@intel.com>, me@markdoughty.co.uk, linux-thinkpad <linux-thinkpad@linux-thinkpad.org>, "devel@acpica.org" <devel@acpica.org>

On Tuesday 21 October 2008 15:08:36 Matthew Garrett wrote:
> On Tue, Oct 21, 2008 at 03:05:33PM +0200, Thomas Renninger wrote:
> > Even if this is not proven, the patchset should still go in to get the
> > machines fixed for now and to easily test others, there was enough
> > discussion around it.
>
> What do you mean, "fixed"? They all already work, even if it's in a
> suboptimal way.

If C-states don't work and do work with a patch. I call the patch a fix.
I also call the machine broken (even if it does boot) before and fixed 
afterwards.
I also call a machine broken which takes minutes to boot and fixed as soon as 
the problem is solved and the machine is booting in a reasonable amount of 
time.

   Thomas
