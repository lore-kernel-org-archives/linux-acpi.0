From: Len Brown <lenb@kernel.org>
Subject: Re: [0/5] remove ACPI motherboard driver, use PNP system driver instead (take 2)
Date: Mon, 29 Jan 2007 18:19:26 -0500
Message-ID: <200701291819.26964.lenb@kernel.org>
References: <200701181636.45590.bjorn.helgaas@hp.com> <200701291600.35739.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:55956 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964872AbXA2XUw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 29 Jan 2007 18:20:52 -0500
In-Reply-To: <200701291600.35739.bjorn.helgaas@hp.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Matthieu Castet <castet.matthieu@free.fr>, Li Shaohua <shaohua.li@intel.com>

On Monday 29 January 2007 18:00, Bjorn Helgaas wrote:
> Shaohua, Len, others,
> 
> Did I resolve all the concerns you had about these patches?  Should
> I re-post them?

Bjorn,
I didn't see any problems with them.

On 1/24 I checked in your series posted on 1/18, and they've been in acpi-test since.
Sorry if I neglected to Ack them then -- sometimes I get interrupted and drop an Ack.
So unless you have an update since 1/18, then we're good.

Note that andrew ran into merge conflicts with the latest acpi-test and dropped back to a version
of git-acpi.pach just before this - which is why your patch series isn't in 2.6.20-rc6-mm2 via acpi-test.
Hopefully we'll get past that merge conflict issue soon.

thanks,
-Len

