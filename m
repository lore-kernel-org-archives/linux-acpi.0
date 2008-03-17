From: Len Brown <lenb@kernel.org>
Subject: Re: [2.6.25-rc5-mm1] BUG: spinlock bad magic early during boot
Date: Mon, 17 Mar 2008 13:59:30 -0400
Message-ID: <200803171359.31298.lenb@kernel.org>
References: <20080311011434.ad8c8d7d.akpm@linux-foundation.org> <47DC26BC.7060502@tremplin-utc.net> <alpine.LFD.1.00.0803151315250.3020@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:45608 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751230AbYCQSAe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 17 Mar 2008 14:00:34 -0400
In-Reply-To: <alpine.LFD.1.00.0803151315250.3020@woody.linux-foundation.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Eric Piel <Eric.Piel@tremplin-utc.net>, Tilman Schmidt <tilman@imap.cc>, Dave Hansen <haveblue@us.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Thomas Renninger <trenn@suse.de>, Christoph Hellwig <hch@infradead.org>, Markus Gaugusch <dsdt@gaugusch.at>, linux-acpi@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, Arjan van de Ven <arjanv@redhat.com>


> For things like DVD install images, you'd quite possibly want to have a 
> few known-workaround DSDT images with the installer, and just say "ok, we 
> want to fix up this ACPI crap in order to get working suspend/resume" kind 
> of thing.

For a Linux distro to ship DSDT override images, they'd have to
have some licensing & support arrangement with the OEM
who actually owns that BIOS code.

While this wouldn't defy any laws of physics, it doesn't
look compatible with current industry business practices.

OEMs are more likely to simply ship a BIOS update ISO.

-Len

