From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: ACPI Exception breaking Thinkpad T43 on 2.6.22-rc
Date: Wed, 13 Jun 2007 21:33:22 -0300
Message-ID: <20070614003322.GA26355@khazad-dum.debian.net>
References: <467055B8.4080009@ens-lyon.org> <20070613211802.GA13329@khazad-dum.debian.net> <46706080.1090607@ens-lyon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:53717 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756492AbXFNAd3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 13 Jun 2007 20:33:29 -0400
Content-Disposition: inline
In-Reply-To: <46706080.1090607@ens-lyon.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Brice Goglin <Brice.Goglin@ens-lyon.org>
Cc: linux-acpi@vger.kernel.org

On Wed, 13 Jun 2007, Brice Goglin wrote:
> Henrique de Moraes Holschuh wrote:
> >> CONFIG_BLINK=m
> >>     
> >
> > Set the above to "n" and recompile (it is in Drivers|Misc|Keyboard blink
> > driver".  Does it fix things?
> 
> Ok, I'll try that and report back. However, since blink was built as a
> module and not loaded, could it really break something?

If it was never loaded?  I don't see how it could break anything.  Are you
sure nothing loaded it behind your back?

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
