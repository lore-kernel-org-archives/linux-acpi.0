From: Rajesh Shah <rajesh.shah@intel.com>
Subject: Re: [PATCH 7/25] msi: Refactor the msi_ops.
Date: Tue, 20 Jun 2006 18:18:19 -0700
Message-ID: <20060620181819.D10402@unix-os.sc.intel.com>
References: <m1ac87ea8s.fsf@ebiederm.dsl.xmission.com> <11508425183073-git-send-email-ebiederm@xmission.com> <11508425191381-git-send-email-ebiederm@xmission.com> <11508425192220-git-send-email-ebiederm@xmission.com> <11508425191063-git-send-email-ebiederm@xmission.com> <1150842520235-git-send-email-ebiederm@xmission.com> <11508425201406-git-send-email-ebiederm@xmission.com> <1150842520775-git-send-email-ebiederm@xmission.com>
Reply-To: Rajesh Shah <rajesh.shah@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:23481 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750768AbWFUBXs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 20 Jun 2006 21:23:48 -0400
Content-Disposition: inline
In-Reply-To: <1150842520775-git-send-email-ebiederm@xmission.com>; from ebiederm@xmission.com on Tue, Jun 20, 2006 at 04:28:20PM -0600
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, discuss@x86-64.org, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, Andi Kleen <ak@suse.de>, Natalie Protasevich <Natalie.Protasevich@UNISYS.com>, Len Brown <len.brown@intel.com>, Kimball Murray <kimball.murray@gmail.com>, Brice Goglin <brice@myri.com>, Greg Lindahl <greg.lindahl@qlogic.com>, Dave Olson <olson@unixfolk.com>, Jeff Garzik <jeff@garzik.org>, Greg KH <gregkh@suse.de>, Grant Grundler <iod00d@hp.com>, "bibo,mao" <bibo.mao@intel.com>, Rajesh Shah <rajesh.shah@intel.com>, Mark Maule <maule@sgi.com>, Jesper Juhl <jesper.juhl@gmail.com>, Shaohua Li <shaohua.li@intel.com>, Matthew Wilcox <matthew@wil.cx>, "Michael S. Tsirkin" <mst@mellanox.co.il>, Ashok Raj <ashok.raj@intel.com>, Randy Dunlap <rdunlap@xenotime.net>

On Tue, Jun 20, 2006 at 04:28:20PM -0600, Eric W. Biederman wrote:
>  drivers/pci/msi-altix.c |   49 +++++++++++++++++++------------------
>  drivers/pci/msi-apic.c  |   36 ++++++++++++++-------------
>  drivers/pci/msi.c       |   22 ++++++++---------
>  drivers/pci/msi.h       |   62 -----------------------------------------------
>  include/linux/pci.h     |   62 +++++++++++++++++++++++++++++++++++++++++++++++

I think the platform/arch specific code here should move to arch/.
For example, msi-altix can go to arch/ia64/sn/pci, msi-apic.c can
go to arch/i386/pci (and can be shared by x86_64)...

Rajesh
