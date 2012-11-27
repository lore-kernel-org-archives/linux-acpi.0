From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI: remove unnecessary INIT_LIST_HEAD
Date: Tue, 27 Nov 2012 20:10:48 +0100
Message-ID: <8274562.vPeD3JynOX@vostro.rjw.lan>
References: <1354007025-8334-1-git-send-email-andriy.shevchenko@linux.intel.com> <1354009761.20110.61.camel@smile> <20121127100555.GP3867@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:34470 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753234Ab2K0TGE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 27 Nov 2012 14:06:04 -0500
In-Reply-To: <20121127100555.GP3867@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Westerberg, Mika" <mika.westerberg@intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>

On Tuesday, November 27, 2012 12:05:55 PM Westerberg, Mika wrote:
> On Tue, Nov 27, 2012 at 11:49:21AM +0200, Andy Shevchenko wrote:
> > On Tue, 2012-11-27 at 11:24 +0200, Westerberg, Mika wrote: 
> > > On Tue, Nov 27, 2012 at 11:03:45AM +0200, Andy Shevchenko wrote:
> > > > There is no need to initialize the node before appending it to the list.
> > > 
> > > I might be missing something but why do we then have macros like:
> > > list_del_init() etc?
> > 
> > list_del_init(&list->node) allows to reuse &list->node as a new list.
> > I guess the often use case of that when you extract the leaf node from
> > the list of lists and create a new list based on it.
> > 
> > In our case we just add a node to the existed list.
> 
> OK. Thanks for the explanation.
> 
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Applied.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
