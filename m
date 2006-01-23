From: Vernon Mauery <vernux@us.ibm.com>
Subject: Re: t41, suspend on ram, power consumption
Date: Mon, 23 Jan 2006 09:19:33 -0800
Message-ID: <43D51025.1010202@us.ibm.com>
References: <20060113095634.GA7112@mnementh.homelinux.org> <20060113101638.12055.qmail@web81607.mail.mud.yahoo.com> <20060117203732.GC24179@message-id.gmane0305.slipkontur.de> <20060119105001.GE2154@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:21477 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S964826AbWAWRRs
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 23 Jan 2006 12:17:48 -0500
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e34.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id k0NHHmg0016945
	for <linux-acpi@vger.kernel.org>; Mon, 23 Jan 2006 12:17:48 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VERS6.8) with ESMTP id k0NHG4gL254544
	for <linux-acpi@vger.kernel.org>; Mon, 23 Jan 2006 10:16:04 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k0NHHmEl010338
	for <linux-acpi@vger.kernel.org>; Mon, 23 Jan 2006 10:17:48 -0700
Received: from [9.47.17.76] (bluecat.beaverton.ibm.com [9.47.17.76])
	by d03av02.boulder.ibm.com (8.12.11/8.12.11) with ESMTP id k0NHHlXU010295
	for <linux-acpi@vger.kernel.org>; Mon, 23 Jan 2006 10:17:47 -0700
In-Reply-To: <20060119105001.GE2154@poupinou.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Bruno Ducrot wrote:
> On Tue, Jan 17, 2006 at 09:37:32PM +0100, Stefan Seyfried wrote:
> 
>>>Additionally, you probably want to consider the suspend2 kernel patch
>>>series from http://www.suspend2.net/ to allow for reliably shutting the
>>>system off without losing state and storing memory into your swap
>>>partition or a file.
>>
>>Has nothing to do at all with suspend to ram and the power consumption
>>when suspended.
> 
> 
> I'm not sure you are right with that claim.  There may be some code
> onto suspend2 patches that may help improve suspend/resume devices that
> are not yet merged to mainline.  I don't think however this fill fix
> the thinkpad problem of the OP though.

See "S3: high power consumption - Thinkpad T40/T41"
http://bugme.osdl.org/show_bug.cgi?id=3022

They have a patch that applies to the mainline kernel and fixes the problem.  It
is a video problem.  If the patch doesn't work immediatly for you, you might
have to add video=radeonfb:force_sleep=1 to the kernel command line and then add
your machine's dmi data to the whitelist.  The whitelist is pretty big by now,
though, so you may already be covered.

--Vernon

> 
> It's actually more or less a guess since I have not looked actually to
> the suspend2 code.
> 

