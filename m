From: Bart Jonkers <jonkersbart@gmail.com>
Subject: RE: Question about own battery driver
Date: Tue, 14 Mar 2006 07:37:00 +0100
Message-ID: <1142318220.9336.9.camel@localhost.localdomain>
References: <3ACA40606221794F80A5670F0AF15F840B329FE7@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from uproxy.gmail.com ([66.249.92.200]:14021 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751731AbWCNGhE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 14 Mar 2006 01:37:04 -0500
Received: by uproxy.gmail.com with SMTP id s2so693605uge
        for <linux-acpi@vger.kernel.org>; Mon, 13 Mar 2006 22:37:02 -0800 (PST)
In-Reply-To: <3ACA40606221794F80A5670F0AF15F840B329FE7@pdsmsx403>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Yu, Luming" <luming.yu@intel.com>
Cc: linux-acpi@vger.kernel.org

On Tue, 2006-03-14 at 14:13 +0800, Yu, Luming wrote:
> >Hey,
> >
> >I am busy with creating a battery driver for an embedded 
> >system and want
> >to let my driver interface with the acpi interface.
> 
> Do you think your embedded system can accommodate ACPI subsystem,
> which is huge.
> 
Wat do you mean with huge? Is the kernel side or the user-space side
big?
My device uses an Intel PXA255 processor en has 64MB ram.

I have just seen that ACPI is not supported for ARM. Am I right?
What should be the right thing in this case? Write my own driver and use
an own interface to communicate with the driver, or is there some other
system in the kernel where my driver belongs and that I need to use.

Thanks,
Bart

