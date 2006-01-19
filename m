From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: t41, suspend on ram, power consumption
Date: Thu, 19 Jan 2006 23:15:14 +0000
Message-ID: <20060119231514.GA9829@srcf.ucam.org>
References: <20060113095634.GA7112@mnementh.homelinux.org> <20060113101638.12055.qmail@web81607.mail.mud.yahoo.com> <20060117203732.GC24179@message-id.gmane0305.slipkontur.de> <20060119105001.GE2154@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:40903 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1161046AbWASXPc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 19 Jan 2006 18:15:32 -0500
Content-Disposition: inline
In-Reply-To: <20060119105001.GE2154@poupinou.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bruno Ducrot <ducrot@poupinou.org>
Cc: Stefan Seyfried <seife@gmane0305.slipkontur.de>, linux-acpi@vger.kernel.org

On Thu, Jan 19, 2006 at 11:50:01AM +0100, Bruno Ducrot wrote:

> I'm not sure you are right with that claim.  There may be some code
> onto suspend2 patches that may help improve suspend/resume devices that
> are not yet merged to mainline.  I don't think however this fill fix
> the thinkpad problem of the OP though.

Last time I checked, there was some code to restore AGP bridge state. 
I think that's pretty much it.
 
-- 
Matthew Garrett | mjg59@srcf.ucam.org
