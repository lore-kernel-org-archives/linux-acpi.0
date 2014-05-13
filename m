From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH 0/2] ACPI / LPSS: fix for a Baytrail PM issue
Date: Tue, 13 May 2014 13:12:36 +0300
Message-ID: <20140513101236.GA4157@xps8300>
References: <1399559631-24785-1-git-send-email-heikki.krogerus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:29469 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759676AbaEMKMp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 13 May 2014 06:12:45 -0400
Content-Disposition: inline
In-Reply-To: <1399559631-24785-1-git-send-email-heikki.krogerus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Jin Yao <yao.jin@linux.intel.com>, Li Aubrey <aubrey.li@linux.intel.com>, linux-acpi@vger.kernel.org

Hi,

On Thu, May 08, 2014 at 05:33:49PM +0300, Heikki Krogerus wrote:
> These will fix the issue with some BYT boards, where resuming from D3
> fails. The root cause turned out to be because we loose the context of
> the private registers.

This serie will conflict with the fractional divider clock serie..

I'll prepare a new version and combine the two. They both will tackle
Asus T100 issues, so it kinda makes sense also because of that.

Thanks,

-- 
heikki
