From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: 2.6.28-rc9 regression: system fails to suspend
Date: Tue, 23 Dec 2008 00:30:03 +0100 (CET)
Message-ID: <alpine.LFD.2.00.0812230029240.3723@localhost.localdomain>
References: <200812220904.28780.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:50014 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753941AbYLVXaK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 22 Dec 2008 18:30:10 -0500
In-Reply-To: <200812220904.28780.arvidjaar@mail.ru>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Mon, 22 Dec 2008, Andrey Borzenkov wrote:

> I will bisect as time permits, but may be it rings the bell for someone. 
> 2.6.28-rc7 is OK; rc9 switches console off and never goes in suspend. 
> Power remains on, keyboard is non-functional and the only way out is 
> power button. I have not tried rc8.
> 
> If somebody has soggestions what to (try to) revert, it would be great 
> and save quite a bit of time for bisecting.

Can you please provide detailed information about the machine which
exposes this problem ?

Thanks,

	tglx

