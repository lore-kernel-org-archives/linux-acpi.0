From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] ACPI/Battery: Add a _BIX quirk for NEC LZ750/LS
Date: Tue, 14 Jan 2014 16:04:44 +0000
Message-ID: <20140114160444.GA4307@srcf.ucam.org>
References: <1388648277-23453-1-git-send-email-tianyu.lan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:59873 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751458AbaANQFB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 14 Jan 2014 11:05:01 -0500
Content-Disposition: inline
In-Reply-To: <1388648277-23453-1-git-send-email-tianyu.lan@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: lenb@kernel.org, rjw@rjwysocki.net, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, fcr@adinet.com.uy, "3.8+" <stable@vger.kernel.org>

On Thu, Jan 02, 2014 at 03:37:57PM +0800, Lan Tianyu wrote:
> The aml method _BIX of NEC LZ750/LS returns a broken package which
> skip the first member "Revision" according ACPI 5.0 spec Table 10-234.

Why don't we just ignore an invalid _BIX and fall back to _BIF? That 
seems more reasonable than setting a precedent for fixing up invalid 
data.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
