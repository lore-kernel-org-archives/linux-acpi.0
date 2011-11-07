From: Len Brown <lenb@kernel.org>
Subject: Re: Boot fails on Thinkpad L420 without ACPI=off or nosmp
Date: Mon, 07 Nov 2011 13:26:35 -0500
Message-ID: <4EB822DB.2030808@kernel.org>
References: <7377461.xUP08Ft1Zz@linux-9am5.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vw0-f66.google.com ([209.85.212.66]:39214 "EHLO
	mail-vw0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753653Ab1KGS0i (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Nov 2011 13:26:38 -0500
Received: by vws3 with SMTP id 3so894405vws.1
        for <linux-acpi@vger.kernel.org>; Mon, 07 Nov 2011 10:26:37 -0800 (PST)
In-Reply-To: <7377461.xUP08Ft1Zz@linux-9am5.site>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Stephen Dunn <nzlbob2332@gmail.com>
Cc: linux-acpi@vger.kernel.org

Hi Steve,

Thanks for the report.

> OS Information
> OS:  Linux 3.1.0-rc9-1-desktop x86_64
> System:  openSUSE 12.1 RC 1 (x86_64)
> KDE:  4.7.2 (4.7.2)
> 
> Hardware Information
> Lenovo Thinkpad L420 Model number 78544KM
> i5-2520M(2.50GHz)
> Intel HD Graphics
> 
> Problem
> Fails to boot without boot option of either acpi=off, nosmp, or maxcpus=0

How about simply "noapic"

or if that fails, then:

maxcpus=1, noapic

That should get you up in ACPI mode, but w/ the IOAPIC disabled.

> Almost immediately freezes. CapsLock does not work and only way to continue is 
> to power off with the power button.
> 
> With debug on last line of output reads:
> ACPI: CE: Look up EC in DSDT
> 
> Fails with kernel 3.04 and 3.1 and all distro's I have tried with.

have you tried any distros that are running a kernel older than 3.04?

thanks,
-Len
