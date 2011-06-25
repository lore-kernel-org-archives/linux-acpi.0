From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH] PNPACPI: Register disabled resources
Date: Fri, 24 Jun 2011 23:54:19 -0300
Message-ID: <20110625025419.GB25126@khazad-dum.debian.net>
References: <4E04FB69.3000206@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:60025 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751704Ab1FYCyX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Jun 2011 22:54:23 -0400
Content-Disposition: inline
In-Reply-To: <4E04FB69.3000206@gmx.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Witold Szczeponik <Witold.Szczeponik@gmx.net>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Bjorn Helgaas <bjorn.helgaas@hp.com>

On Fri, 24 Jun 2011, Witold Szczeponik wrote:
> When parsing PnP resources, it may happen that some of these
> are disabled.  The current solution is to skip these resources
> completely - with the unfortunate side effect that they are not
> registered despite the fact that they exist, after all.  The
> downside of his is that these resources cannot be manipulated
> programatically.  The kernel's APM implementation does not suffer
> from this problem.
> 
> This patch fixes a problem with (at least) some vintage IBM
> ThinkPad 600E (and most likely also on the 600, 600X, and 770X
> which have a very similar layout) where some of its PnP devices
> support options where either an IRQ or DMA is disabled.  The
> manipulation of these resources is important because the 600E
> has very special requirements.
> 
> The patch applies the idea to register disabled resources to
> all types of resources, not just to IRQs and DMAs.

Maybe you could post to the linux-thinkpad ML a follow up, mentioning this
patch and how these thinkpad users should use it plus whatever userspace to
improve the suport for their boxes?

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
