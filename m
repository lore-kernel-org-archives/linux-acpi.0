From: Stefan Seyfried <seife@gmane0305.slipkontur.de>
Subject: Re: Powers off after suspen to mem
Date: Mon, 20 Mar 2006 07:55:47 +0100
Message-ID: <20060320065547.GA24019@message-id.gmane0305.slipkontur.de>
References: <F7DC2337C7631D4386A2DF6E8FB22B30065E13EC@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:44943 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932170AbWCTHAZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 20 Mar 2006 02:00:25 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FLENL-0005bw-QM
	for linux-acpi@vger.kernel.org; Mon, 20 Mar 2006 08:00:23 +0100
Received: from gprs-pool-1-007.eplus-online.de ([212.23.126.7])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Mon, 20 Mar 2006 08:00:23 +0100
Received: from seife by gprs-pool-1-007.eplus-online.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Mon, 20 Mar 2006 08:00:23 +0100
Content-Disposition: inline
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B30065E13EC@hdsmsx401.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

On Mon, Mar 13, 2006 at 10:50:01PM -0500, Brown, Len wrote:
> rmmod button
> before the suspend.

ok.
 
> or resume by opening the lid instead of pressing the power button. 

This won't help on toshibas (for example) that always generate a
button/power event on resume, no matter how you do it.

=> best solution is to let userspace ignore button event directly
   after resume (like e.g. powersaved does)
-- 
Stefan Seyfried

