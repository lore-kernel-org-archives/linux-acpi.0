From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 10/10] x86, ACPI: default to reboot via ACPI (again)
Date: Sat, 8 Nov 2008 13:40:28 +0100
Message-ID: <200811081340.29769.rjw@sisk.pl>
References: <007e7d616a5d1c2e16ad627d03f8b97799445e71.1226032943.git.len.brown@intel.com> <20081107072536.GA19583@elte.hu> <alpine.LFD.2.00.0811072033300.9051@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:40156 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753153AbYKHMf6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 8 Nov 2008 07:35:58 -0500
In-Reply-To: <alpine.LFD.2.00.0811072033300.9051@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Avi Kivity <avi@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Andrey Borzenkov <arvidjaar@mail.ru>

On Saturday, 8 of November 2008, Len Brown wrote:
> 
> > > -enum reboot_type reboot_type = BOOT_KBD;
> > > +enum reboot_type reboot_type = BOOT_ACPI;
> 
> > NAK.
> > 
> > Your point that the set of systems where KBD-reboot is broken is 
> > larger (and growing) than the set of systems where ACPI-reboot is 
> > broken (which set probably has a constant size) is true.
> > 
> > But still this change caused non-trivial regressions in v28 _worse_ 
> > than the inability to reboot cleanly, so this patch does not fly as-is 
> > as we reverted it upstream for a good reason.
> 
> If you can direct me to the failures that ACPI reset caused
> in 28, that would be great.  Obviously they are not on
> the linux-acpi archives because the x86 tree enabled
> ACPI reset and then disabled it w/o telling us...

I think I have one machine with this problem at the Uni (it's an NForce4-based
desktop with Athlon64 X2).  I won't be there before Wednesday, though.

Thanks,
Rafael
