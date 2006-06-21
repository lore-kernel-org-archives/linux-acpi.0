From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH 4/25] msi: Simplify msi enable and disable.
Date: Tue, 20 Jun 2006 19:19:36 -0600
Message-ID: <m1irmvb907.fsf@ebiederm.dsl.xmission.com>
References: <m1ac87ea8s.fsf@ebiederm.dsl.xmission.com>
	<11508425183073-git-send-email-ebiederm@xmission.com>
	<11508425191381-git-send-email-ebiederm@xmission.com>
	<11508425192220-git-send-email-ebiederm@xmission.com>
	<11508425191063-git-send-email-ebiederm@xmission.com>
	<20060620174424.B10402@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:49353 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750768AbWFUBUe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 20 Jun 2006 21:20:34 -0400
In-Reply-To: <20060620174424.B10402@unix-os.sc.intel.com> (Rajesh Shah's
	message of "Tue, 20 Jun 2006 17:44:24 -0700")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Rajesh Shah <rajesh.shah@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, discuss@x86-64.org, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, Andi Kleen <ak@suse.de>, Natalie Protasevich <Natalie.Protasevich@UNISYS.com>, Len Brown <len.brown@intel.com>, Kimball Murray <kimball.murray@gmail.com>, Brice Goglin <brice@myri.com>, Greg Lindahl <greg.lindahl@qlogic.com>, Dave Olson <olson@unixfolk.com>, Jeff Garzik <jeff@garzik.org>, Greg KH <gregkh@suse.de>, Grant Grundler <iod00d@hp.com>, "bibo,mao" <bibo.mao@intel.com>, Mark Maule <maule@sgi.com>, Jesper Juhl <jesper.juhl@gmail.com>, Shaohua Li <shaohua.li@intel.com>, Matthew Wilcox <matthew@wil.cx>, "Michael S. Tsirkin" <mst@mellanox.co.il>, Ashok Raj <ashok.raj@intel.com>, Randy Dunlap <rdunlap@xenotime.net>, Roland Dreier <rdreier@cisco.com>, Ton

Rajesh Shah <rajesh.shah@intel.com> writes:

> On Tue, Jun 20, 2006 at 04:28:17PM -0600, Eric W. Biederman wrote:
>> 
>> @@ -937,27 +936,8 @@ int pci_enable_msi(struct pci_dev* dev)
>>  	if (!pos)
>>  		return -EINVAL;
>>  
>> -	if (!msi_lookup_vector(dev, PCI_CAP_ID_MSI)) {
>> -		/* Lookup Sucess */
>> -		unsigned long flags;
>> +	BUG_ON(!msi_lookup_vector(dev, PCI_CAP_ID_MSI));
>>  
> A driver that calls pci_enable_msi() while MSI is already enabled
> will hit this BUG_ON. This is different from the behavior of
> some other pci functions like pci_enable_device(), which
> silently return success if the requested operation is a nop.
> It's pretty easy to do the same here too (ditto for MSI-X).

With MSI-X we can't be a NOOP so it is clearly a bug.

With MSI it might happen, and I don't have a problem if it becomes
a noop.  At the same time I'm not convinced it isn't a bug.

All I really care about is that we don't try and do the impossible and
enable the msi from a half initialized software state like we were doing
before.

That was really ugly and impossible to get right.

Eric
