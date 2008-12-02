From: Mark Lord <lkml@rtr.ca>
Subject: Re: [rtc-linux] Re: PATCH: /proc/acpi/alarm: handle day-of-month
 wraparound on readback
Date: Tue, 02 Dec 2008 13:57:06 -0500
Message-ID: <49358502.9090000@rtr.ca>
References: <200806222042.13929.david-b@pacbell.net>	<4934176F.6080900@rtr.ca>	<alpine.LFD.2.00.0812011311490.3197@localhost.localdomain>	<49346212.3050102@rtr.ca> <20081201233210.598f2dcf@i1501.lan.towertech.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:46402 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754196AbYLBSz5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 2 Dec 2008 13:55:57 -0500
In-Reply-To: <20081201233210.598f2dcf@i1501.lan.towertech.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alessandro Zummo <alessandro.zummo@towertech.it>
Cc: rtc-linux@googlegroups.com, Len Brown <lenb@kernel.org>, Alessandro Zummo <a.zummo@towertech.it>, David Brownell <david-b@pacbell.net>, lkml <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org

Alessandro Zummo wrote:
> On Mon, 01 Dec 2008 17:15:46 -0500
> Mark Lord <lkml@rtr.ca> wrote:
> 
>> Yeah.. bit of a nuisance that.
>> I regularly apply this patch to my own kernels:
> 
>  While it will certainly work, maybe it's time to switch
>  to /sys/class/rtc/rtcX/wakealarm . 
..

Perhaps, but doing so would still leave the but in /proc/acpi/alarm,
so we need to fix it regardless.

Cheers
