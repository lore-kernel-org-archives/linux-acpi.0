From: Matthew Garrett <mjg@redhat.com>
Subject: Re: [PATCH 15/15] Revert "x86: default to reboot via ACPI"
Date: Sun, 9 Nov 2008 10:24:23 +0000
Message-ID: <20081109102423.GA13217@srcf.ucam.org>
References: <1225915018-6548-1-git-send-email-ehabkost@redhat.com> <20081106143021.GD13023@elte.hu> <20081106150610.GA1644@elte.hu> <200811061853.08003.arvidjaar@mail.ru> <alpine.LFD.2.00.0811061442590.3106@localhost.localdomain> <20081106215011.GA6391@srcf.ucam.org> <alpine.LFD.2.00.0811061716420.3106@localhost.localdomain> <1226019679.3989.107.camel@yakui_zhao.sh.intel.com> <20081107005946.GA9254@srcf.ucam.org> <4916B737.7050107@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:44733 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754159AbYKIKZp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 9 Nov 2008 05:25:45 -0500
Content-Disposition: inline
In-Reply-To: <4916B737.7050107@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Avi Kivity <avi@redhat.com>
Cc: Zhao Yakui <yakui.zhao@intel.com>, Len Brown <lenb@kernel.org>, Andrey Borzenkov <arvidjaar@mail.ru>, Ingo Molnar <mingo@elte.hu>, Eduardo Habkost <ehabkost@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Sun, Nov 09, 2008 at 12:11:03PM +0200, Avi Kivity wrote:
> Matthew Garrett wrote:
> >Hmm. But we're seeing some machines that end up very confused if 
> >rebooted via ACPI. I guess we need to run Vista on them to find out how 
> >they behave. What OSI strings did your KVM setup expose? We know that 
> >Windows changes behaviour under various circumstances depending on which 
> >OS the firmware requests, so it's almost possible that this is another 
> >of those cases.
> >  
> 
> Isn't it the other way around?  The firmware changes behavior depending 
> on how the OS identifies itself?

That also happens, yes.

> Reboot is a fixed feature IIRC, so it cannot change depending on 
> identification strings.

The ID strings that the firmware requests give a good idea about which 
operating systems the machine has been tested with. If Vista uses the 
ACPI method then having the firmware request the OSI string for Vista 
gives us a good indication that it's safe to use the ACPI method.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
