From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [2.6.29-rc2] ALi USB OHCI enables interrupts during power down
	in suspend.
Date: Tue, 20 Jan 2009 00:45:09 +0100
Message-ID: <20090119234509.GB452@elte.hu>
References: <200901181642.00886.arvidjaar@mail.ru> <200901192013.46962.rjw@sisk.pl> <200901192333.40757.arvidjaar@mail.ru> <200901192148.02096.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:52094 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752433AbZASXpr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 19 Jan 2009 18:45:47 -0500
Content-Disposition: inline
In-Reply-To: <200901192148.02096.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrey Borzenkov <arvidjaar@mail.ru>, linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>


* Rafael J. Wysocki <rjw@sisk.pl> wrote:

> > Yes.
> > 
> > Tested-by: Andrey Borzenkov <arvidjaar@mail.ru>
> 
> OK, thanks for the confirmation.
> 
> Time to write a changelog ...

Please also add capable debug checks. Andrey did great testing that pinned 
it down fast but still it took more than a dozen mails and a lot of 
patches to get here and that kind of expertise cannot be expected from 
normal bug-reporters.

	Ingo
