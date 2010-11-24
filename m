From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] ACPI video: Add video_switch_key option
Date: Wed, 24 Nov 2010 15:09:03 +0000
Message-ID: <20101124150903.GB32081@srcf.ucam.org>
References: <s5hhbg7zzqi.wl%tiwai@suse.de> <s5hipznnqv4.wl%tiwai@suse.de> <20101124142618.GB30831@srcf.ucam.org> <s5hfwuqrdxs.wl%tiwai@suse.de> <20101124143517.GA31182@srcf.ucam.org> <s5hbp5erdma.wl%tiwai@suse.de> <20101124144239.GA31411@srcf.ucam.org> <s5h8w0irdaf.wl%tiwai@suse.de> <20101124145408.GA31599@srcf.ucam.org> <s5h39qqrce9.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:37123 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750811Ab0KXPJK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 24 Nov 2010 10:09:10 -0500
Content-Disposition: inline
In-Reply-To: <s5h39qqrce9.wl%tiwai@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

On Wed, Nov 24, 2010 at 04:04:30PM +0100, Takashi Iwai wrote:
> At Wed, 24 Nov 2010 14:54:08 +0000,
> Matthew Garrett wrote:
> > 
> > Ok. Can you give me an example of a model with this behaviour?
> 
> HP ProBook 6xxx, HP ProBook 4xxx, HP EliteBook, HP Compaq 65xx, HP
> Compaq 67xx, and lots of other HP laptops sold in this year.  (I have
> access to two dozen of machines here, but unfortunately official names
> are not always known.)

Can you check what _DOS is set to? I'm having a little trouble 
reproducing this here on an HP 2530p.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
