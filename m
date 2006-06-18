From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Resume on Apple Mac Mini
Date: Sat, 17 Jun 2006 17:35:51 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606171732370.5498@g5.osdl.org>
References: <CFF307C98FEABE47A452B27C06B85BB670F3C4@hdsmsx411.amr.corp.intel.com>
 <44677056.1080004@gmail.com> <Pine.LNX.4.64.0606171408230.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:11997 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751085AbWFRAfz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 17 Jun 2006 20:35:55 -0400
In-Reply-To: <Pine.LNX.4.64.0606171408230.5498@g5.osdl.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>, "Brown, Len" <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org



On Sat, 17 Jun 2006, Linus Torvalds wrote:
>
> It turns out that the Apple Mac Mini comes back from suspend in legacy 
> mode.

Actually, that wasn't it. My debugging patches use the RTC to save off 
information, and that causing a test-kernel to not compile the test, or 
just normal incompetence on my part, made me "confirm" this as working, 
when it isn't.

The thing that does work is to literally just set the SCI_ENABLE bit:

	acpi_set_register(ACPI_BITREG_SCI_ENABLE, 1, ACPI_MTX_DO_NOT_LOCK);

after resume, _not_ the "acpi_enable()".

		Linus
