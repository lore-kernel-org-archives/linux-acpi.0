From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] ACPI video: fix a poor error message
Date: Tue, 17 Aug 2010 16:27:55 +0100
Message-ID: <20100817152755.GA25805@srcf.ucam.org>
References: <1282012975.5181.16.camel@rui> <20100817133458.GA22699@srcf.ucam.org> <4911F71203A09E4D9981D27F9D830858AE61F464@orsmsx503.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:46763 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753860Ab0HQP2F (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Aug 2010 11:28:05 -0400
Content-Disposition: inline
In-Reply-To: <4911F71203A09E4D9981D27F9D830858AE61F464@orsmsx503.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, "Brown, Len" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Thomas Renninger <trenn@suse.de>

On Tue, Aug 17, 2010 at 08:24:25AM -0700, Moore, Robert wrote:
> Do we agree that the original message is unclear?
> 
> I'm not even sure that ACPI requires this method.

Indeed, it's not actually on the list of required methods.

> Perhaps the message should describe what won't happen because of the missing _BQC method.

Perhaps just "No _BQC method: Unable to determine initial brightness"?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
