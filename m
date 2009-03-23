From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] sony-laptop: support rfkill via ACPI interfaces
Date: Mon, 23 Mar 2009 16:30:56 +0000
Message-ID: <20090323163056.GA26715@srcf.ucam.org>
References: <20090322220655.GA13887@gamma.logic.tuwien.ac.at> <20090322224652.GA13814@srcf.ucam.org> <20090322231029.GC17905@kamineko.org> <20090323123030.GC11430@gamma.logic.tuwien.ac.at> <20090323130457.GA2767@kamineko.org> <20090323153259.GA31191@gamma.logic.tuwien.ac.at> <20090323154332.GA24872@srcf.ucam.org> <20090323160052.GA2525@gamma.logic.tuwien.ac.at> <20090323160944.GA25882@srcf.ucam.org> <20090323162749.GA5463@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:38793 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752238AbZCWQbC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Mar 2009 12:31:02 -0400
Content-Disposition: inline
In-Reply-To: <20090323162749.GA5463@gamma.logic.tuwien.ac.at>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Norbert Preining <preining@logic.at>
Cc: Mattia Dongili <malattia@linux.it>, Matthias Welwarsky <matze@welwarsky.de>, linux-acpi@vger.kernel.org

On Mon, Mar 23, 2009 at 05:27:49PM +0100, Norbert Preining wrote:

> Did I mess something up, but now I get
> 	sony-laptop: sony_acpi_notify, event: 0x20
> 	sony-laptop: sony_acpi_notify, event: 0x38
> 	sony-laptop: unknown input event 38
> for S1.

Yes, that's fine - it's just coming from 
SONYPI_EVENT_ANYBUTTON_RELEASED, which doesn't map onto an actual event. 
Can you do one last thing and (with debugging enabled) try flicking the 
rfkill switch, then let me know what event it generates?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
