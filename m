From: "Andrew Nelless" <andrew@nelless.net>
Subject: Re: 2.6.21-rc1: framebuffer/console boot failure
Date: Sun, 25 Feb 2007 11:07:45 -0000 (GMT)
Message-ID: <34578.86.7.220.119.1172401665.squirrel@wmbeta.mxes.net>
References: <35472.86.7.220.119.1172237750.squirrel@wmbeta.mxes.net>
    <20070224030950.074f88d4.akpm@linux-foundation.org>
    <33525.86.7.220.119.1172358010.squirrel@wmbeta.mxes.net>
    <1172359843.4415.8.camel@daplas>
Reply-To: "Andrew Nelless" <andrew@nelless.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mxout-03.mxes.net ([216.86.168.178]:2048 "EHLO
	mxout-03.mxes.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751030AbXBYLHq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 25 Feb 2007 06:07:46 -0500
In-Reply-To: <1172359843.4415.8.camel@daplas>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: "Antonino A. Daplas" <adaplas@gmail.com>

On Sat, February 24, 2007 11:30 pm, Antonino A. Daplas wrote:
>
> How about booting with just vga=normal?
>
>
> Tony
>

That seems to work too. I've rebooted about 20 times in a row
and it hasn't done it again yet. Why would this only occur
at higher modes?

In the 2.6.20 dmesg log it reads "Nvidia board detected.
Ignoring ACPI timer override." whereas in 2.6.21-rc1 it doesn't.
Could this be the culprit?

Andrew

