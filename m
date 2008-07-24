From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: git-acpi in linux-next
Date: Thu, 24 Jul 2008 14:31:45 -0300
Message-ID: <20080724173145.GC6184@khazad-dum.debian.net>
References: <20080723134643.dbf1e1a1.akpm@linux-foundation.org> <20080724101217.56f7f8f5.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:50726 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751439AbYGXRbx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 24 Jul 2008 13:31:53 -0400
Content-Disposition: inline
In-Reply-To: <20080724101217.56f7f8f5.sfr@canb.auug.org.au>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Andrew Morton <akpm@linux-foundation.org>, Andi Kleen <andi@firstfloor.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

On Thu, 24 Jul 2008, Stephen Rothwell wrote:
> On Wed, 23 Jul 2008 13:46:43 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:
> > For the past few days I've been seeing a substantial amount of material
> > in
> > git+ssh://master.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git#test
> > which is not in linux-next.
> > 
> > Is this known about and deliberate?
> 
> Noone seems capable of answering a simple question about what tree I
> should be fetching.  Len's tree (last I tried) had significant conflicts
> with what Andi put into Linus' tree.  I have asked at least twice for
> direction from the acpi folks.
> 
> I will try Len's tree again today (though the last update there is June
> 28 so I am not hopeful).

Len's tree is "deactivated" while he is on sabbatical...  I can't tell you
what tree you should merge into -next, but I can tell you Len's tree is not
it...

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
