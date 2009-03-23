From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] sony-laptop: support rfkill via ACPI interfaces
Date: Mon, 23 Mar 2009 00:10:47 +0000
Message-ID: <20090323001047.GA14624@srcf.ucam.org>
References: <200903211453.49039.matze@welwarsky.de> <20090322175609.GA10304@srcf.ucam.org> <20090322180321.GA10401@srcf.ucam.org> <20090322203603.GA6877@gamma.logic.tuwien.ac.at> <20090322203740.GA12285@srcf.ucam.org> <20090322220655.GA13887@gamma.logic.tuwien.ac.at> <20090322224652.GA13814@srcf.ucam.org> <20090322231029.GC17905@kamineko.org> <20090322231449.GA14166@srcf.ucam.org> <20090323000853.GA31671@kamineko.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:43197 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751972AbZCWAKx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 22 Mar 2009 20:10:53 -0400
Content-Disposition: inline
In-Reply-To: <20090323000853.GA31671@kamineko.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mattia Dongili <malattia@linux.it>
Cc: Norbert Preining <preining@logic.at>, Matthias Welwarsky <matze@welwarsky.de>, linux-acpi@vger.kernel.org

On Mon, Mar 23, 2009 at 09:08:54AM +0900, Mattia Dongili wrote:

> the problem is that the decoded keypress (after the SN07 call) generates
> duplicates, i.e.: 0x81 is fn+f1 for the 0x92 case and some "Mode" key
> for 0x9c the an SR model.
> I guess sending the whole combination as the scancode would do the trick
> (0x9c81).

Mm. That ought to work. Still, if we can get a map from the new models, 
it might not be too urgent.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
