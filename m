From: Len Brown <lenb@kernel.org>
Subject: Re: [REGRESSION] 9a884ab64a4d092b4c3bf24fd9a30f7fbd4591e7 causes boot
 hang
Date: Mon, 21 Dec 2009 21:14:36 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0912212113470.5520@localhost.localdomain>
References: <20091215181538.GA28707@srcf.ucam.org>
 <1260925040.3834.69.camel@minggr.sh.intel.com>
 <20091216151058.GB15217@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:45008 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750988AbZLVCOl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Dec 2009 21:14:41 -0500
In-reply-to: <20091216151058.GB15217@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: Lin Ming <ming.m.lin@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

> > Could you try the attached ACPICA latest release (20091214) patch
> > series? There are module level code and _REG method fixes included in
> > it.
> 
> Yes, that appears to fix it. Len, could you push these ASAP?

We pushed ACPICA 20091214 in -rc1, so you should be set
with that and anything later.

thanks,
Len Brown, Intel Open Source Technology Center


