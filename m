From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Linux 2.6.24.1  - kernel does not boot; IRQ trouble?
Date: Tue, 26 Feb 2008 18:52:16 -0800
Message-ID: <20080226185216.f298784d.akpm@linux-foundation.org>
References: <20080226234025.GC14117@kroah.com>
	<91946.43854.qm@web52909.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([207.189.120.13]:56584 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753730AbYB0CwT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 26 Feb 2008 21:52:19 -0500
In-Reply-To: <91946.43854.qm@web52909.mail.re2.yahoo.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Chris Rankin <rankincj@yahoo.com>
Cc: Greg KH <greg@kroah.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 27 Feb 2008 00:55:38 +0000 (GMT) Chris Rankin <rankincj@yahoo.com> wrote:

> --- Greg KH <greg@kroah.com> wrote:
> > On Tue, Feb 26, 2008 at 10:36:00PM +0000, Chris Rankin wrote:
> > > FYI, this hang still exists in 2.6.24.3 and so I am still needing to boot with the acpi=noirq
> > > parameter.
> > 
> > You're going to have to refresh my memory.  Was this a problem caused by
> > the .1 .2 or .3 kernel releases?  Did 2.6.24 have this problem as well,
> > or was it ok?
> 
> It's a bug introduced in 2.6.24; that ACPI fails to allocate IRQs correctly for PCI devices, which
> makes the kernel hang at boot-time:

You reported this regression nearly a month ago and apart from me flailing
around nobody has bothered to do the slightest thing about it.

If you can identify the offending commit (see
http://www.kernel.org/doc/local/git-quick.html) we'll get it working again
and I really don't care how many commits we have to revert to do it.

