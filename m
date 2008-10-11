From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: eeepc-laptop: Use standard interfaces
Date: Sat, 11 Oct 2008 14:55:53 +0100
Message-ID: <20081011135553.GA17573@srcf.ucam.org>
References: <48F0AE74.30303@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:59678 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753394AbYJKNz6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 11 Oct 2008 09:55:58 -0400
Content-Disposition: inline
In-Reply-To: <48F0AE74.30303@tuffmail.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Cc: linux acpi <linux-acpi@vger.kernel.org>

On Sat, Oct 11, 2008 at 02:47:32PM +0100, Alan Jenkins wrote:

> I guess the rfkill subsystem automatically trips the switch to save
> power in suspend.  And I don't have resume scripts with the pci hotplug
> magic workaround.  So, do you still think it would be appropriate to
> merge this rfkill code before the pci hotplug magic is implemented
> in-kernel?

The suspend/resume code in rfkill is being removed in this release 
cycle, so I don't think there's a problem.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
