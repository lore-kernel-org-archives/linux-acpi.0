From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: ACPI reads wrong temperature
Date: Fri, 31 Oct 2008 14:30:30 +0000
Message-ID: <20081031143030.GA9177@srcf.ucam.org>
References: <20081031140247.325670@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:38513 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751365AbYJaOaf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 31 Oct 2008 10:30:35 -0400
Content-Disposition: inline
In-Reply-To: <20081031140247.325670@gmx.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Peter Mahlknecht <mali100@gmx.net>
Cc: linux-acpi@vger.kernel.org

On Fri, Oct 31, 2008 at 03:02:47PM +0100, Peter Mahlknecht wrote:
> Hi, 
> I installed Debian Lenny (2.6.26-1-686) on my notebook (Samsung P40 with the latest Bios 09HK), but the notebook continued to shutting down with the message "Critical temperature reached (65535 C). Shutting down.". 
> To stop this I patched the thermal module, so that it ignores every temperature above 1000 C. 

Do you get wrong temperatures if you never load the max6657 driver?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
