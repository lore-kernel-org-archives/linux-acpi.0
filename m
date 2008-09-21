From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: 2.6.27-rc6-git6: Reported regressions from 2.6.26
Date: Mon, 22 Sep 2008 01:57:35 +0400
Message-ID: <48D6C34F.8070700@gmail.com>
References: <PJz8fNrJNHG.A.65F.wzq1IB@albercik>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.188]:53305 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752369AbYIUV5b (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 21 Sep 2008 17:57:31 -0400
Received: by mu-out-0910.google.com with SMTP id g7so1072182muf.1
        for <linux-acpi@vger.kernel.org>; Sun, 21 Sep 2008 14:57:30 -0700 (PDT)
In-Reply-To: <PJz8fNrJNHG.A.65F.wzq1IB@albercik>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Natalie Protasevich <protasnb@gmail.com>, Kernel Testers List <kernel-testers@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Linux PM List <linux-pm@lists.linux-foundation.org>, Linux SCSI List <linux-scsi@vger.kernel.org>

Hi Rafael,
Correct patch is the one attached to bugzilla entry,
not the one you mention.

Regards,
Alex.

Rafael J. Wysocki wrote:
> Bug-Entry	: http://bugzilla.kernel.org/show_bug.cgi?id=11549
> Subject		: 2.6.27-rc5 acpi: EC Storm error message on bootup
> Submitter	: <jmerkey@wolfmountaingroup.com>
> Date		: 2008-09-02 21:27 (20 days old)
> References	: http://marc.info/?l=linux-kernel&m=122039255517586&w=4
> Handled-By	: Alexey Starikovskiy <astarikovskiy@suse.de>
> Patch		: http://marc.info/?l=linux-kernel&m=122098180019264&w=4
>   
