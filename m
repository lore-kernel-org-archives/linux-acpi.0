From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [ibm-acpi-devel] [PATCH 10/10] thinkpad-acpi: sync input
 device EV_SW state directly
Date: Fri, 11 Dec 2009 13:02:13 -0200
Message-ID: <20091211150213.GA25156@khazad-dum.debian.net>
References: <1260322590-5571-11-git-send-email-hmh@hmh.eng.br>
 <200912081745.14725.dmitry.torokhov@gmail.com>
 <20091209163041.GA29575@khazad-dum.debian.net>
 <20091209172119.GB4456@core.coreip.homeip.net>
 <20091209203201.GC29575@khazad-dum.debian.net>
 <20091209205926.GD10138@core.coreip.homeip.net>
 <20091210131918.GA18283@khazad-dum.debian.net>
 <20091210185922.GD23717@core.coreip.homeip.net>
 <20091211004602.GB24245@khazad-dum.debian.net>
 <20091211075458.GB30274@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:37485 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758583AbZLKPCJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 11 Dec 2009 10:02:09 -0500
Content-Disposition: inline
In-Reply-To: <20091211075458.GB30274@core.coreip.homeip.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-acpi@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>, Len Brown <lenb@kernel.org>, Alan Jenkins <alan-jenkins@tuffmail.co.uk>, ibm-acpi-devel@lists.sourceforge.net

On Thu, 10 Dec 2009, Dmitry Torokhov wrote:
> > > > The only other event that needs initialization are the switches, so I'd
> > > > argue that we might as well use my proposed patch, which is specific and
> > > > more lightweight, and convert the in-tree drivers to it.  A few might be
> > > > missing the before-registering input_event...
> > > 
> > > As I think about it even more I think we should leave it asd is. You
> > 
> > It needs to be documented somewhere, at least.
> 
> Something like the patch below?

ACK.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
