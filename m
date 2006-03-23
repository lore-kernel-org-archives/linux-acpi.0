From: Andrew Morton <akpm@osdl.org>
Subject: Re: ACPI error in 2.6.16
Date: Wed, 22 Mar 2006 18:34:55 -0800
Message-ID: <20060322183455.32a385e5.akpm@osdl.org>
References: <200603222359.55631.biscani@pd.astro.it>
	<4421F834.1070602@liberouter.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:62084 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964897AbWCWCiY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 22 Mar 2006 21:38:24 -0500
In-Reply-To: <4421F834.1070602@liberouter.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jiri Slaby <slaby@liberouter.org>
Cc: biscani@pd.astro.it, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

Jiri Slaby <slaby@liberouter.org> wrote:
>
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Francesco Biscani napsal(a):
> > Hello,
> > 
> > sometimes at boot I get the following from the logs:
> > 
> > ACPI: write EC, IB not empty
> > ACPI Exception (evregion-0409): AE_TIME, Returned by Handler for 
> > [EmbeddedControl] [20060127]
> > ACPI Error (psparse-0517): Method parse/execution failed 
> > [\_SB_.PCI0.ISA_.EC0_.SMRD] (Node c13ecd40), AE_TIME
> > ACPI Error (psparse-0517): Method parse/execution failed [\_SB_.BAT1.UPBI] 
> > (Node dbf42720), AE_TIME
> > ACPI Error (psparse-0517): Method parse/execution failed [\_SB_.BAT1.CHBP] 
> > (Node dbf42660), AE_TIME
> > ACPI Error (psparse-0517): Method parse/execution failed 
> > [\_SB_.PCI0.ISA_.EC0_.SMSL] (Node c13ecce0), AE_TIME
> > ACPI Error (psparse-0517): Method parse/execution failed 
> > [\_SB_.PCI0.ISA_.EC0_._Q09] (Node c13ecc40), AE_TIME
> > 
> > And after that the battery is reported as absent (even if it is physically 
> > present). I get the impression that this happens when rebooting, not 
> > from "cold powerons".
> > 
> > This did not happen in 2.6.15, it appeared somewhere in 2.6.16-rc series.
> Could you post dmesgs of both, acpidump and .config? Could you bisect them?
> 

And please Cc: linux-acpi@vger.kernel.org, thanks.
