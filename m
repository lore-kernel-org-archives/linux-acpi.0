From: Len Brown <lenb@kernel.org>
Subject: Re: ACPI battery cleanup.
Date: Wed, 15 Aug 2007 00:44:29 -0400
Message-ID: <200708150044.29820.lenb@kernel.org>
References: <46BDBAEF.5030204@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:49686 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750784AbXHOEog (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 15 Aug 2007 00:44:36 -0400
In-Reply-To: <46BDBAEF.5030204@suse.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Saturday 11 August 2007 09:34, Alexey Starikovskiy wrote:
> Hi Len,
> 
> Here are patches to clean up ACPI battery driver. Please review and add
> to -mm series.

whelp, i got this to apply -- only problem was it added some whitespace errors.
and it built.

However, I would prefer....
More detailed check-in comments (or _any_ check-in comments for that matter)
saying what changed and why.

Series of smaller patches instead of 300-line single patches

series sent as an e-mail series, not an mbox attachment.
nobody reads mbox attachments.

I don't think these are getting the eyeballs on them that they need
because of these issues.

thanks,
-len
