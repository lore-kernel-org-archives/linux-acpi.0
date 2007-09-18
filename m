From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Bissecting acpi merges (was Re: git-acpi breaks resume-from-ram on
	the Vaio)
Date: Tue, 18 Sep 2007 12:47:02 -0300
Message-ID: <20070918154702.GB5655@khazad-dum.debian.net>
References: <20070917211213.8e0372d6.akpm@linux-foundation.org> <200709181121.41368.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:33990 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759215AbXIRPrH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 18 Sep 2007 11:47:07 -0400
Content-Disposition: inline
In-Reply-To: <200709181121.41368.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org

On Tue, 18 Sep 2007, Len Brown wrote:
> bisecting the acpi git three should work well, because it uses topic branches.
> This includes cpuidle.  ie.  unless the breakage is within the cpuidle branch itself,
> the whole cpuidle topic can be removed by skipping the single merge commit that
> pulls it in.

The issue I had sometimes while bissecting ACPI commits was that the topic
branches are often rooted on much earlier versions of the kernel tree.  So
you are near rcY, and suddenly you are way back to rc(Y-2) while inside one
of the ACPI merges...  depending on what happened in the large number of
non-acpi commits this reverts, that can lead to some annoyance with the
resulting kernel.

I don't recall if those were bissects of acpi-test, or of mainline though.

Maybe my git-fu is simply not up to it, and the above is not a problem for
those with better git skills.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
