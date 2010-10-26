From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] ACPI / PM: Blacklist another machine that needs
	acpi_sleep=nonvs
Date: Tue, 26 Oct 2010 20:23:07 +0100
Message-ID: <20101026192307.GB17880@srcf.ucam.org>
References: <201010172101.21576.rjw@sisk.pl> <alpine.LFD.2.00.1010252013270.18670@localhost.localdomain> <20101026131948.GA9221@srcf.ucam.org> <201010262049.21424.rjw@sisk.pl> <alpine.LFD.2.00.1010261519490.11689@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:32909 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932418Ab0JZTXQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 26 Oct 2010 15:23:16 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1010261519490.11689@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Emanuele Bigiarini <pulmro@gmail.com>

On Tue, Oct 26, 2010 at 03:21:15PM -0400, Len Brown wrote:
> > Windows-compatible.
> 
> Matthew,
> Exactly what version of Windows did you test to be saving NVS?
> Is it possible that different versions of Windows behave differently?

XP. It's certainly possible that later versions behave differently - 
I'll have to go back and check the original machine that had this 
problem to see which _OSI calls it makes. It may be that querying Vista 
or 7 disables this functionality.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
