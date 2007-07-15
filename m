From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [ibm-acpi-devel] ACPI: thinkpad-acpi: add input device support
	to hotkey subdriver
Date: Sun, 15 Jul 2007 17:59:34 -0300
Message-ID: <20070715205934.GF19066@khazad-dum.debian.net>
References: <11844223322928-git-send-email-hmh@hmh.eng.br> <11844223334107-git-send-email-hmh@hmh.eng.br> <20070714223144.GA25782@srcf.ucam.org> <20070715181233.GG14134@khazad-dum.debian.net> <20070715184519.GD3235@srcf.ucam.org> <20070715200338.GB19066@khazad-dum.debian.net> <20070715201201.GA5518@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:54337 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751898AbXGOU7i (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 15 Jul 2007 16:59:38 -0400
Content-Disposition: inline
In-Reply-To: <20070715201201.GA5518@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: ibm-acpi-devel@lists.sourceforge.net, Richard Hughes <hughsient@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-acpi@vger.kernel.org, lenb@kernel.org

On Sun, 15 Jul 2007, Matthew Garrett wrote:
> On Sun, Jul 15, 2007 at 05:03:38PM -0300, Henrique de Moraes Holschuh wrote:
> > I do not consider screwing up the mixer handling a harmless result.
> 
> We've shipped in this configuration for over a year. Total number of 
> bugs filed? None. It's not ideal, but it's simply not true that it 
> results in a high level of user confusion or a screwed up mixer.

Well, I got one report.

> > Until then, since the default meaning of *all* KEY_ events are active in
> > nature, I am against the idea of generating events that are to be handled in
> > a passive way, by default.
> 
> That's simply not true. Userspace already interprets the brightness keys 
> differently depending on the hardware type.

*HAL* does.  HAL is *not* all there is to userspace.  The input layer is not
an interface between the kernel and HAL, it is an interface between kernel
and userspace.

Add that knowledge to the input layer, and I will agree.  Add it to every
consumer of input events, and I will concede.  Until then, it is good that
HAL can overcome the lack of such information in the input layer, but that
doesn't make it the right way to use the input layer.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
