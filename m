From: Cyrill Gorcunov <gorcunov@gmail.com>
Subject: Re: [patch 1/5] x86: ACPI - add checking for NULL early param
Date: Tue, 22 Jul 2008 14:19:45 +0400
Message-ID: <20080722101945.GA6699@lenovo>
References: <20080705115334.892720771@gmail.com> <486f61a9.2135440a.0d16.ffffbd7f@mx.google.com> <20080722025332.afddd49b.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.190]:52423 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752921AbYGVKTw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 22 Jul 2008 06:19:52 -0400
Received: by nf-out-0910.google.com with SMTP id d3so632643nfc.21
        for <linux-acpi@vger.kernel.org>; Tue, 22 Jul 2008 03:19:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080722025332.afddd49b.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: mingo@elte.hu, hpa@zytor.com, tglx@linutronix.de, andi@firstfloor.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

[Andrew Morton - Tue, Jul 22, 2008 at 02:53:32AM -0700]
| On Sat, 05 Jul 2008 15:53:35 +0400 Cyrill Gorcunov <gorcunov@gmail.com> wrote:
| 
| > Signed-off-by: Cyrill Gorcunov <gorcunov@gmail.com>
| > ---
| > 
| > Index: linux-2.6.git/drivers/acpi/tables.c
| > ====================================================================
| > --- linux-2.6.git.orig/drivers/acpi/tables.c	2008-01-21 23:14:47.000000000 +0300
| > +++ linux-2.6.git/drivers/acpi/tables.c	2008-07-05 12:24:16.000000000 +0400
| > @@ -300,6 +300,8 @@ int __init acpi_table_init(void)
| >  
| >  static int __init acpi_parse_apic_instance(char *str)
| >  {
| > +	if (!str)
| > +		return -EINVAL;
| >  
| >  	acpi_apic_instance = simple_strtoul(str, NULL, 0);
| >  
| 
| Could you please explain this patch?
| 

we could get NULL deref here - if you start kernel as

	qemu-system-x86_64 -kernel arch/x86/boot/bzImage -append "root=/dev/sda acpi_apic_instance" ../images/root-j

so user was not carried about correct boot option and the kernel respond by
hang - which is not good I think. Actually - by the patch we easy protect
ourself from user-madness :)

		- Cyrill -
