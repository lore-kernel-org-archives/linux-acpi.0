From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: serial port discovery on a motion computing tablet
Date: Wed, 14 Mar 2007 15:14:41 +0000
Message-ID: <20070314151441.GA3396@srcf.ucam.org>
References: <45F7688B.8000101@elevating.com> <20070314134323.GC1467@srcf.ucam.org> <45F806B1.3060807@elevating.com> <20070314143534.GA2655@srcf.ucam.org> <45F80EAA.6010808@elevating.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:60138 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422638AbXCNPOz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Mar 2007 11:14:55 -0400
Content-Disposition: inline
In-Reply-To: <45F80EAA.6010808@elevating.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bret Hughes <bhughes@elevating.com>
Cc: linux-acpi@vger.kernel.org

On Wed, Mar 14, 2007 at 10:03:06AM -0500, Bret Hughes wrote:
> >That's, uh, surprising - is CONFIG_PNPACPI set?
> >
> >  
> 
> not there:
> 
> [root@localhost linux-2.6.9]# grep PNPACPI .config
> [root@localhost linux-2.6.9]#

Ok. You'll certainly need that.

> 2.6.9-42 Latest Centos kernel.  Too old?

Ouch. Life will probably be easier if you can use anything newer - I 
don't have any trees anywhere near that old now.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
