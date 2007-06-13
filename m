From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: ACPI Exception breaking Thinkpad T43 on 2.6.22-rc
Date: Wed, 13 Jun 2007 18:18:02 -0300
Message-ID: <20070613211802.GA13329@khazad-dum.debian.net>
References: <467055B8.4080009@ens-lyon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:55441 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750946AbXFMVSI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 13 Jun 2007 17:18:08 -0400
Content-Disposition: inline
In-Reply-To: <467055B8.4080009@ens-lyon.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Brice Goglin <Brice.Goglin@ens-lyon.org>
Cc: linux-acpi@vger.kernel.org

On Wed, 13 Jun 2007, Brice Goglin wrote:
> For a couple weeks, I experienced several times the following problem
> on my Thinkpad T43. Suddenly (I have no idea how to reproduce it), 
> internal keyboard and mouse become unresponsive and Gnome ACPI applets
> complain that they cannot read events anymore.

...

> CONFIG_BLINK=m

Set the above to "n" and recompile (it is in Drivers|Misc|Keyboard blink
driver".  Does it fix things?

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
