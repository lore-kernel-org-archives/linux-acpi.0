From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 1/2] mpparse: Add a knob to disable IRQ 0 through I/O
	APIC
Date: Tue, 1 Jul 2008 08:18:15 +0200
Message-ID: <20080701061815.GA16642@elte.hu>
References: <Pine.LNX.4.55.0807010041030.30785@cliff.in.clinika.pl> <20080630215746.84ffb0f4.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:32877 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751492AbYGAGTQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 1 Jul 2008 02:19:16 -0400
Content-Disposition: inline
In-Reply-To: <20080630215746.84ffb0f4.randy.dunlap@oracle.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: "Maciej W. Rozycki" <macro@linux-mips.org>, Matthew Garrett <mjg59@srcf.ucam.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-next@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org


* Randy Dunlap <randy.dunlap@oracle.com> wrote:

> What calls set_disable_irq0_through_ioapic() ?

a DMI quirk in the next patch:

+dmi_disable_irq0_through_ioapic(const struct dmi_system_id *d)
+{
+       pr_notice("%s detected: disabling IRQ 0 through I/O APIC\n", d->ident);
+       set_disable_irq0_through_ioapic(1);
+       return 0;

	Ingo
