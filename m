From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: 2.6.24-rc1: OOPS at  acpi_battery_update
Date: Tue, 13 Nov 2007 00:59:26 -0800
Message-ID: <20071113005926.ce4b0c58.akpm@linux-foundation.org>
References: <1193652664.22149.4.camel@localhost>
	<200711050118.34610.rjw@sisk.pl>
	<20071108155344.GA12231@cataract>
	<200711081717.00421.rjw@sisk.pl>
	<47333ACB.6070408@suse.de>
	<20071108203451.1b7f28c0.akpm@linux-foundation.org>
	<47342A2B.5020006@suse.de>
	<20071109014944.26adf4e0.akpm@linux-foundation.org>
	<473961C6.4090407@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:60857 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751172AbXKMI77 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 13 Nov 2007 03:59:59 -0500
In-Reply-To: <473961C6.4090407@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, rjw@sisk.pl, hannes-kernel@saeurebad.de, listen@selfservix.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Tue, 13 Nov 2007 11:35:18 +0300 Alexey Starikovskiy <aystarik@gmail.com> wrote:

> I can not contact with Len for several days, while the oops on battery 
> seems quite important.
> It also seem to behave well in -mm tree (as part of Len's acpi-test).
> Will you send this patch to Linus without approval from Len or should I?

Please send it yourself - your latest version seems a little different
from the one in git-acpi and I'd just be dangerous trying to work out
which one is needed.
