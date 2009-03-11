From: Thomas Renninger <trenn@suse.de>
Subject: Re: [RFC PATCH 0/5] ACPI video: cleanups and fixes for the recent buggy _BQC/_BCL/_BCM BIOSes
Date: Wed, 11 Mar 2009 15:08:03 +0100
Message-ID: <200903111508.04337.trenn@suse.de>
References: <1236672203.2820.118.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns.suse.de ([195.135.220.2]:55580 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752941AbZCKOIH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 11 Mar 2009 10:08:07 -0400
In-Reply-To: <1236672203.2820.118.camel@rzhang-dt>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>

On Tuesday 10 March 2009 09:03:23 Zhang Rui wrote:
> Hi, all,
> 
> here is the patch set I made recently, including some cleanups and fixes
> for the Thinkpad/Asus laptops with buggy _BQC/_BCL/_BCM implementation.
Nice!
Beside the one point that BIOSes without _BQC might end up with a
random brightness at start-up (I think it's that) and Matthew's comments,
I couldn't find anything bad.
Theoretically on BIOSes without _BQC we need to evaluate current AC/battery
state at start-up and take/set the corresponding brightness level.
This should be the only downside people see on such BIOSes, it was always 
initialized to max state booted on battery or AC.

    Thomas

> The first two patches checks if ACPI video driver fails to set/get the
> current brightness level, which is not done before.
> 
> patch 3/4/5 are used to fix three different problems.
> 
> 1. the brightness levels when machine is on AC/Battery are not exported
>    by _BCL.
> 2. The supported brightness levels are reversed in the _BCL method.
> 3. Index values are used in _BQC/_BCL/_BCM method.
> 
> The patches have not been tested yet.
> I send them here to see if someone has better ideas about these issues.
> Any comments are welcome. :)
> 
> thanks,
> rui
>    
> 
> 
> 


