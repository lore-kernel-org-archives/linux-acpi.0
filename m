From: marco <marco@metm.org>
Subject: Re: suspend kills serial wacom tablet
Date: Wed, 18 Apr 2007 18:13:11 -0400
Message-ID: <462697F7.3060507@metm.org>
References: <pan.2007.02.20.13.52.07.111117@metm.org> <200704161510.18246.bjorn.helgaas@hp.com> <d120d5000704161418w7603e760wb34b90d8e3974537@mail.gmail.com> <200704181600.47561.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns.metm.org ([64.81.200.243]:44931 "EHLO mail.metm.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754090AbXDRWNM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 18 Apr 2007 18:13:12 -0400
In-Reply-To: <200704181600.47561.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-acpi@vger.kernel.org

Bjorn Helgaas wrote:
> On Monday 16 April 2007 15:18, Dmitry Torokhov wrote:
>   
>> As far as I understand Marco has a serial Wacom table. There is no
>> in-kernel driver for serial wacoms, they are handled entirely in
>> userspace (X).
>>     
>
> Duh.  Thanks for straightening me out.  If I'd bothered to read the
> subject line, I would have been much less confused :-)
>
> Marco, since the kernel correctly detects your serial port, you should
> not need "setserial."
>
> I'm curious about the hang you saw when doing "cat /dev/ttyS0".  I
> would expect the "cat" to block until the tablet sends data.  But
> it should not affect the rest of the system, and you should be able
> to kill the "cat."  Are you observing something different?
>   
Thank you all for keeping an interest in this issue,

Yes.  I am using my laptop right now, and as it has gone to sleep, so 
the pen tablet does not work.

When I "cat /dev/ttyS0"  and move the pen on the tablet there is no 
output.  I do not get the hang that I reported before.  I apologize if 
that was erroneous but I definitely remember the laptop hanging.  Anyway 
now, I  can  ^C  and get out of the  cat.

I promise to run the tests with the new kernel and the debug lines that 
Dimitry asked for very soon.

-- 
Marco
