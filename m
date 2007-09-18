From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: git-acpi breaks resume-from-ram on the Vaio
Date: Tue, 18 Sep 2007 13:25:11 -0700
Message-ID: <20070918132511.ff9c0e14.akpm@linux-foundation.org>
References: <20070917211213.8e0372d6.akpm@linux-foundation.org>
	<200709181121.41368.lenb@kernel.org>
	<20070918100718.3d510356.akpm@linux-foundation.org>
	<200709181558.19063.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:36734 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753862AbXIRU0B (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 18 Sep 2007 16:26:01 -0400
In-Reply-To: <200709181558.19063.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>

On Tue, 18 Sep 2007 15:58:18 -0400
Len Brown <lenb@kernel.org> wrote:

> On Tuesday 18 September 2007 13:07, Andrew Morton wrote:
> 
> > This breakage in git-acpi is new, I think.  Four or five days ago, git-acpi
> > _fixed_ suspend/resume on Linus's tree.  Now it breaks it.
> > 
> > But I don't think there have been changes in got-acpi since then, so
> > perhaps the breakage is due to interaction with Thomas's recent merge.
> 
> hmmm, maybe.
> 
> Perhaps if you are including sony-laptop, you can try excluding it --
> since these reverse engineered things are always fraught with peril....
> 
> I think the next thing to test is to revert cpuidle --
> let me make sure that my cpuidle branch produces a patch
> that will revert cleanly...
> 

ho hum.

I still have the git-acpi tree as a quilt series so this
evening I'll bisect these two failures down to a
particular git commit.
