From: David Brownell <david-b@pacbell.net>
Subject: Re: USB D3 vs system S3
Date: Tue, 8 Jan 2008 13:55:30 -0800
Message-ID: <200801081355.31154.david-b@pacbell.net>
References: <200801081547.00473.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp121.sbc.mail.sp1.yahoo.com ([69.147.64.94]:41154 "HELO
	smtp121.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750925AbYAHVzd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Jan 2008 16:55:33 -0500
In-Reply-To: <200801081547.00473.lenb@kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, gregkh@suse.de, linux-acpi@vger.kernel.org, Linux-pm mailing list <linux-pm@lists.osdl.org>, USB development list <linux-usb-devel@lists.sourceforge.net>

On Tuesday 08 January 2008, Len Brown wrote:
> FYI,
> I think we may have an issue here where the entire Linux suspend order
> is being proposed to change, when in fact the underlying issue
> may really be that USB is in D3 on S3 for this box when it is
> not supposed to be deeper below D1.
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=9528
> 

I still run my system with those patches to hook up PCI and USB
wakeup mechanisms to the ACPI tables.  ISTR that they got pulled
at some point because they caused some system to wake up immediately
instead of suspending ... sound familiar?

If that immediate-wake problem is now otherwise resolved, maybe it's
time to revisit the merge of those patches.  (From *LAST* January
I think, in at least one otherwise-mergeable incarnation ...)

In the absense of those patches, nothing is hooking up USB to
the relevant ACPI tables.

Want I should repost my latest version of those patches?  They
apply cleanly against RC7.

- Dave
