From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 9/25] irq: Add a dynamic irq creation API
Date: Tue, 20 Jun 2006 21:41:43 -0400
Message-ID: <4498A3D7.6030406@garzik.org>
References: <m1ac87ea8s.fsf@ebiederm.dsl.xmission.com>	 <11508425183073-git-send-email-ebiederm@xmission.com>	 <11508425191381-git-send-email-ebiederm@xmission.com>	 <11508425192220-git-send-email-ebiederm@xmission.com>	 <11508425191063-git-send-email-ebiederm@xmission.com>	 <1150842520235-git-send-email-ebiederm@xmission.com>	 <11508425201406-git-send-email-ebiederm@xmission.com>	 <1150842520775-git-send-email-ebiederm@xmission.com>	 <11508425213394-git-send-email-ebiederm@xmission.com>	 <115084252131-git-send-email-ebiederm@xmission.com>	 <1150847764.1901.64.camel@localhost.localdomain>	 <m1veqvb9tr.fsf@ebiederm.dsl.xmission.com> <1150853583.12507.53.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:14212 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750724AbWFUBl7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 20 Jun 2006 21:41:59 -0400
In-Reply-To: <1150853583.12507.53.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, discuss@x86-64.org, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, Andi Kleen <ak@suse.de>, Natalie Protasevich <Natalie.Protasevich@UNISYS.com>, Len Brown <len.brown@intel.com>, Kimball Murray <kimball.murray@gmail.com>, Brice Goglin <brice@myri.com>, Greg Lindahl <greg.lindahl@qlogic.com>, Dave Olson <olson@unixfolk.com>, Greg KH <gregkh@suse.de>, Grant Grundler <iod00d@hp.com>, "bibo,mao" <bibo.mao@intel.com>, Rajesh Shah <rajesh.shah@intel.com>, Mark Maule <maule@sgi.com>, Jesper Juhl <jesper.juhl@gmail.com>, Shaohua Li <shaohua.li@intel.com>, Matthew Wilcox <matthew@wil.cx>, "Michael S. Tsirkin" <mst@mellanox.co.il>, Ashok Raj <ashok.raj@intel.com>, Randy Dunlap <rdunlap@x>

Benjamin Herrenschmidt wrote:
> I have neither b) nor c) nowadays on powerpc.... "linux" irq numbers are
> purely a virtual thing, that is an index in irq_desc array and something
> we give to drivers to do request_irq() from. They can map onto hw
> interrupts, MSI-like messages, environment interrupts, could be
> hypervisor messgaes, in fact, it could be anything that remotely looks
> like an interrupt and the concept of "hw vector" is very blurry here...
> every interrupt controller defines it's own hardware vector space. On
> pSeries, hardware vectors are fairly big numbers that can encode the
> geographical location of the slot where the device is connected to, on
> some other hypervisor, they are 64 bits "tokens" representing an
> hypervisor object that can send events, etc etc....

Indeed...  The return value from return_irq() is purely a cookie, and 
has been for quite some time.

	Jeff


