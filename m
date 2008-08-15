From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: Re: How do I do an acpidump
Date: Fri, 15 Aug 2008 20:22:43 +0100
Message-ID: <48A5D783.2050007@tuffmail.co.uk>
References: <200808151841.22788.c_lauire@mypostoffice.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ik-out-1112.google.com ([66.249.90.182]:2804 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757573AbYHOTWv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 15 Aug 2008 15:22:51 -0400
Received: by ik-out-1112.google.com with SMTP id c28so1111185ika.5
        for <linux-acpi@vger.kernel.org>; Fri, 15 Aug 2008 12:22:49 -0700 (PDT)
In-Reply-To: <200808151841.22788.c_lauire@mypostoffice.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Colin Laurie <c_lauire@mypostoffice.co.uk>
Cc: linux-acpi@vger.kernel.org

Colin Laurie wrote:
> Hello there you may/may not be interested in this:
>
>
> Aug 15 16:18:48 linux-gidt kernel: Clocksource tsc unstable (delta = -124697887 ns)
> Aug 15 16:18:48 linux-gidt kernel: nf_conntrack version 0.5.0 (16384 buckets, 65536 max)
> Aug 15 16:18:50 linux-gidt kernel: ACPI Exception (thermal-0458): AE_ERROR, ACPI thermal trip point 
> state changed
> Aug 15 16:18:50 linux-gidt kernel: Please send acpidump to linux-acpi@vger.kernel.org
> Aug 15 16:18:50 linux-gidt kernel:  [20070126]
> Aug 15 16:18:50 linux-gidt powersaved[2326]: WARNING (continueEvent:250) Could not execute program 
> /usr/lib/powersave/scripts for event daemon.scheme.change: No such file or directory
> Aug 15 16:19:06 linux-gidt nm-dispatcher.action: Script '/etc/NetworkManager/dispatcher.d/autofs' 
> exited with error status 1.
> Aug 15 16:19:07 linux-gidt ntpd[2492]: unable to bind to wildcard socket address 0.0.0.0 - another 
> process may be running - EXITING
> Aug 15 16:19:07 linux-gidt nm-dispatcher.action: Script '/etc/NetworkManager/dispatcher.d/nfs' 
> exited with error status 2.
> Aug 15 16:19:49 linux-gidt python: hp-systray(init)[2691]: warning: No hp: or hpfax: devices found 
> in any installed CUPS queue. Exiting.
> Aug 15 16:22:03 linux-gidt smartd[3144]: Problem creating device name scan list
> Aug 15 17:52:28 linux-gidt kernel: hub 6-0:1.0: unable to enumerate USB device on port 5
> Aug 15 17:52:29 linux-gidt hp: io/hpmud/pp.c 627: unable to read device-id ret=-1
>   

As a quick answer to your subject:

    Previously spelled acpidmp, acpidump it is now included in many
    Linux distributions. If not, you can get the latest version from the
    latest pmtools package on this page.

<http://www.lesswatts.org/projects/acpi/utilities.php>

It's a pity Google doesn't know about this page.  (It finds individual
tarballs, distribution specific packages, man pages etc.).  I submitted
the URL on their feedback form on the off-chance they actually read it :-).

Alan
