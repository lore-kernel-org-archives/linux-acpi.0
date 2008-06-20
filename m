From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 04/70] misc,acpi,backlight: compal Laptop Extras
Date: Fri, 20 Jun 2008 18:59:45 -0300
Message-ID: <20080620215945.GA3417@khazad-dum.debian.net>
References: <087803d18fb8259cb844c075a35fb27c2d80792e.1213947349.git.len.brown@intel.com> <45fea4a84325d5724ffe480ae6f0d1658d520141.1213947349.git.len.brown@intel.com> <20080620114804.GA8637@srcf.ucam.org> <alpine.LFD.1.10.0806201449340.3027@localhost.localdomain> <20080620192636.GA15779@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:39261 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753357AbYFTV7t (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 20 Jun 2008 17:59:49 -0400
Content-Disposition: inline
In-Reply-To: <20080620192636.GA15779@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Cezary Jackiewicz <cezary.jackiewicz@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Alexey Starikovskiy <aystarik@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>

On Fri, 20 Jun 2008, Matthew Garrett wrote:
> On Fri, Jun 20, 2008 at 02:52:30PM -0400, Len Brown wrote:
> > What do you suggest for the best example of rfkill implementation
> > that should be copied here?
> 
> Either thinkpad-acpi or hp-wmi are pretty straightforward.

I haven't sent the thinkpad-acpi rfkill implementation yet.  And I have
not reviewed hp-wmi to check if it is correct.  If it uses the input
polldev, I can give you 100% assurance that it is broken.

You pretty much have to wait for my rfkill patches to get merged before
you can do something right with rfkill and stuff like thinkpad-acpi that
has read/write rfkill registers.

Anyway, if anyone wants to look at the rfkill patches and the
thinkpad-acpi rfkill implementation, which *is* straightforward like
Matthew said, please refer to the thinkpad-acpi git trees at:

git://repo.or.cz/linux-2.6/linux-acpi-2.6/ibm-acpi-2.6.git

branches devel and rfkill.

Note that both branches are in risk of being rebased/rewound, as they
are tips of stgit branches.  Get whatever you need from them, but don't
base anything on them without talking to me first.  rfkill, in
particular, will have to be rebased to the wireless-testing tree soon.

Also, if anyone wants/needs to be added to the cc list for the rfkill
stuff I am trying to get merged (e.g. because you will also need it for
your driver), drop me a note.

I am planning to submit the thinkpad-acpi rfkill conversion only after
the rfkill stuff gets merged in -next or some other tree, but real life
is getting in the way.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
