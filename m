From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/2] ACPI / LPSS: fix for a Baytrail PM issue
Date: Tue, 13 May 2014 12:30:35 +0200
Message-ID: <2980034.ipRqz1q2cT@vostro.rjw.lan>
References: <1399559631-24785-1-git-send-email-heikki.krogerus@linux.intel.com> <20140513101236.GA4157@xps8300>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:51550 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1760989AbaEMKNv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 13 May 2014 06:13:51 -0400
In-Reply-To: <20140513101236.GA4157@xps8300>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Jin Yao <yao.jin@linux.intel.com>, Li Aubrey <aubrey.li@linux.intel.com>, linux-acpi@vger.kernel.org

On Tuesday, May 13, 2014 01:12:36 PM Heikki Krogerus wrote:
> Hi,
> 
> On Thu, May 08, 2014 at 05:33:49PM +0300, Heikki Krogerus wrote:
> > These will fix the issue with some BYT boards, where resuming from D3
> > fails. The root cause turned out to be because we loose the context of
> > the private registers.
> 
> This serie will conflict with the fractional divider clock serie..
> 
> I'll prepare a new version and combine the two. They both will tackle
> Asus T100 issues, so it kinda makes sense also because of that.

OK, thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
