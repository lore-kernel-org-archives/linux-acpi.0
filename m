From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH] Panasonic Let's Note laptop extras driver
Date: Fri, 4 Jul 2008 08:55:57 -0300
Message-ID: <20080704115557.GB7435@khazad-dum.debian.net>
References: <20080702090044.GB12272@prithivi.gnumonks.org> <20080702101919.GB699@srcf.ucam.org> <20080703165219.GE4172@prithivi.gnumonks.org> <20080703170857.GA30135@srcf.ucam.org> <20080704031404.GC31908@khazad-dum.debian.net> <20080704044317.GH4381@prithivi.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:43551 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752600AbYGDL4D (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Jul 2008 07:56:03 -0400
Content-Disposition: inline
In-Reply-To: <20080704044317.GH4381@prithivi.gnumonks.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Harald Welte <laforge@gnumonks.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org, Hiroshi Miura <miura@da-cha.org>, hadi@cyberus.ca

On Fri, 04 Jul 2008, Harald Welte wrote:
> > Once bitten, twice shy.  I understand these buttons in the Panasonic Let's
> > Note do NOTHING in firmware/hardware (i.e. if you don't hook something to
> > them, brightness is NOT changed)?
> 
> no, they don't do anything in firmware/hardware.  They just generate
> events, and the OS/driver need to take care of any action to perform.

Ah, good.  That's much easier to deal with, yes.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
