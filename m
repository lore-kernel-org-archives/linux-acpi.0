From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] sony-laptop: support rfkill via ACPI interfaces
Date: Mon, 23 Mar 2009 16:40:07 +0000
Message-ID: <20090323164007.GA27023@srcf.ucam.org>
References: <20090322231029.GC17905@kamineko.org> <20090323123030.GC11430@gamma.logic.tuwien.ac.at> <20090323130457.GA2767@kamineko.org> <20090323153259.GA31191@gamma.logic.tuwien.ac.at> <20090323154332.GA24872@srcf.ucam.org> <20090323160052.GA2525@gamma.logic.tuwien.ac.at> <20090323160944.GA25882@srcf.ucam.org> <20090323162749.GA5463@gamma.logic.tuwien.ac.at> <20090323163056.GA26715@srcf.ucam.org> <20090323163752.GC5463@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:55064 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751283AbZCWQkO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Mar 2009 12:40:14 -0400
Content-Disposition: inline
In-Reply-To: <20090323163752.GC5463@gamma.logic.tuwien.ac.at>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Norbert Preining <preining@logic.at>
Cc: Mattia Dongili <malattia@linux.it>, Matthias Welwarsky <matze@welwarsky.de>, linux-acpi@vger.kernel.org

On Mon, Mar 23, 2009 at 05:37:52PM +0100, Norbert Preining wrote:

> for turning from on to off:
> sony-laptop: sony_acpi_notify, event: 0x93
> sony-laptop: sony_laptop_report_input_event, event not known: 147
> sony-laptop: unknown input event 93

Ok, thanks. That's sent as a separate event type, which makes this 
easier. It may need some further work to figure out whether it's going 
from on to off or off to on, but I'll see if I can figure that out.

> One more thing: Can you check the "Eject" button, I always forgot that
> one (press-release):

Is this CD eject or dock eject?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
