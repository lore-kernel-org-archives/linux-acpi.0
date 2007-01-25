From: Len Brown <lenb@kernel.org>
Subject: Re: [linux-pm] [PATCH 0/6] [-mm]: ACPI: duplicate ACPI procfs functions in sysfs
Date: Wed, 24 Jan 2007 21:03:56 -0500
Message-ID: <200701242103.57153.lenb@kernel.org>
References: <1168083306.5619.34.camel@localhost.localdomain> <20070107111509.GA4792@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:33819 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965158AbXAYCFV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 24 Jan 2007 21:05:21 -0500
In-Reply-To: <20070107111509.GA4792@ucw.cz>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Zhang Rui <rui.zhang@intel.com>, "linux-acpi@vger" <linux-acpi@vger.kernel.org>, linux-pm@osdl.org


> > Patch 03-05:
> > 	add ACPI sleep attributes in sysfs.
> > 	/proc/acpi/sleep is already deprecated by /sys/power/state.
> 
> Does that mean we drop standby (S1) capability on PCs?

I think we need to make /sys/power/state handle S1.

There are two cases

1. Platform supports S1, but does not support S3.

This is more common.  You see this a lot on server-class machines.

We could make "mem" simply mean S1 here b/c it is effectively
the closest thing to S3.

2. Platform supports both S1 and S3.

This is pretty rare -- at least on the systems I've got.
I'd  like the generic interface be able to describe and handle this case.

I'm open to suggestions on what to call S1 if it isn't called "mem".

-Len
