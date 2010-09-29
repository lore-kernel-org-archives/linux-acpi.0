From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] ACPI: Tie ACPI backlight devices to PCI devices if
	possible
Date: Wed, 29 Sep 2010 19:44:46 +0100
Message-ID: <20100929184446.GA28082@srcf.ucam.org>
References: <1284053985-11254-1-git-send-email-mjg@redhat.com> <alpine.LFD.2.00.1009291438520.21034@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:42431 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754022Ab0I2Sov (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Sep 2010 14:44:51 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1009291438520.21034@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

On Wed, Sep 29, 2010 at 02:39:12PM -0400, Len Brown wrote:
> -ENOAPPLY
> 
> what tree is this patch on top of?

It requires the backlight rework which still hasn't been merged.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
