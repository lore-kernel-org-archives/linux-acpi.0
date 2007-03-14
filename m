From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: serial port discovery on a motion computing tablet
Date: Wed, 14 Mar 2007 14:35:34 +0000
Message-ID: <20070314143534.GA2655@srcf.ucam.org>
References: <45F7688B.8000101@elevating.com> <20070314134323.GC1467@srcf.ucam.org> <45F806B1.3060807@elevating.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:59528 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161301AbXCNOf6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Mar 2007 10:35:58 -0400
Content-Disposition: inline
In-Reply-To: <45F806B1.3060807@elevating.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bret Hughes <bhughes@elevating.com>
Cc: linux-acpi@vger.kernel.org

On Wed, Mar 14, 2007 at 09:29:05AM -0500, Bret Hughes wrote:
> nothing there:
> [root@localhost serial]# ls -a /sys/bus/pnp/devices/
> .  ..

That's, uh, surprising - is CONFIG_PNPACPI set?

> Now that I am back at the office and looking at the kernel .config via 
> make xconfig I see that 8250/16550 device discovery via ACPI namespace 
> (SERIAL_8250_ACPI) is not enabled.  Is is safe to assume that it should 
> be (go ahead and groan, I probably would) anything else that should be 
> included? 

Hm. How old is this kernel? SERIAL_8250_ACPI was merged into 
SERIAL_8250_PNP a while back.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
