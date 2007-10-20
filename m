From: "Rustom Mody" <rustompmody@gmail.com>
Subject: kacpid consumes 100% cpu
Date: Sat, 20 Oct 2007 22:11:02 +0530
Message-ID: <f46c52560710200941x77f4bf95h1f0a4a770d780acb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.190]:55110 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755512AbXJTQlD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 20 Oct 2007 12:41:03 -0400
Received: by rv-out-0910.google.com with SMTP id k20so756711rvb
        for <linux-acpi@vger.kernel.org>; Sat, 20 Oct 2007 09:41:02 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

I had an old P4 (1.2 GHz) box that was running debian etch fine.
Recently upgraded the motherboard to a duo core on a 945G chipset board.

Now if I start windows-XP and put it in standby mode and then restart
linux, linux becomes unusable with kacpid taking 100% cpu.  Starting
linux with kernel option acpi=off works and sometimes if it is
restarted without the option it keeps working and sometimes not.

Evidently windows standby leaves some state in the BIOS that linux
cant clean up/detect.  What??

The output of uname -vr is as follows:
2.6.22-2-686 #1 SMP Fri Aug 31 00:24:01 UTC 2007

Thanks

Rustom  Mody
