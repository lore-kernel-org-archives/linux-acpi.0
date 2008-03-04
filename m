From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] ACPI: Unneccessary to scan the PCI bus already scanned.
Date: Tue, 4 Mar 2008 22:23:40 +0100
Message-ID: <20080304212340.GE31546@elte.hu>
References: <20080303073214.GA5934@elte.hu> <86802c440803030006m1879838awc238f07bc98ed43e@mail.gmail.com> <86802c440803030030p4ff9cec5tdb25d1cdc131d377@mail.gmail.com> <86802c440803030201i684f31c1m97fb3f1f1927d4f4@mail.gmail.com> <20080303101040.GG18281@elte.hu> <86802c440803030233s1b0cc0a6nbed683ee3d4fac63@mail.gmail.com> <20080303111124.GA27348@elte.hu> <86802c440803031057m7802a00cnd158da03c4bb507@mail.gmail.com> <86802c440803041128g16a2cf8chdf8c87f5f24742a1@mail.gmail.com> <86802c440803041134t45c4e2b3yd6ee0f9f32298c55@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:48366 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755787AbYCDVXx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 4 Mar 2008 16:23:53 -0500
Content-Disposition: inline
In-Reply-To: <86802c440803041134t45c4e2b3yd6ee0f9f32298c55@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yinghai Lu <yhlu.kernel@gmail.com>
Cc: Greg KH <gregkh@suse.de>, Muli Ben-Yehuda <muli@il.ibm.com>, Zhao Yakui <yakui.zhao@intel.com>, lenb@kernel.org, linux-acpi@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>


* Yinghai Lu <yhlu.kernel@gmail.com> wrote:

> use this v2 one please

thanks, applied. (but this must ultimately go via the ACPI/PCI trees i 
suspect, as it patches arch/x86/pci/acpi.c)

	Ingo
