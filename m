From: Brad Campbell <brad@fnarfbargle.com>
Subject: Re: [PATCH] ACPI/sbshc: Add 5us delay to fix SBS hang on MacBook
Date: Mon, 18 May 2015 10:20:33 +0800
Message-ID: <55594C71.9060402@fnarfbargle.com>
References: <20150424012530.GA16763@localhost> <4435249.leKkNHm9IZ@vostro.rjw.lan> <20150429202140.GB25904@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns3.fnarfbargle.com ([103.4.17.7]:38986 "EHLO
	ns3.fnarfbargle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751051AbbERChk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 17 May 2015 22:37:40 -0400
In-Reply-To: <20150429202140.GB25904@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Chris Bainbridge <chris.bainbridge@gmail.com>
Cc: linux-acpi@vger.kernel.org

On 30/04/15 04:21, Chris Bainbridge wrote:
>
> Supporting _OSI("Darwin") caused the MacBook firmware to expose the SBS,
> resulting in intermittent hangs of several minutes on boot, and failure
> to detect or report the battery. Fix this by adding a 5us delay to the
> start of each SMBUS transaction. This timing is the result of
> experimentation - hangs were observed with 3us but never with 5us.

G'day Chris,

Using 4.1-rc3 (whatever git head was from a couple of days ago) I've 
still been seeing ACPI lockups on my Macbook Pro (11,1). It appears to 
take a couple of suspend/resume cycles but seems to happen within 24 
hours of booting whereas before this patch it was easy to hit.

As a test (and I do wonder if it'll lock up after I press send on this 
E-mail) I upped the delay to 10us and I've now been up for 1 day, 17:23 
with the battery still responding to polling.

To make it easier to reproduce, I've been running a script that polls 
the battery every 60 seconds.

I figure I'll let it go for another couple of days, but I wanted to put 
this out there in case anyone else is seeing lockups after a longer 
period of uptime. The symptoms are the ACPI command just hangs as does 
'cat /sys/class/power_supply/BAT0/status'. From there I can't suspend as 
the tasks can't be frozen and I just end up hard booting the machine.

I've removed Len & Rafael from the cc.

Regards,
Brad
