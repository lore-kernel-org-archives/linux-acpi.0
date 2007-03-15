From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH 01/22] cpuidle take2: Core cpuidle infrastructure
Date: 15 Mar 2007 13:31:33 +0100
Message-ID: <p7364928z8a.fsf@bingen.suse.de>
References: <11734992592550-git-send-email-lenb@kernel.org>
	<11734992601441-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.suse.de ([195.135.220.2]:45491 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933465AbXCOLcU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 15 Mar 2007 07:32:20 -0400
In-Reply-To: <11734992601441-git-send-email-lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: venkatesh.pallipadi@intel.com, linux-acpi@vger.kernel.org

Len Brown <lenb@kernel.org> writes:
> +
> +/**
> + * cpuidle_idle_call - the main idle loop
> + *
> + * NOTE: no locks or semaphores should be used here
> + * FIXME: DYNTICKS handling

I don't think you can merge anything anymore with such a FIXME.

Besides cpuidle is a pretty radical change outside ACPI and I would recommend to 
make a few review cycles over linux-kernel and likely linux-arch. 

For me it's not clear it has enough advantages for its amount of code

-Andi

