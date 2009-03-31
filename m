From: Mattia Dongili <malattia@linux.it>
Subject: Re: [PATCH 09/10] sony-laptop: use .notify method instead of
	installing handler directly
Date: Wed, 1 Apr 2009 07:58:04 +0900
Message-ID: <20090331225804.GA3919@kamineko.org>
References: <20090330174646.20905.18465.stgit@bob.kio> <20090330174854.20905.68935.stgit@bob.kio> <20090331134613.GC21985@kamineko.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static-220-247-10-204.b-man.svips.gol.ne.jp ([220.247.10.204]:42198
	"EHLO smtp.kamineko.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755704AbZCaXAJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 31 Mar 2009 19:00:09 -0400
Content-Disposition: inline
In-Reply-To: <20090331134613.GC21985@kamineko.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Len Brown <lenb@kernel.org>, Tony Vroon <tony@linx.net>, Alex Chiang <achiang@hp.com>, linux-acpi@vger.kernel.org, Carlos Corbacho <carlos@strangeworlds.co.uk>, Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, Zhao Yakui <yakui.zhao@intel.com>, Harald Welte <laforge@gnumonks.org>, Venki Pallipadi <venkatesh.pallipadi@intel.com>, Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, Matthew Garrett <mjg@redhat.com>

On Tue, Mar 31, 2009 at 10:46:13PM +0900, Mattia Dongili wrote:
> On Mon, Mar 30, 2009 at 11:48:54AM -0600, Bjorn Helgaas wrote:
> > This patch adds a .notify() method.  The presence of .notify() causes
> > Linux/ACPI to manage event handlers and notify handlers on our behalf,
> > so we don't have to install and remove them ourselves.
> > 
> > Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> > CC: Mattia Dongili <malattia@linux.it>
> 
> looks fine to me, the only thing is that the first 3 hunks may not apply
> (cleanly?) due to a few recent changes not yet in Linus tree (but in
> Len's).
> 
> Feel free to add my
> Signed-off-by: Mattia Dongili <malattia@linux.it>
yeah well, should be
Acked-by: Mattia Dongili <malattia@linux.it>
-- 
mattia
:wq!
