From: Andrew Morton <akpm@osdl.org>
Subject: Re: acpi git versus x86_64 tree
Date: Thu, 14 Dec 2006 22:07:50 -0800
Message-ID: <20061214220750.7617fae3.akpm@osdl.org>
References: <20061214153750.b70744ad.akpm@osdl.org>
	<200612142154.41632.lenb@kernel.org>
	<20061214191338.946a056a.akpm@osdl.org>
	<200612150101.41044.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.25]:35456 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750875AbWLOGIa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 15 Dec 2006 01:08:30 -0500
In-Reply-To: <200612150101.41044.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Andi Kleen <ak@suse.de>, linux-acpi@vger.kernel.org

On Fri, 15 Dec 2006 01:01:40 -0500
Len Brown <lenb@kernel.org> wrote:

> > When will it be sent to Linus?
> >
> > I cannot feasibly carry this work, the outstanding x86_64 work, the
> > outstanding i386 work and the outstanding ACPI work in -mm.
> >
> > As the acpi patch is the one which has disrupted the other trees I dropped
> > that, so what little bit of testing gets donw in -mm won't be available.
> 
> Until the ACPICA update can survive for a few rounds of -mm
> with no regressions reported, I'm not going to send it to Linus.
> 
> So removing it from -mm in favor of Andi's patches that may
> be up-stream bound shortly was the right decision.

I doubt if Andi is planning on getting much of this work into 2.6.20.

> > > Nearly all of this series has been in -mm before.
> > > 
> > > I do regret that there are more variable re-names and whitespace
> > > cleanups in this batch than I'd prefer -- seems there is never
> > > a good time to do those...
> > 
> > There are ways of doing these things which don't cause such breakage. 
> > Whitespace cleanups go to the subsystem maintainer and NOT in the ACPI
> > tree.  For renames, you can add back-compat defines in the acpi headers,
> > send that and the rename patch to the subsytem maintainer and when it's all
> > merged up, remove the back-compat stuff.  
> 
> Agreed.
> Perhaps in January some re-write can be done to make the series smaller.
> 
> For now I will remove the ACPICA update from my test branch
> so that it doesn't block the unrelated patches that should go up now.
> The ACPICA update will still be available on a dedicated acpica branch.

OK, thanks.  I'll resync with gti-acpi and will go through another round of
squirting patches at everyone.

But the problem remains: there is outstanding work in ACPICA which
conflicts with outstanding x86/x86_64 work.  Once those two patchsets
finally coincide somewhere, things will blow up.  
