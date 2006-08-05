From: Alessandro Guido <alessandro.guido.box@gmail.com>
Subject: Re: Sony ACPI extras mainline inclusion
Date: Sat, 05 Aug 2006 12:43:45 +0200
Message-ID: <44D47661.8080000@gmail.com>
References: <44CB288A.1010702@gmail.com> <20060802100314.GF7601@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.190]:216 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751439AbWHEKmC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 5 Aug 2006 06:42:02 -0400
Received: by nf-out-0910.google.com with SMTP id k26so167206nfc
        for <linux-acpi@vger.kernel.org>; Sat, 05 Aug 2006 03:42:01 -0700 (PDT)
In-Reply-To: <20060802100314.GF7601@ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
>> I own a Sony VAIO laptop that uses ACPI for setting 
>> screen brightness
>> through the "2.6-sony_acpi4.patch" patch that has been 
>> living in -mm for a while.
>> I'd like this patch to be merged in mainline, so that I 
>> won't be forced anymore to patch
>> the kernel by hand or to use the -mm patchset.
>> Is there something that prevents this to happen?
> 
> Wrong interface?
> 
> Convert it to use /sys/class/backlight sysfs interface...
> 
> 						Pavel

Thank you for repling!

I found a patch that does it in the mailing list archives,
although I've not tested if it can be still applied correctly:

http://marc.theaimsgroup.com/?l=linux-acpi&m=113950408508944&w=2
