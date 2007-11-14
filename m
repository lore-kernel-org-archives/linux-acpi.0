From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH 0/5][RFC] Physical PCI slot objects
Date: Wed, 14 Nov 2007 02:07:56 +0100
Message-ID: <p73sl39y6qb.fsf@bingen.suse.de>
References: <20071113000853.GA13341@ldl.fc.hp.com>
	<20071113170129.GA20185@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:49295 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761377AbXKNBH7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 13 Nov 2007 20:07:59 -0500
In-Reply-To: <20071113170129.GA20185@kroah.com> (Greg KH's message of "Tue\, 13 Nov 2007 09\:01\:29 -0800")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Alex Chiang <achiang@hp.com>, gregkh@suse.de, kristen.c.accardi@intel.com, lenb@kernel.org, matthew@wil.cx, richard.jones2@hp.com, linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, pcihpd-discuss@lists.sourceforge.net, linux-acpi@vger.kernel.org

Greg KH <greg@kroah.com> writes:
>
> Also, some companies already provide userspace tools to get all of this
> information about the different slots in a system and what is where,
> from userspace, no kernel changes are needed.  So, why add all this
> extra complexity to the kernel if it is not needed?

It's not only complexity. Each new sysfs entry costs memory.
Memory is not free. There should be always a good reason for those.

-Andi
