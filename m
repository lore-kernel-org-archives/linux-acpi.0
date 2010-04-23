From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Looking for some pointers on WMI/EC access
Date: Fri, 23 Apr 2010 18:47:29 +0100
Message-ID: <20100423174729.GB31005@srcf.ucam.org>
References: <1271853961.1537.1781.camel@pancake> <20100421133305.GA28710@srcf.ucam.org> <1271860206.1537.1914.camel@pancake> <20100421143239.GA484@srcf.ucam.org> <1271924488.3790.25.camel@flunder> <20100422133605.GA31680@srcf.ucam.org> <1271944219.29664.42.camel@pancake.fritz.box> <20100422135336.GA31984@srcf.ucam.org> <20100422140518.GA32558@srcf.ucam.org> <1272021870.29664.109.camel@pancake.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:54818 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758381Ab0DWRrg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 23 Apr 2010 13:47:36 -0400
Content-Disposition: inline
In-Reply-To: <1272021870.29664.109.camel@pancake.fritz.box>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Florian Echtler <floe@butterbrot.org>
Cc: Corentin Chary <corentin.chary@gmail.com>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org

On Fri, Apr 23, 2010 at 01:24:30PM +0200, Florian Echtler wrote:

> You mean, change the initial value for ERQ0 in the DSDT and load that
> through the kernel? I'll try that. I'll also try a BIOS update and see
> if there's a little more sense in the DSDT afterwards..

More manipulate the buffer directly from the driver. This ought to be 
possible, if a little fiddly.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
