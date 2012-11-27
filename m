From: "Westerberg, Mika" <mika.westerberg@intel.com>
Subject: Re: [PATCH] ACPI: remove unnecessary INIT_LIST_HEAD
Date: Tue, 27 Nov 2012 12:05:55 +0200
Message-ID: <20121127100555.GP3867@intel.com>
References: <1354007025-8334-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <20121127092458.GO3867@intel.com>
 <1354009761.20110.61.camel@smile>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:36441 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933410Ab2K0KCi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 27 Nov 2012 05:02:38 -0500
Content-Disposition: inline
In-Reply-To: <1354009761.20110.61.camel@smile>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org

On Tue, Nov 27, 2012 at 11:49:21AM +0200, Andy Shevchenko wrote:
> On Tue, 2012-11-27 at 11:24 +0200, Westerberg, Mika wrote: 
> > On Tue, Nov 27, 2012 at 11:03:45AM +0200, Andy Shevchenko wrote:
> > > There is no need to initialize the node before appending it to the list.
> > 
> > I might be missing something but why do we then have macros like:
> > list_del_init() etc?
> 
> list_del_init(&list->node) allows to reuse &list->node as a new list.
> I guess the often use case of that when you extract the leaf node from
> the list of lists and create a new list based on it.
> 
> In our case we just add a node to the existed list.

OK. Thanks for the explanation.

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
