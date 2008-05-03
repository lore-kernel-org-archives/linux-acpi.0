From: Thomas Renninger <trenn@suse.de>
Subject: Re: linux kernel 2.6.23+ can't restart
Date: Sat, 03 May 2008 21:35:00 +0200
Message-ID: <1209843300.13290.1.camel@linux-2bdv.site>
References: <481B5448.6060202@inl.gov>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns.suse.de ([195.135.220.2]:57302 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751593AbYECTfD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 3 May 2008 15:35:03 -0400
In-Reply-To: <481B5448.6060202@inl.gov>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shane Hansen <shane.hansen@inl.gov>
Cc: linux-acpi@vger.kernel.org


On Fri, 2008-05-02 at 11:50 -0600, Shane Hansen wrote:
> May  2 11:45:18 [kernel] ACPI: DMI Product Version:
> May  2 11:45:18 [kernel] ACPI: DMI Board Name: 0F9382
> May  2 11:45:18 [kernel] ACPI: DMI BIOS Vendor: Dell Inc.
> May  2 11:45:18 [kernel] ACPI: DMI BIOS Date: 12/13/2007
> 
> Since upgrading to the 2.6.23 / 2.6.24 kernels I can no longer "restart" 
> my system.  I can "shutdown" ok, the machine powers off just fine.  
> However when I try a "restart" the kernel goes through all the normal 
> stuff and then hangs on the line that says "Restarting System".  I have 
> to hold down the power button to power off the case...
> 
> 
> Suggestions?

Does this also happen with the latest 2.6.25 kernel?
git-bisect?

  Thomas

