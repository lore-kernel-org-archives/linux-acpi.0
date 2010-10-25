From: Myron Stowe <myron.stowe@hp.com>
Subject: Re: [PATCH 0/7] ACPI: Memory Mapped I/O (MMIO) pre-mapping
Date: Mon, 25 Oct 2010 09:34:24 -0600
Message-ID: <1288020864.2462.49.camel@zim>
References: <20101021201916.9220.5711.stgit@bob.kio>
	 <alpine.LFD.2.00.1010242336390.3343@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0029.austin.hp.com ([15.216.28.36]:6451 "EHLO
	g1t0029.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753718Ab0JYPe2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Oct 2010 11:34:28 -0400
In-Reply-To: <alpine.LFD.2.00.1010242336390.3343@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, ak@linux.intel.com, ying.huang@intel.com

On Sun, 2010-10-24 at 23:38 -0400, Len Brown wrote:
> applied to acpi-test
> 
> My comfort-level with these changes is not high.
> 
> I'm open to your recommendations on if they are
> too late/risky for this merge window -- or too
> important to miss this merge window.

Hi Len:

I don't track your work/integration methods so perhaps I inadvertently
just hit the end of one of your merge windows.

To your points, I understand your comfort-level concerns.  Most of this
patch series is re-factoring but the testing of the base functionality
provided to date has been limited to APEI so it's probably likely that
not much has really occurred.

It would be fine to skip this merge window and get some more run time.

Myron

> 
> thanks,
> Len Brown, Intel Open Source Technology Center
> 


-- 
Myron Stowe                             HP Open Source Linux Lab (OSLL)

