From: David Mohr <damailings@mcbf.net>
Subject: Re: Shutdown issues with Gigabyte A75M board: always reboots
Date: Mon, 28 Nov 2011 09:42:27 -0700
Message-ID: <1322498547.4462.7.camel@alucardo.nm.mcbf.net>
References: <1322497836.4462.5.camel@alucardo.nm.mcbf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from seeker.mcbf.net ([109.239.49.157]:44641 "EHLO seeker.mcbf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750878Ab1K1Qmh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 28 Nov 2011 11:42:37 -0500
Received: from [2001:1938:2d6:0:207:e9ff:fe49:762] (helo=alucardo.nm.mcbf.net)
	by seeker.mcbf.net with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <damailings@mcbf.net>)
	id 1RV4Hq-0005YR-QW
	for linux-acpi@vger.kernel.org; Mon, 28 Nov 2011 17:42:35 +0100
Received: from squisher by alucardo.nm.mcbf.net with local (Exim 4.77)
	(envelope-from <damailings@mcbf.net>)
	id 1RV4Hj-0001PR-Qo
	for linux-acpi@vger.kernel.org; Mon, 28 Nov 2011 09:42:27 -0700
In-Reply-To: <1322497836.4462.5.camel@alucardo.nm.mcbf.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

On Mon, 2011-11-28 at 09:30 -0700, David Mohr wrote:
> Hi folks,
> 
> I have an AMD CPU on a Gigabyte A75M board[0]. When I shut the computer
> off, either through gdm, or with 'shutdown -h now' on the cli, the
> computer turns off and then immediately on again. I would say there is a
> tiny delay in between which distinguishes it from a reboot.
> 
> The same thing happens when I go to standby - the computer immediately
> wakes up.
> 
> This is on 3.2-rc2. I have some infos attached to this email. Any help
> would be appreciated since this annoying problem has been with me for a
> while :-).
> 
> Thanks,
> ~David
> 
> P.S. If there is a better place to post this issue, please let me know.

[0]: http://www.gigabyte.us/products/product-page.aspx?pid=3928&#sp
