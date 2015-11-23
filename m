From: Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH 2/5] eeepc-wmi: Use acpi_dev_present
Date: Mon, 23 Nov 2015 13:00:51 -0800
Message-ID: <20151123210051.GB30134@malice.jf.intel.com>
References: <cover.1448282995.git.lukas@wunner.de>
 <bdff67293ead344ccec77f55437085561b1ad88d.1448282995.git.lukas@wunner.de>
 <20151123190413.GU7413@malice.jf.intel.com>
 <20151123195527.GA26288@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:40724 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752975AbbKWVA6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Nov 2015 16:00:58 -0500
Content-Disposition: inline
In-Reply-To: <20151123195527.GA26288@wunner.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lukas Wunner <lukas@wunner.de>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, devel@acpica.org, platform-driver-x86@vger.kernel.org, Corentin Chary <corentin.chary@gmail.com>, Mark Brown <broonie@kernel.org>

On Mon, Nov 23, 2015 at 08:55:27PM +0100, Lukas Wunner wrote:
> Hi Darren,
> 
> On Mon, Nov 23, 2015 at 11:04:13AM -0800, Darren Hart wrote:
> > On Mon, Nov 23, 2015 at 03:34:55PM +0100, Lukas Wunner wrote:
> > > Use shiny new acpi_dev_present and remove all the boilerplate to search
> > > for a particular ACPI device. No functional change.
> > 
> > You did add a pr_warn, which is technically a functional change. Did you intend
> > to leave that in?
> 
> That's not an addition of mine, I moved it from eeepc_wmi_parse_device()
> to eeepc_wmi_probe() so that everything behaves exactly as before.
> (See the deleted lines further up in the patch.)

Ah, apologies.

> 
> 
> > Rafael, I assume you will pick this up along with the acpi_dev_present ACPI
> > change if you take that. Pleaes let me know if not.
> 
> The last patch in the series concerned Intel ASoC (sound/soc/intel/)
> and the maintainer Mark Brown <broonie@kernel.org> has replied that
> "This will collide with some other work done on the Intel code in -next I
> expect, probably best to merge this via ASoC (so pulling a shared branch
> for the new API) or just wait till 4.5 to do the conversion."
> [full quote of his message as it wasn't cc: platform-driver-x86]
> 
> So I guess Mark might pull it in, haven't heard back from the ACPI
> maintainers yet.
> 

I'll defer to Rafael's preference here.

-- 
Darren Hart
Intel Open Source Technology Center
