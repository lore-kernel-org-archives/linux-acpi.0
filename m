From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: [patch]acpi: add missing _OSI strings -- resend
Date: Wed, 06 Jul 2011 08:29:12 +0800
Message-ID: <1309912152.15392.242.camel@sli10-conroe>
References: <1309757000.15392.221.camel@sli10-conroe>
	 <20110705150853.53e00c17.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:45835 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751378Ab1GFA3O (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 5 Jul 2011 20:29:14 -0400
In-Reply-To: <20110705150853.53e00c17.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux acpi <linux-acpi@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, "Jarosz, Sebastian" <sebastian.jarosz@intel.com>

On Wed, 2011-07-06 at 06:08 +0800, Andrew Morton wrote:
> On Mon, 04 Jul 2011 13:23:20 +0800
> Shaohua Li <shaohua.li@intel.com> wrote:
> 
> > Last post (Jun 14 ) is lost, resend.
> > 
> > 
> > Linux supports some optional features, but it should notify BIOS about them
> > in _OSI method. Currently Linux doesn't notify any, which might make such
> > features not work because BIOS doesn't know about them.
> > 
> 
> This is a bit vague.  Are any machines actually fixed or improved by
> this change?  Is so, can we please see a full description of the
> behaviour change?
I haven't a system which needs the fix. Jarosz Sebastian has a system
which needs this to make ACPI processor aggregator device work.

Thanks,
Shaohua

