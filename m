From: Yu Luming <luming.yu@gmail.com>
Subject: Re: [PATCH 2.6.18-mm2] acpi: add backlight support to the sony_acpi driver
Date: Tue, 10 Oct 2006 22:32:46 +0800
Message-ID: <200610102232.46627.luming.yu@gmail.com>
References: <20060930190810.30b8737f.alessandro.guido@gmail.com> <20061005103657.GA4474@ucw.cz> <20061006211751.GA31887@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.195]:30869 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932126AbWJJOcu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Oct 2006 10:32:50 -0400
Received: by nz-out-0102.google.com with SMTP id n1so452174nzf
        for <linux-acpi@vger.kernel.org>; Tue, 10 Oct 2006 07:32:50 -0700 (PDT)
In-Reply-To: <20061006211751.GA31887@lists.us.dell.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matt Domsch <Matt_Domsch@dell.com>
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>, Alessandro Guido <alessandro.guido@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, len.brown@intel.com, jengelh@linux01.gwdg.de, gelma@gelma.net, ismail@pardus.org.tr

> > Please move it into the kernel where it belongs, and use lcd
> > brightness subsystem like everyone else.
>
> We've been through this before.
> http://marc.theaimsgroup.com/?l=linux-kernel&m=114067198323596&w=2
>
> In addition, the SMI call used to change the backlight level *may*
> require (if configured by the sysadmin in BIOS), a password be
> entered.
>
> This begs for a common userspace app that can grok libsmbios and
> kernel interfaces both, and use the appropriate method on each, rather
> than just putting it all in the kernel

>From my understanding, a cute userspace App shouldn't have this kind
of logic:
	if (is  DELL )
		invoke libsmbios
	if (is  foo)
		invoke libfoo,
	if (is bar)
		invoke libbar,
	....
	else
		operate on /sys/class/backlight/ ,.,..

It should be:
	just write/read  file in  /sys/class/backlight ,....

Right?

Thanks,
Luming



