From: Adam Williamson <awilliam@redhat.com>
Subject: Re: No power management on Bay Trail tablet (Dell Venue 8 Pro)
Date: Mon, 02 Dec 2013 14:35:34 -0800
Message-ID: <1386023734.2566.142.camel@adam.happyassassin.net>
References: <1385848593.2566.35.camel@adam.happyassassin.net>
	 <20131202131822.GK2281@intel.com>
	 <744357E9AAD1214791ACBA4B0B909263011AEE30@SHSMSX101.ccr.corp.intel.com>
	 <20131202135559.GL2281@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44609 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752694Ab3LBWfm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 2 Dec 2013 17:35:42 -0500
In-Reply-To: <20131202135559.GL2281@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>

On Mon, 2013-12-02 at 15:55 +0200, Mika Westerberg wrote:
> On Mon, Dec 02, 2013 at 01:41:55PM +0000, Zhang, Rui wrote:
> > Hi, Adam,
> > 
> > Can you please attach the acpidump output of this machine, and the dmesg output after boot?
> 
> In the original email from Adam to linux-acpi@ both were attached but
> somehow I can't find that email from archives.
> 
> Rui, I'll bounce you the original email.

In the meantime, I found
https://github.com/rjwysocki/linux-pm/commit/b2a51a6d0f96308251cfa41b793c43d0316e3b16 , which looks like it may be relevant to my hardware. I'm building a kernel with that patch added, and I'll see if it makes any difference.
-- 
Adam Williamson
Fedora QA Community Monkey
IRC: adamw | Twitter: AdamW_Fedora | XMPP: adamw AT happyassassin . net
http://www.happyassassin.net

