From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH] Panasonic Let's Note laptop extras driver
Date: Fri, 4 Jul 2008 00:14:04 -0300
Message-ID: <20080704031404.GC31908@khazad-dum.debian.net>
References: <20080702090044.GB12272@prithivi.gnumonks.org> <20080702101919.GB699@srcf.ucam.org> <20080703165219.GE4172@prithivi.gnumonks.org> <20080703170857.GA30135@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:33099 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755067AbYGDDOL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Jul 2008 23:14:11 -0400
Content-Disposition: inline
In-Reply-To: <20080703170857.GA30135@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Harald Welte <laforge@gnumonks.org>, linux-acpi@vger.kernel.org, Hiroshi Miura <miura@da-cha.org>, hadi@cyberus.ca

On Thu, 03 Jul 2008, Matthew Garrett wrote:
> On Fri, Jul 04, 2008 at 12:52:19AM +0800, Harald Welte wrote:
> > So I vote for keeping those events in the driver - just as long as there
> > is no new standard mechanism for signalling brightness up/down button
> > events to userspace.
> 
> There is - they should just be sent as KEY_BRIGHTNESSUP and 
> KEY_BRIGHTNESSDOWN.

Once bitten, twice shy.  I understand these buttons in the Panasonic Let's
Note do NOTHING in firmware/hardware (i.e. if you don't hook something to
them, brightness is NOT changed)?

Because if they DO anything else than just staying there prettly and telling
you they have been pressed, then you are **NOT** to issue
KEY_BRIGHTNESSUP/DOWN.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
