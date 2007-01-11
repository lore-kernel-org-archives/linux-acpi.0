From: Neil Bird <neil.bird@uk.thalesgroup.com>
Subject: Re: sonypc with Sony Vaio VGN-SZ1VP  [repost]
Date: Thu, 11 Jan 2007 12:20:55 +0000
Message-ID: <45A62BA7.1090500@uk.thalesgroup.com>
References: <49814.213.30.172.234.1159357906.squirrel@webmail.popies.net> <20070104191512.GC25619@inferi.kami.home> <459E1909.9020703@fnxweb.com> <200701051219.00509.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.uk.thalesgroup.com ([194.128.85.6]:3943 "EHLO
	crawsmail1.uk.thalesgroup.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030301AbXAKMjS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 11 Jan 2007 07:39:18 -0500
Received: from mail.uk.thalesgroup.com (lisc0021.int.rdel.co.uk) by crawsmail1.uk.thalesgroup.com
 (Content Technologies SMTPRS 4.3.14) with ESMTP id <T7d1d83525bc0a85c02584@crawsmail1.uk.thalesgroup.com> for <linux-acpi@vger.kernel.org>;
 Thu, 11 Jan 2007 12:20:57 +0000
Received: from ntscxch1.int.rdel.co.uk (ntscxch1.int.rdel.co.uk [172.21.100.149])
	by mail.uk.thalesgroup.com (8.12.8/8.12.8) with ESMTP id l0BCKvq9019565
	for <linux-acpi@vger.kernel.org>; Thu, 11 Jan 2007 12:20:57 GMT
In-Reply-To: <200701051219.00509.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


   [orig. quietly didn't make it to the list for some reason]

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

