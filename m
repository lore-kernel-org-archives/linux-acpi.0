From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [2.6 patch] proper prototype for drivers/base/init.c:driver_init()
Date: Sat, 25 Nov 2006 19:40:45 -0200
Message-ID: <20061125214045.GJ1537@khazad-dum.debian.net>
References: <20061125191645.GI3702@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:63440 "EHLO
	out2.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S967223AbWKYVkx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 25 Nov 2006 16:40:53 -0500
Content-Disposition: inline
In-Reply-To: <20061125191645.GI3702@stusta.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, ibm-acpi@hmh.eng.br, len.brown@intel.com, linux-acpi@vger.kernel.org

On Sat, 25 Nov 2006, Adrian Bunk wrote:
> It also removes a static function of the same name in 
> drivers/acpi/ibm_acpi.c to ibm_acpi_driver_init() to fix the namespace 
> collision.

I might as well fix the entire ibm-acpi driver so that it doesn't have any
more issues like this in the future.

I will prepare a patch.  I never liked namespace-pollution-prone symbols,
anyway.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
