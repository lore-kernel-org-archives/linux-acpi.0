From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH]  ACPI: Check _PSS invalidation when BIOS report _PSS
	with all 0x80000000
Date: Fri, 13 Mar 2009 10:16:19 +0800
Message-ID: <1236910579.2807.109.camel@rzhang-dt>
References: <alpine.LFD.2.00.0812120029260.27968@localhost.localdomain>
	 <49B90C7F.3080608@xandros.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:42715 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751150AbZCMCPZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 12 Mar 2009 22:15:25 -0400
In-Reply-To: <49B90C7F.3080608@xandros.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Woody Suwalski <woodys@xandros.com>
Cc: Len Brown <lenb@kernel.org>, "Youquan,Song" <youquan.song@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

this seems like a different problem.

> >   
> On Dell Latitude E4300 and E4600 I had to add processor.nocst=1

please attach the lspci of these laptops.

> Otherwise system will become disfunctional after modprobing processor, 
> typically on start of X or on exit from X...

please use nocst to start X, and attach the /etc/X11/xorg.conf
and /var/log/Xorg.0.log after X is started.

thanks,
rui

> Do not have any of the systems on hand, but if useful can provide dmesg 
> dump...
> I have not tried with 2.6.28 or earlier, so can not say if this is a 
> regression or not.
> 
> Woody
> 

