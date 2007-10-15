From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: Hibernate shuts off comp but shutdown now -h doesn't
Date: Mon, 15 Oct 2007 17:25:12 +0400
Message-ID: <47136A38.2010100@gmail.com>
References: <ecf35a1b0710140626x214f02c8vd470eb1d76d4264b@mail.gmail.com>	 <200710142212.08394.rjw@sisk.pl>	 <ecf35a1b0710150220y48415a21i3053ba521be8ab98@mail.gmail.com>	 <200710151253.33210.rjw@sisk.pl> <ecf35a1b0710150558i335c1edbq81431e4de03573@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:34805 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760373AbXJONZX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 15 Oct 2007 09:25:23 -0400
Received: by ug-out-1314.google.com with SMTP id z38so873089ugc
        for <linux-acpi@vger.kernel.org>; Mon, 15 Oct 2007 06:25:21 -0700 (PDT)
In-Reply-To: <ecf35a1b0710150558i335c1edbq81431e4de03573@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: dev <dev.akhawe@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org

dev wrote:
>> So, the monitor goes blank, but the PSU is not turned off?
PSU is power-supply unit, this is metal box with bunch of colored 
wires sitting in the corner of your computer case.
It converts AC from wall outlet into DC used by computer internals.
> Yes exactly. processor is also ON, I can hear it.
You can't hear processor, it is not mechanical thing. You probably hear _fan_
on top of the processor, used to cool it.
> 
>> Is this possible to use serial console on this box?
> 
> What do you mean? I was hoping to know where everything is logged by
> the kernel!
> 
> ofcourse I later realised that as the fs is remounted readonly before
> remount , no logging to disk is possible . :)
> 
> 
> I don't know what you mean by serial console ...
He means that if your computer has serial port (9 or 25 pin D-shaped), 
and you have one more computer with such serial port nearby, you could 
connect them and have first computer do output over serial connection 
to second one, which will act as "serial console" in such case. As 
second computer does not powered-off then first one does, it is possible to see 
log of powering-off first computer on a second one. 

Regards,
Alex. 
