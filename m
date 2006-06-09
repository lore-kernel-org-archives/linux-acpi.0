From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: ACPI for Kernel 2.4.2-2
Date: Fri, 9 Jun 2006 09:36:01 -0600
Message-ID: <200606090936.01997.bjorn.helgaas@hp.com>
References: <002201c68bb2$a7a9cb00$6018450a@michaelyeo>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel6.hp.com ([156.153.255.205]:65431 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S1030214AbWFIPgM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jun 2006 11:36:12 -0400
In-Reply-To: <002201c68bb2$a7a9cb00$6018450a@michaelyeo>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: michaelyeo@stee.stengg.com
Cc: linux-acpi@vger.kernel.org

On Friday 09 June 2006 04:51, Michael Yeo wrote:
> I am using a old Redhat 7.1 on a new motherboard which uses ACPI. Do you
> have an ACPI patch for kernel 2.4.2-2? I searched the ACPI4LINUX download
> page but couldn't find one for my kernel. 
> 
> Hope you can provide me the patch or the link.

The oldest patch I see here:
  ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/
is a test patch for 2.4.22.  I think you're out of luck for 2.4.2-2.
Why do you want to run such an old kernel anyway?

I would think there's a good chance plain Red Hat 7.1 might work
on your new motherboard, even without ACPI.  But you should
consider a newer kernel, for security fixes if nothing else.

Bjorn
