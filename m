From: Alan Jenkins <aj504@student.cs.york.ac.uk>
Subject: Re: [Bug #11841] plenty of line "ACPI: EC: non-query interrupt received,
 switching to interrupt mode" in dmesg
Date: Sun, 26 Oct 2008 10:29:46 +0000
Message-ID: <4904469A.2090803@tuffmail.co.uk>
References: <bqZlc-1BT-11@gated-at.bofh.it> <bqZuJ-22l-15@gated-at.bofh.it> <r6ljwccagm.fsf@skye.inf.phy.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:27010 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752361AbYJZK3w (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 26 Oct 2008 06:29:52 -0400
Received: by ug-out-1314.google.com with SMTP id 39so32030ugf.37
        for <linux-acpi@vger.kernel.org>; Sun, 26 Oct 2008 03:29:50 -0700 (PDT)
In-Reply-To: <r6ljwccagm.fsf@skye.inf.phy.cam.ac.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Francois Valenduc <francois.valenduc@tvcablenet.be>, linux acpi <linux-acpi@vger.kernel.org>

Sanjoy Mahajan wrote:
>> The following bug entry is on the current list of known regressions
>> from 2.6.27.
> 
>> Bug-Entry	: http://bugzilla.kernel.org/show_bug.cgi?id=11841
>> Subject : plenty of line "ACPI: EC: non-query interrupt received, switching to interrupt mode" in dmesg
> 
> I see these messages already with 2.6.27.3:
> 
>   # grep non-query /var/log/dmesg
>   [    0.205977] ACPI: EC: non-query interrupt received, switching to interrupt mode
> 
> There are 9 more occurrences in the current ring buffer:
>   # dmesg |grep non-query | wc -l
>   9
> 
> Each one happens right after waking from S3 sleep, for example:
> 
>   [70168.288590] CPU1 is up
>   [70168.288594] ACPI: Waking up from system sleep state S3
>   [70169.624254] ACPI: EC: non-query interrupt received, switching to interrupt mode
> 
> The setup is a TP T60 w/ Intel graphics, wireless (i.e. no taint),
> Debian unstable, but with vanilla kernel 2.6.27.3.
> 
> -Sanjoy

It's expected that you see that message on both boot and every wakeup from suspend.

If you look at the dmesg Francios' posted, his issue is that there are _floods_ of this message during boot.  That's not expected :).

Regards
Alan
