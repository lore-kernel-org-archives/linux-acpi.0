From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: Re: [PATCH 3/3] [2.6.25-rc5] Warn user about a BIOS bug in recent
	asus boards
Date: Wed, 12 Mar 2008 15:12:25 +0800
Message-ID: <1205305945.2240.56.camel@acpi-hp-zz.sh.intel.com>
References: <1205280392.8194.46.camel@linux-2bdv.site>
	 <200803120010.41373.lenb@kernel.org>  <200803120140.14243.lenb@kernel.org>
	 <1205300688.2240.47.camel@acpi-hp-zz.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:56288 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750993AbYCLHX7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 12 Mar 2008 03:23:59 -0400
In-Reply-To: <1205300688.2240.47.camel@acpi-hp-zz.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: =?ISO-8859-1?Q?N=E9meth_M=E1rton?= <nm127@freemail.hu>, trenn@suse.de, linux-acpi <linux-acpi@vger.kernel.org>


On Wed, 2008-03-12 at 13:44 +0800, Zhang, Rui wrote:
> On Wed, 2008-03-12 at 13:40 +0800, Len Brown wrote:
> > Actually,
> > This case (and others)
> > seems to be taken care of by Rui's recent patch for 8544, yes?
> > 
> >  [PATCH] ACPI: thermal fixup for broken BIOS which has invalid trip
> > points
> Hah, it doesn't cover the active trip point.
> 
> Please review this patch. :)
After reading the ACPI spec again, 
"If _PSV is defined then either _PSL or _TZD must be defined. _PSL and
_TZD may both be defined".
"_TZD is optional outside of the _PSV requirement".
which means that we should not throw out an error without checking the
_TZD method.
I think the patch still doesn't make sense, please ignore this patch and
wait for the refreshed patch.. :)

thanks,
rui

