From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: 2.6.21-mm2: ACPI exception on resume
Date: Sun, 20 May 2007 00:52:59 -0300
Message-ID: <20070520035259.GA13224@khazad-dum.debian.net>
References: <20070519165738.GK11115@waste.org> <20070519204504.GA24704@khazad-dum.debian.net> <20070519223843.GN11115@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:44875 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755641AbXETDxG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 19 May 2007 23:53:06 -0400
Content-Disposition: inline
In-Reply-To: <20070519223843.GN11115@waste.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, akpm@linux-foundation.org

On Sat, 19 May 2007, Matt Mackall wrote:
> On Sat, May 19, 2007 at 05:45:04PM -0300, Henrique de Moraes Holschuh wrote:
> > On Sat, 19 May 2007, Matt Mackall wrote:
> > > usually does, then go black and the machine will become totally
> > > unresponsive, even to holding down the power button for 30+ seconds.
> > 
> > Now, that means either the BIOS or EC have been thrown out of whack,
> > otherwise one of the two would have force-powered-off the machine a bit
> > after 10s.
> > 
> > Are you using the latest BIOS and EC firmware available?
> 
> No, I've been running the same BIOS without issue for two years.

Version of BIOS and EC firmware, please?  It is in the dmidecode output.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
