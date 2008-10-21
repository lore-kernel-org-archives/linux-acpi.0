From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 1/2] x86: allow module driver to register idle notifier
Date: Tue, 21 Oct 2008 13:49:23 +0200
Message-ID: <20081021114923.GA28549@elte.hu>
References: <1d80ebdb81444701024ad9b9f026516561496a43.1223706853.git.len.brown@intel.com> <e8b529091b2ab65f5a4783e292c2b472e309116e.1223706853.git.len.brown@intel.com> <20081011083347.GA31918@elte.hu> <alpine.LFD.1.10.0810161803230.3026@localhost.localdomain> <alpine.LFD.1.10.0810202156280.2996@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:50210 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752794AbYJULti (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 21 Oct 2008 07:49:38 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0810202156280.2996@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Venki Pallipadi <venkatesh.pallipadi@intel.com>, Andy Henroid <andrew.d.henroid@intel.com>, Len Brown <len.brown@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>


* Len Brown <lenb@kernel.org> wrote:

> Ingo,
> How shall we proceed?
> If you take this patch, we can ship a modular i7300_idle driver.
> If you do not take this patch, then we'll need to build it into
> the kernel and not allow it to un-register.

sorry - i got held up with other stuff.

Please just commit the export via your tree, we'll sort it out 
afterwards. Your use of the idle callback certainly looks reasonable for 
your purposes and the infrastructure was there after all. I dont want to 
complicate your workflow in any case.

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
