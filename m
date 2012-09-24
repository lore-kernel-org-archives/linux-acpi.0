From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 2/2] ACPI: Override arbitrary ACPI tables via initrd
 for debugging
Date: Mon, 24 Sep 2012 19:26:15 +0100
Message-ID: <20120924182615.GA19227@srcf.ucam.org>
References: <1348234085-39220-1-git-send-email-trenn@suse.de>
 <1348234085-39220-3-git-send-email-trenn@suse.de>
 <505DD65F.9080203@kernel.org>
 <201209230317.04050.trenn@suse.de>
 <505E8F44.9020208@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:49815 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757247Ab2IXS0c (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Sep 2012 14:26:32 -0400
Content-Disposition: inline
In-Reply-To: <505E8F44.9020208@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Thomas Renninger <trenn@suse.de>, hpa@zytor.com, initramfs@vger.kernel.org, robert.moore@intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, yinghai@kernel.org, eric.piel@tremplin-utc.net, vojcek@tlen.pl

On Sun, Sep 23, 2012 at 12:25:40AM -0400, Len Brown wrote:
> > +config ACPI_INITRD_TABLE_OVERRIDE
> > +       bool
> > +       default y
> 
> Do distros in addition to SuSE concur they want to ship this way?

We certainly don't.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
