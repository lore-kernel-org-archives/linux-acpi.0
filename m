From: Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 02/18] acpi memory hotplug cannot manage _CRS with
 plural resoureces
Date: Sun, 25 Jun 2006 04:02:56 -0700
Message-ID: <20060625040256.73b9d7b3.akpm@osdl.org>
References: <200606242336.k5ONaD1I008028@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:7594 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932351AbWFYLDD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 25 Jun 2006 07:03:03 -0400
In-Reply-To: <200606242336.k5ONaD1I008028@shell0.pdx.osdl.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com, linux-acpi@vger.kernel.org, kamezawa.hiroyu@jp.fujitsu.com, kaneshige.kenji@jp.fujitsu.com


btw, this is, by my count, the seventh time I've sent this patch.  The first
was on March 21.

We have a whole stream of node hot-add patches banked up behind these three
patches:


[patch 02/18] acpi memory hotplug cannot manage _CRS with plural resoureces
[patch 03/18] Catch notification of memory add event of ACPI via container driver. (register start func for memory device)
[patch 04/18] Catch notification of memory add event of ACPI via container driver. (avoid redundant call add_memory)

and we want to get those blocked patches into 2.6.18.

So please review at least these three patches asap and if they're OK please
ack them for inclusion and I'll include them along with the node hotadd
patch series.

Thanks.
