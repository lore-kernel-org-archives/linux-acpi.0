From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH] ACPI: don't send netlink events for those that go into
	input layer
Date: Sat, 25 Aug 2007 02:18:22 -0300
Message-ID: <20070825051822.GF7434@khazad-dum.debian.net>
References: <1187803471.27227.7.camel@acpi-hp.sh.intel.com> <200708231430.16887.lenb@kernel.org> <20070823212255.GB17191@khazad-dum.debian.net> <200708232218.38568.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:43564 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754447AbXHYFS3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 25 Aug 2007 01:18:29 -0400
Content-Disposition: inline
In-Reply-To: <200708232218.38568.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-acpi@vger.kernel.org, astarikovskiy@suse.de

On Thu, 23 Aug 2007, Len Brown wrote:
> On Thursday 23 August 2007 17:22, Henrique de Moraes Holschuh wrote:
> > This calls for (good!) changes in thinkpad-acpi and some issues I had with
> > exactly the same problem.
> > 
> > Len, to which tree is that change targeted?  I will have to target some
> > thinkpad-acpi changes that depend on it.
> 
> Since Rui's patch is an incremental to netlink events,
> which are new in 2.6.23, I'm going to request Rui's patch
> for inclusion in 2.6.23.  I'm also going to include
> "[PATCH] ACPI: Schedule /proc/acpi/event for removal"
> with it.

Thanks. That means I should start working on the thinkpad-acpi angle, then.

I hope its thinkpad-acpi counterpart can be accepted into -rc4, it will do
away with that pesky Kconfig INPUT_ENABLE thing I had to add to get some
measure of backward compatibility when I added the input device to
thinkpad-acpi.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
