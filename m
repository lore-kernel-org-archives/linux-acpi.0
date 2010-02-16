From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [patch 7/7] acpi: remove old blacklist entries
Date: Tue, 16 Feb 2010 15:40:53 +0000
Message-ID: <20100216154053.GA31195@srcf.ucam.org>
References: <201002022238.o12Mbx54018702@imap1.linux-foundation.org> <alpine.LFD.2.00.1002160253470.21595@localhost.localdomain> <alpine.LFD.2.00.1002160317570.21595@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:53349 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932400Ab0BPPl1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Feb 2010 10:41:27 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1002160317570.21595@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: akpm@linux-foundation.org, linux-acpi@vger.kernel.org, arekm@maven.pl, feng.tang@intel.com, flinco@libero.it, mad_soft@inbox.ru, rjw@sisk.pl

On Tue, Feb 16, 2010 at 03:19:43AM -0500, Len Brown wrote:
> > applied to acpi-test
> 
> un-applied.
> 
> Even if deleting the blacklist entries were correct,
> which it more or less may be, the bug at hand is that
> "acpi=ht" is now broken -- whether invoked via DMI
> or cmdline; and this patch doesn't fix that.

Indeed it doesn't. But the report also noted that the system worked fine 
with acpi=force, so this is something that we should clean up regardless 
of the original bug.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
