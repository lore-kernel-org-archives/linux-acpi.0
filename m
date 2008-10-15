From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] ACPI suspend: Blacklist HP xw4600 Workstation for old code ordering
Date: Wed, 15 Oct 2008 09:58:09 +0100
Message-ID: <20081015085809.GA1061@srcf.ucam.org>
References: <200810142254.07024.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:46810 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751030AbYJOI6V (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Oct 2008 04:58:21 -0400
Content-Disposition: inline
In-Reply-To: <200810142254.07024.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, John Brown <john.brown3@hp.com>

On Tue, Oct 14, 2008 at 10:54:06PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> ACPI suspend: Blacklist HP xw4600 Workstation for old code ordering
> 
> HP xw4600 Workstation is known to require the "old" (ie. compatible
> with ACPI 1.0) suspend code ordering, so blacklist it for this
> purpose.

This doesn't seem to be scaling especially well. The xw4600 is a new 
machine, so if it needs the "old" code ordering then that's a strong 
indication that we're doing something wrong. I think trying to work out 
what would be more useful than just adding it to a blacklist.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
