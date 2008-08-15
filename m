From: Andi Kleen <ak@linux.intel.com>
Subject: Re: linux-next: Tree for August 14 (sysfs/acpi errors)
Date: Fri, 15 Aug 2008 05:11:22 +0200
Message-ID: <48A4F3DA.9030200@linux.intel.com>
References: <20080814172945.250a27f2.sfr@canb.auug.org.au>	 <20080814083828.d10e126d.randy.dunlap@oracle.com>	 <20080814154456.GA26388@kroah.com>  <48A4F05B.9050309@linux.intel.com> <1218769772.3209.46.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:14131 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752191AbYHODLd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 14 Aug 2008 23:11:33 -0400
In-Reply-To: <1218769772.3209.46.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Greg KH <greg@kroah.com>, Randy Dunlap <randy.dunlap@oracle.com>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, rusty@rustcorp.com.au


>> It looks more like the high level code that sets up these parameters
>> broke somehow and starts registering these twice and now ACPI is the
>> first one to hit it (maybe because it starts with 'a' :-). 
> Perhaps we could try "acpi=off" and see if it still happens.

I doubt that would help because module_param()s are always registered
even with acpi=off. They are not really processed by ACPI, but by
kernel/params.c

-Andi

