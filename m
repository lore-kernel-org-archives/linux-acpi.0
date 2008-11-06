From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 15/15] Revert "x86: default to reboot via ACPI"
Date: Thu, 06 Nov 2008 14:50:06 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0811061442590.3106@localhost.localdomain>
References: <1225915018-6548-1-git-send-email-ehabkost@redhat.com>
 <20081106143021.GD13023@elte.hu> <20081106150610.GA1644@elte.hu>
 <200811061853.08003.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms042pub.verizon.net ([206.46.252.42]:60863 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751522AbYKFTxt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Nov 2008 14:53:49 -0500
In-reply-to: <200811061853.08003.arvidjaar@mail.ru>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: Ingo Molnar <mingo@elte.hu>, Eduardo Habkost <ehabkost@redhat.com>, Avi Kivity <avi@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, kexec@lists.infradead.org, kvm@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org



> > This reverts commit c7ffa6c26277b403920e2255d10df849bd613380.

I agree that the 2.6.27 default was changed to ACPI for the wrong reason.

However, I think it was the right thing to do,
and if you didn't propose it, I would.

My expectation is that with the ACPI default, our problem
is working around a finite list of old machines that don't work;
while with the default KBD, our problem is working around
a potentially unbounded list of yet to be shipped machines
who may only be tested and work using the ACPI method.

So I recommend leaving the default as ACPI for a while to
see how it goes.

thanks,
-Len

ps. please cc: linux-acpi@vger.kernel.org on ACPI related changes.
