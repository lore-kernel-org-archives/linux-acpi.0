From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] : ACPI : Use RSDT instead of XSDT by adding boot option of "acpi=rsdt"
Date: Mon, 12 Jan 2009 14:16:55 +0000
Message-ID: <20090112141655.GA21052@srcf.ucam.org>
References: <20081031184233.8588.42241.stgit@thinkpad> <200901091316.16334.trenn@suse.de> <20090109123416.GA31003@srcf.ucam.org> <200901121513.06126.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:50060 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751674AbZALORG (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Mon, 12 Jan 2009 09:17:06 -0500
Content-Disposition: inline
In-Reply-To: <200901121513.06126.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Len Brown <lenb@kernel.org>, Zhao Yakui <yakui.zhao@intel.com>, "Linux-acpi@vger.kernel.org" <Linux-acpi@vger.kernel.org>, me@markdoughty.co.uk, ibm-acpi-devel@lists.sourceforge.net

On Mon, Jan 12, 2009 at 03:13:04PM +0100, Thomas Renninger wrote:
> On Friday 09 January 2009 13:34:16 Matthew Garrett wrote:
> > If you know of any machines that behave this way, I'd be
> > impressed - and it'll be far easier to dmi whitelist them than the other
> > way around.
> What do you mean with "easy"?
> 
> 99.998% of all machines work fine with the current, spec conform 
> implementation.
> There are the two ThinkPads for which the vendor admitted that the BIOS is 
> broken which work better with the rsdt blacklisted.

Two Thinkpads, an entire range of HP workstations, how many others? We 
have no idea which bugs are being triggered by this. Refusing to fix it 
because we'll potentially break some machines that may not even exist is 
not a sensible plan.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
