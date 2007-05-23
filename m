From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] [-mm] ACPI: export ACPI events via netlink
Date: Wed, 23 May 2007 09:17:31 +0800
Message-ID: <1179883051.7707.35.camel@localhost.localdomain>
References: <1179827251.7707.29.camel@localhost.localdomain>
	 <1179831825.4121.30.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:20387 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756899AbXEWBST (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 22 May 2007 21:18:19 -0400
In-Reply-To: <1179831825.4121.30.camel@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: hadi@cyberus.ca
Cc: "linux-acpi@vger" <linux-acpi@vger.kernel.org>, lenb@kernel.org, netdev@vger.kernel.org

On Tue, 2007-05-22 at 07:03 -0400, jamal wrote:
> Hi Zhang Rui,
> 
> Really cool stuff. Can you instead use genetlink?
> http://linux-net.osdl.org/index.php/Generic_Netlink_HOWTO 
> should help. And if you have more questions post on netdev (not lk).
> 
That's really helpful, thanks.
Will post the second version soon. :)

Thanks,
Rui

> On Tue, 2007-22-05 at 17:47 +0800, Zhang Rui wrote:
> > From: Zhang Rui <rui.zhang@intel.com>
> > 
> > Export ACPI events via netlink.
> > A netlink message is broadcasted when an ACPI event is generated.
> > 
