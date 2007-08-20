From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: GPE block driver
Date: Mon, 20 Aug 2007 09:03:37 -0600
Message-ID: <20070820150337.GG30019@parisc-linux.org>
References: <200708181334.42417.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:33052 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757721AbXHTPDi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 20 Aug 2007 11:03:38 -0400
Content-Disposition: inline
In-Reply-To: <200708181334.42417.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

On Sat, Aug 18, 2007 at 01:34:42PM -0400, Len Brown wrote:
> Matt,
> What shall we do with your GPE block driver patch?
> Will any systems need this?

Hi Len,

I don't work at HP any more, so I no longer have access to systems which
use this.

However, we have a horse-and-cart situation here -- if Linux doesn't
support GPE blocks, BIOS vendors won't be able to use them.  Since they
are specified in the ACPI standard, we probably *ought* to support them.

> Luming, and then Rui refreshed it a while ago.
> It could use another refresh at this point...
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=2934

I'll have to see if my new employer is willing to let me spend time on
it ;-)

-- 
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
