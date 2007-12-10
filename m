From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [RFC] EC registers - Adding sysfs interface?
Date: Mon, 10 Dec 2007 18:36:12 -0200
Message-ID: <20071210203612.GB23446@khazad-dum.debian.net>
References: <200711131724.31868.carlos@strangeworlds.co.uk> <200711131903.03018.carlos@strangeworlds.co.uk> <1196267304.23251.165.camel@queen.suse.de> <200712062152.56939.lenb@kernel.org> <1197017584.28990.98.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:34728 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751540AbXLJUgS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 10 Dec 2007 15:36:18 -0500
Content-Disposition: inline
In-Reply-To: <1197017584.28990.98.camel@queen.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Len Brown <lenb@kernel.org>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Alexey Starikovskiy <astarikovskiy@suse.de>, linux-acpi@vger.kernel.org

On Fri, 07 Dec 2007, Thomas Renninger wrote:
> I see the "danger" of applications misusing this as an interface and
> implementing workarounds for unsupported ACPI parts and (this is the
> real problem) stop working on the real problems or a proper
> implementation.

Exactly.  Or causing shadow issues that are hell to debug... unless this
this EC register interface taints the kernel the first time it is used for
reads OR writes...

> Especially because this option should be compiled in e.g. OpenSUSE
> versions, for better remote debugging (comparing EC register values with
> DSDT Embedded Controller variable implementations on a related problem
> could help a lot, without the need of digging in the dark for weeks...).

If it is something you can tell users to load explictly (load the "ec_debug"
module, with the parameter "yes_dammit_do_load_it=1") or
somesuch, maybe.

> >From your comments above, I read out that you tend to accept such an
> interface as suggested by Alexey?
> Making it read-only by default, would mainly help debugging purposes and
> should avoid any workaround implementations.

Read-only is *much* better than read-write, but it is NOT completely safe.
IMO, it would still need to be something that requires the user to
explicitly enable.  It can't just sit there active by default.  It'd have to
be something through which a stray open() or stat() wouldn't cause EC I/O.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
