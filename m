From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] sony-laptop: support rfkill via ACPI interfaces
Date: Sun, 22 Mar 2009 23:14:49 +0000
Message-ID: <20090322231449.GA14166@srcf.ucam.org>
References: <20090320011837.GA23183@gamma.logic.tuwien.ac.at> <200903211222.36642.matze@welwarsky.de> <200903211453.49039.matze@welwarsky.de> <20090322175609.GA10304@srcf.ucam.org> <20090322180321.GA10401@srcf.ucam.org> <20090322203603.GA6877@gamma.logic.tuwien.ac.at> <20090322203740.GA12285@srcf.ucam.org> <20090322220655.GA13887@gamma.logic.tuwien.ac.at> <20090322224652.GA13814@srcf.ucam.org> <20090322231029.GC17905@kamineko.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:60210 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756498AbZCVXOy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 22 Mar 2009 19:14:54 -0400
Content-Disposition: inline
In-Reply-To: <20090322231029.GC17905@kamineko.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mattia Dongili <malattia@linux.it>
Cc: Norbert Preining <preining@logic.at>, Matthias Welwarsky <matze@welwarsky.de>, linux-acpi@vger.kernel.org

On Mon, Mar 23, 2009 at 08:10:30AM +0900, Mattia Dongili wrote:
> On Sun, Mar 22, 2009 at 10:46:52PM +0000, Matthew Garrett wrote:
> > Ok, sounds like the mapping needs to be changed. Can you let me know 
> > which ACPI events are generated for each key?
> 
> Yes it does.
> A vaio SR user sent me this list for 0x9c that after a call to SN07(202)
> becomes:

0x9c as well? Interesting. Easy enough to generalise that code, I guess. 
If we don't have a match, maybe we should just send the scancode with 
KEY_UNKNOWN and let hal remap them?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
