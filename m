From: Christoph Hellwig <hch@lst.de>
Subject: Re: regression: 2.6.32-rc8 shuts down after reaching critical temperature
Date: Wed, 2 Dec 2009 16:14:25 +0100
Message-ID: <20091202151425.GA20008@lst.de>
References: <20091125102857.GA28310@lst.de> <alpine.LFD.2.00.0911251647000.3950@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.210]:46933 "EHLO verein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751429AbZLBPPB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 2 Dec 2009 10:15:01 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0911251647000.3950@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Zhang Rui <rui.zhang@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Nov 25, 2009 at 04:56:19PM -0500, Len Brown wrote:
> > I've done some attempts at bisecting it, but for most of the 2.6.32-rc
> > series the system crashes during boot in ACPI code with a backtrace
> > longer than the screen can display.
> 
> Hmm, I don't have a T500, but I've not seen such crashes during -rc.
> Please send along your .config
> Do you still get them when disabling the thinkpad-acpi driver?

I managed to boot 2.6.32-rc1 nd 2.6.32-rc2 with thinkpad-acpi disabled.
Both of them show the shutdown propblem, I'm now looking into bisecting
it further.

