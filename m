From: "Maciej Rutecki" <maciej.rutecki@gmail.com>
Subject: [Re: Linux 2.6.28-rc1] ACPI Warning (nspredef-0852)[...]
Date: Sat, 25 Oct 2008 09:21:06 +0200
Message-ID: <8db1092f0810250021p70be6b62wdbb9a4c1c20c7a27@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.27]:18712 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751722AbYJYHVJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 25 Oct 2008 03:21:09 -0400
Received: by qw-out-2122.google.com with SMTP id 3so591135qwe.37
        for <linux-acpi@vger.kernel.org>; Sat, 25 Oct 2008 00:21:07 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org, fabio.comolli@gmail.com, "Rafael J. Wysocki" <rjw@sisk.pl>

During suspend to ram I have this message:

ACPI Warning (nspredef-0852): \_WAK: Return type mismatch - found
Integer, expected Package [20080926]

s2ram seems works OK

dmesg, acpidump:
http://unixy.pl/maciek/download/kernel/2.6.28-rc1_wak/

-- 
Maciej Rutecki
http://www.maciek.unixy.pl
