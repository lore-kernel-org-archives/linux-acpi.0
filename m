From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [2.6 patch] proper prototype for drivers/base/init.c:driver_init()
Date: Sat, 25 Nov 2006 20:31:28 -0200
Message-ID: <20061125223128.GN1537@khazad-dum.debian.net>
References: <20061125191645.GI3702@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:11204 "EHLO
	out2.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S967264AbWKYWbk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 25 Nov 2006 17:31:40 -0500
Content-Disposition: inline
In-Reply-To: <20061125191645.GI3702@stusta.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, len.brown@intel.com, linux-acpi@vger.kernel.org

On Sat, 25 Nov 2006, Adrian Bunk wrote:
> This patch adds a prototype for driver_init() in include/linux/device.h.
> 
> It also removes a static function of the same name in 
> drivers/acpi/ibm_acpi.c to ibm_acpi_driver_init() to fix the namespace 
> collision.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

ACK for the proposed ibm-acpi changes (I can't speak for driver_init).  A
full namespace cleanup in ibm-acpi will touch pretty much every function in
the ibm-acpi driver, so it will have to wait until a bunch of patches that I
just submitted for acpi-test are either merged or rejected.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
