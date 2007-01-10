From: Neil Bird <neil@fnxweb.com>
Subject: Re: sonypc with Sony Vaio VGN-SZ1VP
Date: Wed, 10 Jan 2007 08:36:49 +0000
Message-ID: <45A4A5A1.9000800@fnxweb.com>
References: <49814.213.30.172.234.1159357906.squirrel@webmail.popies.net> <20070104191512.GC25619@inferi.kami.home> <459E1909.9020703@fnxweb.com> <200701051219.00509.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.uk.thalesgroup.com ([194.128.85.6]:1426 "EHLO
	crawsmail1.uk.thalesgroup.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964805AbXAJIhh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 10 Jan 2007 03:37:37 -0500
In-Reply-To: <200701051219.00509.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, malattia@linux.it

Around about 05/01/07 17:19, Len Brown typed ...
> running the AML interpreter in  interrupt context would be a no-no.
> I thought we had deferred the notify handlers so that they wouldn't
> run in interrupt context, but maybe there is a case here where
> that does not happen.

   Yes, I tracked though the kernel acpi code as much as I could, and found 
that I was making acpi calls that did kmalloc() with the 'wrong' arg. in a 
context that didn't allow it (where /proc reads would).

   Unfortunately, the solutions I tried (diff. ways of deferral using notify 
handlers) still failed, or at least stuffed it on boot (which is what my 
current code-base does).  The last code I traced was the bit that looked up 
the full ACPI ref. from a local ref., and that does a malloc, so I did the 
lookup at module init and stored that full string to bypass the lookup 
malloc later, but then it just goes wrong a bit later :-(

-- 
[neil@fnx ~]# rm -f .signature
[neil@fnx ~]# ls -l .signature
ls: .signature: No such file or directory
[neil@fnx ~]# exit
