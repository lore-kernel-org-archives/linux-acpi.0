From: Len Brown <lenb@kernel.org>
Subject: Re: acpi git versus x86_64 tree
Date: Fri, 15 Dec 2006 01:01:40 -0500
Message-ID: <200612150101.41044.lenb@kernel.org>
References: <20061214153750.b70744ad.akpm@osdl.org> <200612142154.41632.lenb@kernel.org> <20061214191338.946a056a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:57240 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750857AbWLOGCS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 15 Dec 2006 01:02:18 -0500
In-Reply-To: <20061214191338.946a056a.akpm@osdl.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@suse.de>, linux-acpi@vger.kernel.org

> When will it be sent to Linus?
>
> I cannot feasibly carry this work, the outstanding x86_64 work, the
> outstanding i386 work and the outstanding ACPI work in -mm.
>
> As the acpi patch is the one which has disrupted the other trees I dropped
> that, so what little bit of testing gets donw in -mm won't be available.

Until the ACPICA update can survive for a few rounds of -mm
with no regressions reported, I'm not going to send it to Linus.

So removing it from -mm in favor of Andi's patches that may
be up-stream bound shortly was the right decision.

> > Nearly all of this series has been in -mm before.
> > 
> > I do regret that there are more variable re-names and whitespace
> > cleanups in this batch than I'd prefer -- seems there is never
> > a good time to do those...
> 
> There are ways of doing these things which don't cause such breakage. 
> Whitespace cleanups go to the subsystem maintainer and NOT in the ACPI
> tree.  For renames, you can add back-compat defines in the acpi headers,
> send that and the rename patch to the subsytem maintainer and when it's all
> merged up, remove the back-compat stuff.  

Agreed.
Perhaps in January some re-write can be done to make the series smaller.

For now I will remove the ACPICA update from my test branch
so that it doesn't block the unrelated patches that should go up now.
The ACPICA update will still be available on a dedicated acpica branch.

thanks,
-Len




