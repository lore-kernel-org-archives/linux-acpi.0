From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] Override DSDT and SSDTs via initramfs
Date: Wed, 6 Feb 2008 21:49:30 -0500
Message-ID: <200802062149.31049.lenb@kernel.org>
References: <4798E2A5.6020804@users.sf.net> <1201714051.1222.131.camel@queen.suse.de> <47A0FBD4.6090603@tremplin-utc.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:43240 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754706AbYBGCuD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 6 Feb 2008 21:50:03 -0500
In-Reply-To: <47A0FBD4.6090603@tremplin-utc.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?utf-8?q?=C3=89ric_Piel?= <Eric.Piel@tremplin-utc.net>
Cc: trenn@suse.de, Andrew Morton <akpm@linux-foundation.org>, Philippe Coval <rzr@users.sourceforge.net>, linux-acpi@vger.kernel.org, dsdt <dsdt@gaugusch.at>


> >> Probably it is best to forward the original patch
> >> w/ proper credits, and then send updates to address 1-4.
> Thomas, the patch you have included is only the "original" patch, right? 
> We need to address the points 1-4 (which seem very reasonable) later on 
> with additional patches. I think most of them are already implemented in
> http://gaugusch.at/acpi-dsdt-initrd-patches/acpi-dsdt-initrd-v0.8.2-2.6.17-ssdt.patch
> So that should be quite easy :-)
> 
> > I do not know who initially came up with this, I just modified/adjusted
> > the patch sometimes. I expect it's Markus, possibly Eric or best both
> > who should be mentioned as author.
> Yep, to be precise, Markus Gaugusch is the original author, I'm just the 
> current maintainer, and Thomas has been very helpful for a looong time :-)

okay, i'll update the original author to be Markus Gaugusch <dsdt@gaugusch.at>

(for future reference, if you start the patch comments with a From:
 you can specific the original author as somebody else that way)

thanks,
-Len
