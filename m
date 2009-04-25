From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [stable] [PATCH 2/5] thinkpad-acpi: fix LED blinking through
	timer trigger
Date: Sat, 25 Apr 2009 01:25:55 -0300
Message-ID: <20090425042555.GD17216@khazad-dum.debian.net>
References: <1239677054-3221-1-git-send-email-hmh@hmh.eng.br> <1239677054-3221-3-git-send-email-hmh@hmh.eng.br> <20090421194426.GD30916@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:53876 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751067AbZDYE0C (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 25 Apr 2009 00:26:02 -0400
Content-Disposition: inline
In-Reply-To: <20090421194426.GD30916@hera.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Chris Wright <chrisw@sous-sol.org>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, stable@kernel.org, ibm-acpi-devel@lists.sourceforge.net

On Tue, 21 Apr 2009, Chris Wright wrote:
> * Henrique de Moraes Holschuh (hmh@hmh.eng.br) wrote:
> > The set_blink hook code in the LED subdriver would never manage to get
> > a LED to blink, and instead it would just turn it on.  The consequence
> > of this is that the "timer" trigger would not cause the LED to blink
> > if given default parameters.
> > 
> > This problem exists since 2.6.26-rc1.
> > 
> > To fix it, switch the deferred LED work handling to use the
> > thinkpad-acpi-specific LED status (off/on/blink) directly.
> > 
> > This also makes the code easier to read, and to extend later.
> > 
> > Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
> > Cc: stable@kernel.org
> 
> This is still not upstream.

It is upstream now, commit 75bd3bf2ade9d548be0d2bde60b5ee0fdce0b127.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
