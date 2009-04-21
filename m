From: Chris Wright <chrisw@sous-sol.org>
Subject: Re: [stable] [PATCH 2/5] thinkpad-acpi: fix LED blinking through
	timer trigger
Date: Tue, 21 Apr 2009 19:44:26 +0000
Message-ID: <20090421194426.GD30916@hera.kernel.org>
References: <1239677054-3221-1-git-send-email-hmh@hmh.eng.br> <1239677054-3221-3-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:58592 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754753AbZDUTqB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 21 Apr 2009 15:46:01 -0400
Content-Disposition: inline
In-Reply-To: <1239677054-3221-3-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, stable@kernel.org, ibm-acpi-devel@lists.sourceforge.net

* Henrique de Moraes Holschuh (hmh@hmh.eng.br) wrote:
> The set_blink hook code in the LED subdriver would never manage to get
> a LED to blink, and instead it would just turn it on.  The consequence
> of this is that the "timer" trigger would not cause the LED to blink
> if given default parameters.
> 
> This problem exists since 2.6.26-rc1.
> 
> To fix it, switch the deferred LED work handling to use the
> thinkpad-acpi-specific LED status (off/on/blink) directly.
> 
> This also makes the code easier to read, and to extend later.
> 
> Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
> Cc: stable@kernel.org

This is still not upstream.

thanks,
-chris
