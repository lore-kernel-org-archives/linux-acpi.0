From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 58/98] sony-laptop: Add rfkill support on new models
Date: Fri, 3 Apr 2009 18:30:50 +0100
Message-ID: <20090403173050.GA24214@srcf.ucam.org>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org> <6cc056bc31ea9910afb01adc0848bb6ae68e0205.1238214620.git.len.brown@intel.com> <200903291317.48139.matze@welwarsky.de> <alpine.LFD.2.00.0904031250010.4655@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:35322 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759234AbZDCRaz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Apr 2009 13:30:55 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0904031250010.4655@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Matthias Welwarsky <matze@welwarsky.de>, linux-acpi@vger.kernel.org

On Fri, Apr 03, 2009 at 12:52:36PM -0400, Len Brown wrote:
> On Sun, 29 Mar 2009, Matthias Welwarsky wrote:
> > Bug: If you insert the module with hardware kill switch enabled, it cannot be 
> > disabled any more, i.e. despite operating the hardware kill switch, devices 
> > will not become enabled.
> > 
> > Any hint how I could debug this?
> > 
> > regards,
> > 	matthias
> 
> Matthew,
> Should we proceed with patch 58 and fix later, or scrap patch 58?

That could have been triggered before the bugfixes to the notify handler 
- is it still a problem?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
