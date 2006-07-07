From: Johan Vromans <jvromans@squirrel.nl>
Subject: Re: [patch 4/5] ACPI: disable SBS by default
Date: Fri, 07 Jul 2006 09:24:32 +0200
Message-ID: <m21wsxx4gf.fsf@phoenix.squirrel.nl>
References: <200607070652.k676qw2M030087@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-vbr11.xs4all.nl ([194.109.24.31]:51469 "EHLO
	smtp-vbr11.xs4all.nl") by vger.kernel.org with ESMTP
	id S1750835AbWGGHYp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 7 Jul 2006 03:24:45 -0400
In-Reply-To: <200607070652.k676qw2M030087@shell0.pdx.osdl.net> (akpm@osdl.org's
 message of "Thu, 06 Jul 2006 23:52:58 -0700")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@osdl.org
Cc: len.brown@intel.com, linux-acpi@vger.kernel.org, dtor@insightbb.com, dtor@mail.ru

akpm@osdl.org writes:

> Kconfig help even says that SBS is pretty rare and already obsolete
> so it does not make sence to keep it enabled.

SBS is needed by some laptops of just a year old (and hopefully some
more years to go), and I've been told even today laptops are sold that
require SBS.

So, if it does not get in the way of something else, please let it
enabled.

-- Johan
