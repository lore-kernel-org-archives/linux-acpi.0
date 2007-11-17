From: Greg KH <greg@kroah.com>
Subject: Re: [stable] [Bugme-new] [Bug 9398] New: BUG: soft lockup detected
	on CPU#0!
Date: Fri, 16 Nov 2007 17:09:41 -0800
Message-ID: <20071117010941.GA13714@kroah.com>
References: <bug-9398-10286@http.bugzilla.kernel.org/> <20071116153247.b1e99f9e.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:32982 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752402AbXKQBN5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 16 Nov 2007 20:13:57 -0500
Content-Disposition: inline
In-Reply-To: <20071116153247.b1e99f9e.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: cijoml@volny.cz, linux-acpi@vger.kernel.org, stable@kernel.org, bugme-daemon@bugzilla.kernel.org

On Fri, Nov 16, 2007 at 03:32:47PM -0800, Andrew Morton wrote:
> 
> >      KernelVersion: 2.6.23.8
> > 
> > Most recent kernel where this bug did not occur: 2.6.23.0
> 
> Ow.  Are you sure?  This is a regression which was added into the 2.6.23
> stable tree?

Can you see if this shows up in 2.6.23.2 or 2.6.23.3?  Those are the
releases that did core kernel changes.
