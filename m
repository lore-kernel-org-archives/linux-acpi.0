From: Stephen Dunn <nzlbob2332@gmail.com>
Subject: Boot fails on Thinkpad L420 without ACPI=off or nosmp
Date: Wed, 02 Nov 2011 12:12:29 +1300
Message-ID: <7377461.xUP08Ft1Zz@linux-9am5.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:47907 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755056Ab1KAXMb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Nov 2011 19:12:31 -0400
Received: by ywf7 with SMTP id 7so2737818ywf.19
        for <linux-acpi@vger.kernel.org>; Tue, 01 Nov 2011 16:12:30 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello all

OS Information
OS:  Linux 3.1.0-rc9-1-desktop x86_64
System:  openSUSE 12.1 RC 1 (x86_64)
KDE:  4.7.2 (4.7.2)

Hardware Information
Lenovo Thinkpad L420 Model number 78544KM
i5-2520M(2.50GHz)
Intel HD Graphics

Problem
Fails to boot without boot option of either acpi=off, nosmp, or maxcpus=0

Almost immediately freezes. CapsLock does not work and only way to continue is 
to power off with the power button.

With debug on last line of output reads:
ACPI: CE: Look up EC in DSDT

Fails with kernel 3.04 and 3.1 and all distro's I have tried with.

Boots no problem with 32bit and with Windows 7

acpidump
https://docs.google.com/open?id=0B2IDfK0E8tJkMDFlYjM4MTEtNmM1Ni00ZGFkLTg2MzQtYTM2YTIyOWYzYmVm

Please let me know what other information I should provide.

Thank you

Regards
Steve
