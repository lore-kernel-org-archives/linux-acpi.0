From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: pnpacpi : exceeded the max number of IO resources
Date: Fri, 30 Nov 2007 10:32:19 +0800
Message-ID: <1196389939.7234.1.camel@sli10-desk.sh.intel.com>
References: <a8e1da0711290111m65b071cft90b4361ec0155096@mail.gmail.com>
	 <474F72E3.4040608@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:44705 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758144AbXK3Ccr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 29 Nov 2007 21:32:47 -0500
In-Reply-To: <474F72E3.4040608@keyaccess.nl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Dave Young <hidave.darkstar@gmail.com>, lenb@kernel.org, linux-acpi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Zhao Yakui <yakui.zhao@intel.com>, Bjorn Helgaas <bjorn.helgaas@hp.com>, Thomas Renninger <trenn@suse.de>


On Fri, 2007-11-30 at 03:18 +0100, Rene Herman wrote:
> On 29-11-07 10:11, Dave Young wrote:
> 
> > The pnpacpi rsparser.c report warnings of:
> > exceeded the max number of IO resources: 24
> > 
> > dmesg|grep exceeded|wc
> >     66     594    3564
> 
> Heavens... (added CCs of people who just upped it from 8 -- I suppose the 
> problem is not new then?)
Properly we should make a bit bigger till Thomas's patch is ready.
Thomas, your patch isn't 2.6.24 staff, right?

Thanks,
Shaohua
