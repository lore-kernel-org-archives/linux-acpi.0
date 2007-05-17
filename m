From: Johannes Engel <j-engel@gmx.de>
Subject: Re: Why is it so hard to (get) help on ACPI?
Date: Fri, 18 May 2007 00:16:30 +0200
Message-ID: <464CD43E.8060409@gmx.de>
References: <200705172005.47845.matija.suklje@rutka.net> <200705172132.06026.matija.suklje@rutka.net> <8f8ff01d0705171256m39b6e5t8a69f8095f00594b@mail.gmail.com> <200705172210.14815.matija.suklje@rutka.net> <20070517204439.GA23599@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:58937 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755149AbXEQWP4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 17 May 2007 18:15:56 -0400
In-Reply-To: <20070517204439.GA23599@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: =?UTF-8?B?TWF0aWphIMWgdWtsamU=?= <matija.suklje@rutka.net>, Alexey Starikovskiy <aystarik@gmail.com>, linux-acpi@vger.kernel.org

Matthew Garrett schrieb:
> The kernel's job is to make hardware work. If the hardware works under 
> another OS, then it failing to work in Linux is a bug in Linux. So, yes, 
> the correct place to fix this sort of thing is in the kernel rather than 
> your DSDT.
>
> However, please note that the DSDT is almost entirely irrelevant when it 
> comes to things like suspend/resume. Modifying it is hugely unlikely to 
> make things work there.
Hm, I do not totally agree. Since in some cases you know that a BIOS
update caused the trouble it seems to be likely in my eyes that these
problems could be fixed by DSDT changes. Please correct me if I'm wrong.

Greetings, Johannes
