From: Huang Ying <ying.huang@intel.com>
Subject: Re: [BUGFIX] ACPI, APEI, Avoid too much error reporting in runtime
Date: Tue, 12 Jun 2012 11:08:10 +0800
Message-ID: <1339470490.7404.34.camel@yhuang-dev>
References: <1339395822-12032-1-git-send-email-ying.huang@intel.com>
	 <1339421127.4942.8.camel@deadeye.wl.decadent.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:53512 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751032Ab2FLDIM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 11 Jun 2012 23:08:12 -0400
In-Reply-To: <1339421127.4942.8.camel@deadeye.wl.decadent.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ben Hutchings <ben@decadent.org.uk>
Cc: Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>, linux-acpi@vger.kernel.org, stable@vger.kernel.org

On Mon, 2012-06-11 at 14:25 +0100, Ben Hutchings wrote:
> On Mon, 2012-06-11 at 14:23 +0800, Huang Ying wrote:
> > This patch fixed the following bug.
> > 
> > https://bugzilla.kernel.org/show_bug.cgi?id=43282
> > 
> > This is caused by a firmware bug checking (checking generic address
> > register provided by firmware) in runtime.  The checking should be
> > done in address mapping time instead of runtime to avoid too much
> > error reporting in runtime.
> > 
> > Reported-by: Pawel Sikora <pluto@agmk.net>
> > Signed-off-by: Huang Ying <ying.huang@intel.com>
> > Tested-by: Jean Delvare <khali@linux-fr.org>
> [...]
> 
> This is not the correct way to submit a patch for stable.  See
> Documentation/stable_kernel_rules.txt.

Thanks for reminding.  Will resend the patch.

Best Regards,
Huang Ying

