From: Matthew Garrett <mjg@redhat.com>
Subject: Re: [PATCH 15/15] Revert "x86: default to reboot via ACPI"
Date: Thu, 6 Nov 2008 21:50:11 +0000
Message-ID: <20081106215011.GA6391@srcf.ucam.org>
References: <1225915018-6548-1-git-send-email-ehabkost@redhat.com> <20081106143021.GD13023@elte.hu> <20081106150610.GA1644@elte.hu> <200811061853.08003.arvidjaar@mail.ru> <alpine.LFD.2.00.0811061442590.3106@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:41579 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754738AbYKFVuw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Nov 2008 16:50:52 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0811061442590.3106@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Andrey Borzenkov <arvidjaar@mail.ru>, Ingo Molnar <mingo@elte.hu>, Eduardo Habkost <ehabkost@redhat.com>, Avi Kivity <avi@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, kexec@lists.infradead.org, kvm@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org

On Thu, Nov 06, 2008 at 02:50:06PM -0500, Len Brown wrote:

> My expectation is that with the ACPI default, our problem
> is working around a finite list of old machines that don't work;
> while with the default KBD, our problem is working around
> a potentially unbounded list of yet to be shipped machines
> who may only be tested and work using the ACPI method.

Does Windows default to using the ACPI method now?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
