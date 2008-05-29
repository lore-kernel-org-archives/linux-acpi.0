From: Holger Macht <hmacht@suse.de>
Subject: Re: [PATCH] libata: Handle bay devices in dock stations
Date: Thu, 29 May 2008 15:33:02 +0200
Message-ID: <20080529133302.GA9268@homac.suse.de>
References: <20080528143857.GB5585@homac.suse.de> <20080529132253.GA22309@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns.suse.de ([195.135.220.2]:58067 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752210AbYE2NaJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 29 May 2008 09:30:09 -0400
Content-Disposition: inline
In-Reply-To: <20080529132253.GA22309@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-kernel@vger.kernel.org, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, linux-acpi@vger.kernel.org, akpm@linux-foundation.org

On Thu 29. May - 14:22:53, Matthew Garrett wrote:
> Hm. This deadlocks my Thinkpad when I pull a device from the internal 
> bay.

Can you please give a bit more details? Does your userspace react on the
eject request? I tested with Thinkpads, too.

 - Holger

