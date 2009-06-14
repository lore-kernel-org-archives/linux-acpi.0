From: "Tvrtko A. Ursulin" <tvrtko@ursulin.net>
Subject: Re: [2.6.30][regression] ACPI continuously logging errors and exceptions while reading DVD
Date: Sun, 14 Jun 2009 10:12:27 +0100
Message-ID: <200906141012.27676.tvrtko@ursulin.net>
References: <200906131244.45309.tvrtko@ursulin.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mk-outboundfilter-3.mail.uk.tiscali.com ([212.74.114.23]:2868
	"EHLO mk-outboundfilter-3.mail.uk.tiscali.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751260AbZFNJM2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 14 Jun 2009 05:12:28 -0400
In-Reply-To: <200906131244.45309.tvrtko@ursulin.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>

On Saturday 13 June 2009 12:44:45 Tvrtko A. Ursulin wrote:
> Hi,
>
> Just booted up 2.6.30 for the first time on this machine and found this
> problem.	Hope the attachment goes through because everything is in there.
> Log is shortened since errors are always the same and repeating constantly
> while DVD is in use.

Hm, I am not longer certain this was related to DVD access. At the time I was 
looking it may have been a wild coincidence, but after that I saw it at other 
times as well.

What also may be interesting, and what I have only now noticed, is that with a 
distro kernel (2.6.27.23-0.1-default, openSUSE 11.1), kacpid uses a lot of 
CPU time at also seemingly random intervals. So far in ~17 hours of uptime it 
accumulated 70 minutes of CPU time. When it is active it uses from 5-20% of 
it and load average shoots dramatically up:

USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root         9  6.9  0.0      0     0 ?        S<   Jun13  70:24 [kacpid]

 10:07am  up  16:49,  2 users,  load average: 2.56, 1.34, 0.80

Tvrtko
