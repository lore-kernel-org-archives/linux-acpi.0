From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: new regression in 2.6.25-rc3: no keyboard/lid acpi events on
 thinkpad T61p
Date: Mon, 25 Feb 2008 23:50:37 +0300
Message-ID: <47C32A1D.8030604@suse.de>
References: <8f53421d0802251119q470a79c1p31048ef136271f84@mail.gmail.com>	 <47C31A1E.7080305@suse.de> <8f53421d0802251239h6b872d94w677995789990e31b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:60346 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759581AbYBYUu7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Feb 2008 15:50:59 -0500
In-Reply-To: <8f53421d0802251239h6b872d94w677995789990e31b@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Michael S. Tsirkin" <m.s.tsirkin@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org

Michael S. Tsirkin wrote:
> Did you guys stop accepting reports by mail?
> I hope not.
It is easier to track bug information in bugzilla.
If you for some reason do not wish to create a bug report,
I can do it for you. You only need to provide acpidump.
> 
>> and attach acpidump?
> 
> I'll see if I can get acpidump output - in which state do you want it?
> Right after boot on the broken kernel?
acpidump output does not change over time, you could get it even with some other kernel.

