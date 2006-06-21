From: Roland Dreier <rdreier@cisco.com>
Subject: Re: [PATCH 8/25] msi: Simplify the msi irq limit policy.
Date: Tue, 20 Jun 2006 19:46:22 -0700
Message-ID: <adak67bmdj5.fsf@cisco.com>
References: <m1ac87ea8s.fsf@ebiederm.dsl.xmission.com>
	<11508425183073-git-send-email-ebiederm@xmission.com>
	<11508425191381-git-send-email-ebiederm@xmission.com>
	<11508425192220-git-send-email-ebiederm@xmission.com>
	<11508425191063-git-send-email-ebiederm@xmission.com>
	<1150842520235-git-send-email-ebiederm@xmission.com>
	<11508425201406-git-send-email-ebiederm@xmission.com>
	<1150842520775-git-send-email-ebiederm@xmission.com>
	<11508425213394-git-send-email-ebiederm@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from sj-iport-5.cisco.com ([171.68.10.87]:56681 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S1751936AbWFUCq2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 20 Jun 2006 22:46:28 -0400
In-Reply-To: <11508425213394-git-send-email-ebiederm@xmission.com> (Eric W. Biederman's message of "Tue, 20 Jun 2006 16:28:21 -0600")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, discuss@x86-64.org, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, Andi Kleen <ak@suse.de>, Natalie Protasevich <Natalie.Protasevich@UNISYS.com>, Len Brown <len.brown@intel.com>, Kimball Murray <kimball.murray@gmail.com>, Brice Goglin <brice@myri.com>, Greg Lindahl <greg.lindahl@qlogic.com>, Dave Olson <olson@unixfolk.com>, Jeff Garzik <jeff@garzik.org>, Greg KH <gregkh@suse.de>, Grant Grundler <iod00d@hp.com>, "bibo,mao" <bibo.mao@intel.com>, Rajesh Shah <rajesh.shah@intel.com>, Mark Maule <maule@sgi.com>, Jesper Juhl <jesper.juhl@gmail.com>, Shaohua Li <shaohua.li@intel.com>, Matthew Wilcox <matthew@wil.cx>, "Michael S. Tsirkin" <mst@mellanox.co.il>, Ashok Raj <ashok.raj@intel.com>, Randy Dunlap <rdunlap@xe>

 > Only the s2io driver even takes advantage of this feature
 > all other drivers have a fixed number of irqs they need and
 > bail if they can't get them.

My todo list for the mthca (InfiniBand HCA) driver includes adding
support for more event queues.  When I do that, I'll likely want to
try to get something on the order of number_of_cpus plus two or three
MSI-X vectors, and fall back to a lower number of vectors if that
allocation fails.

 - R.
