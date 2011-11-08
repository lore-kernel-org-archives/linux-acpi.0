From: Stephen Dunn <nzlbob2332@gmail.com>
Subject: Re: Boot fails on Thinkpad L420 without ACPI=off or nosmp
Date: Tue, 08 Nov 2011 23:12:19 +1300
Message-ID: <1496066.Ip6pz3h4UQ@linux-9am5.site>
References: <7377461.xUP08Ft1Zz@linux-9am5.site> <4EB822DB.2030808@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:39898 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750878Ab1KHKM0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Nov 2011 05:12:26 -0500
Received: by gyc15 with SMTP id 15so366662gyc.19
        for <linux-acpi@vger.kernel.org>; Tue, 08 Nov 2011 02:12:25 -0800 (PST)
In-Reply-To: <4EB822DB.2030808@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

Hi Len, thanks so much for your reply.

In response I can report:
1. System boots fine using noapic option.
2. System fails to boot normally using Fedora with kernel 2.6.38

Thanks
Regards
Steve

On Mon, 07 Nov 2011 13:26:35 Len Brown wrote:
> Hi Steve,
> 
> Thanks for the report.
> 
> > OS Information
> > OS:  Linux 3.1.0-rc9-1-desktop x86_64
> > System:  openSUSE 12.1 RC 1 (x86_64)
> > KDE:  4.7.2 (4.7.2)
> > 
> > Hardware Information
> > Lenovo Thinkpad L420 Model number 78544KM
> > i5-2520M(2.50GHz)
> > Intel HD Graphics
> > 
> > Problem
> > Fails to boot without boot option of either acpi=off, nosmp, or
> > maxcpus=0
> 
> How about simply "noapic"
> 
> or if that fails, then:
> 
> maxcpus=1, noapic
> 
> That should get you up in ACPI mode, but w/ the IOAPIC disabled.
> 
> > Almost immediately freezes. CapsLock does not work and only way to
> > continue is to power off with the power button.
> > 
> > With debug on last line of output reads:
> > ACPI: CE: Look up EC in DSDT
> > 
> > Fails with kernel 3.04 and 3.1 and all distro's I have tried with.
> 
> have you tried any distros that are running a kernel older than 3.04?
> 
> thanks,
> -Len
