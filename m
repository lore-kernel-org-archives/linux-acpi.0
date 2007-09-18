From: Len Brown <lenb@kernel.org>
Subject: Re: Bissecting acpi merges (was Re: git-acpi breaks resume-from-ram on the Vaio)
Date: Tue, 18 Sep 2007 12:32:34 -0400
Message-ID: <200709181232.34445.lenb@kernel.org>
References: <20070917211213.8e0372d6.akpm@linux-foundation.org> <200709181121.41368.lenb@kernel.org> <20070918154702.GB5655@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:44945 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759318AbXIRQuA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 18 Sep 2007 12:50:00 -0400
In-Reply-To: <20070918154702.GB5655@khazad-dum.debian.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org

On Tuesday 18 September 2007 11:47, Henrique de Moraes Holschuh wrote:
> On Tue, 18 Sep 2007, Len Brown wrote:
> > bisecting the acpi git three should work well, because it uses topic branches.
> > This includes cpuidle.  ie.  unless the breakage is within the cpuidle branch itself,
> > the whole cpuidle topic can be removed by skipping the single merge commit that
> > pulls it in.
> 
> The issue I had sometimes while bissecting ACPI commits was that the topic
> branches are often rooted on much earlier versions of the kernel tree.  So
> you are near rcY, and suddenly you are way back to rc(Y-2) while inside one
> of the ACPI merges...  depending on what happened in the large number of
> non-acpi commits this reverts, that can lead to some annoyance with the
> resulting kernel.

yes, that can be a problem when you get pulled down into a topic branch
with an old root.  However, as the topic branches are all pulled into
they tree one after another, it should be very quick to determine which one
of them is the cause.

Topic branches with old roots are also more work for me
b/c upstream diverges and I have to repeat merges.  for this reason
I re-based the cpuidle branch a while back -- as that is by far
the oldest one.

-Len
