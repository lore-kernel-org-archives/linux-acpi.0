From: Stefan Seyfried <seife@suse.de>
Subject: Re: [PATCH] ACPI: more verbose thermal zone shutdown message
Date: Thu, 5 Apr 2007 17:12:01 +0200
Message-ID: <20070405151201.GA23652@suse.de>
References: <200704051615.07960.dkukawka@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:37799 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753164AbXDEQ1D (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 5 Apr 2007 12:27:03 -0400
Content-Disposition: inline
In-Reply-To: <200704051615.07960.dkukawka@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Danny Kukawka <dkukawka@suse.de>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Apr 05, 2007 at 04:15:07PM +0200, Danny Kukawka wrote:
> Hi,
> 
> while debug some strange termal shutdowns I wrote this patch to get more 
> information in /var/log/messages about the reason for the shutdown. I 
> think this would be useful in general.

Yes, especially as these were bogus thermal shutdowns, it is useful for
debugging to know from which thermal zone they were initiated.

> Danny
> 
> From: Danny Kukawka <dkukawka@suse.de>
> Subject: ACPI: more verbose thermal zone shutdown message
> 
> add more information to acpi thermal zone shutdown message for easier
> debugging
> 
> Signed-off-by: Danny Kukawka <dkukawka@suse.de>

FWIW:
Signed-off-by: Stefan Seyfried <seife@suse.de>

-- 
Stefan Seyfried

"Any ideas, John?"
"Well, surrounding them's out." 
