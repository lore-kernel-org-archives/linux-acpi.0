From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: PNPACPI: use _CRS IRQ descriptor length for _SRS, v2
Date: Mon, 9 Jun 2008 15:02:37 -0700
Message-ID: <20080609150237.92fb06d2.akpm@linux-foundation.org>
References: <200805231629.24421.bjorn.helgaas@hp.com>
	<200805271053.59654.bjorn.helgaas@hp.com>
	<200806091251.56347.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:36270 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752169AbYFIWD2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Jun 2008 18:03:28 -0400
In-Reply-To: <200806091251.56347.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: ambx1@neo.rr.com, torvalds@linux-foundation.org, abelay@mit.edu, castet.matthieu@free.fr, shaohua.li@intel.com, lenb@kernel.org, ThJaeger@gmail.com, Robert.Moore@intel.com, linux-acpi@vger.kernel.org

On Mon, 9 Jun 2008 12:51:55 -0600
Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:

> On Tuesday 27 May 2008 10:53:58 am Bjorn Helgaas wrote:
> >     [This fixes a long-standing parport PNPACPI bug (see bugzilla
> >     links below).  I think it should go in 2.6.26.
> > 
> >     This v2 patch removes an unnecessary line pointed out by
> >     Tom Jaeger.]
> 
> This patch is in -mm, but not in 2.6.26-rc5.  I'd like suggest
> again that we put it in for 2.6.26 because it fixes parport
> on many machines.

I have it queued under "for 2.6.26, should go via Len's tree".  There
are in fact three such patches:

pnpacpi-fix-irq-flag-decoding.patch
pnpacpi-fix-irq-flag-decoding-comment-fix.patch
pnpacpi-fix-shareable-irq-encode-decode.patch
pnpacpi-use-_crs-irq-descriptor-length-for-_srs-v2.patch

Len, what would you prefer happen to these?

I'm planning on doing a maintainer-bombing later in the day.
