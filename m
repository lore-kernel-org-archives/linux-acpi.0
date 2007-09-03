From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH] ACPI: event: fix acpi_bus_generate_netlink_event call
Date: Mon, 3 Sep 2007 20:06:42 -0300
Message-ID: <20070903230642.GB3899@khazad-dum.debian.net>
References: <11887886153952-git-send-email-hmh@hmh.eng.br> <200709031659.23663.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:50164 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751130AbXICXGt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 3 Sep 2007 19:06:49 -0400
Content-Disposition: inline
In-Reply-To: <200709031659.23663.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

On Mon, 03 Sep 2007, Len Brown wrote:
> Wow, do you really build with CONFIG_NET=n,
> or did randconfig find this?

My build-it-quick config for thinkpad-acpi has CONFIG_NET=n :-)

It is not a kernel I use to test anything but straight "does it even
compile?", though...

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
