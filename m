From: Francis Russell <francis+lkml@unchartedbackwaters.co.uk>
Subject: Re: Spurious power button event on resume from hibernate
Date: Mon, 18 May 2009 03:44:26 +0100
Message-ID: <4A10CB8A.9030809@unchartedbackwaters.co.uk>
References: <4A0C8CA7.2020104@unchartedbackwaters.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.unchartedbackwaters.co.uk ([78.110.170.111]:55912 "EHLO
	smtp.unchartedbackwaters.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751580AbZERCo1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 17 May 2009 22:44:27 -0400
Received: from [192.168.0.2] (host86-132-27-178.range86-132.btcentralplus.com [86.132.27.178])
	by smtp.unchartedbackwaters.co.uk (Postfix) with ESMTPSA id 0B25D136AFC
	for <linux-acpi@vger.kernel.org>; Mon, 18 May 2009 03:44:28 +0100 (BST)
In-Reply-To: <4A0C8CA7.2020104@unchartedbackwaters.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Well, it's been a little while. Anyone have any ideas on the below?
Assuming it's related to the bug previously mentioned
(http://bugzilla.kernel.org/show_bug.cgi?id=6612) which it might not be
at all, it looks like the accepted patch in the bug report is clearing
an ACPI event which should never get generated in the first place? If
so, could the same thing be happening here?


> I have a Samsung R560 laptop running amd64 Debian testing with a
> 2.6.29.3 kernel compiled from vanilla sources. Upon resume from
> hibernate, it appears that the OS receives a power button event that
> causes the system to shut down. I've verified this the best I can by
> killing acpid then watching the output of /proc/acpi/event during
> hibernate (triggered by writing 'disk' to /sys/power/state).
> 
> This problem looked very similar to that discussed in another Bugzilla
> entry (http://bugzilla.kernel.org/show_bug.cgi?id=6612) so I had I
> extended the changes made by the patch in the obvious way to the S4
> state but it made no difference. Is this something the kernel should be
> handling? How can I debug this further?
