From: Bret Hughes <bhughes@elevating.com>
Subject: Re: serial port discovery on a motion computing tablet
Date: Wed, 14 Mar 2007 09:29:05 -0500
Message-ID: <45F806B1.3060807@elevating.com>
References: <45F7688B.8000101@elevating.com> <20070314134323.GC1467@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from h186.102.16.72.ip.alltel.net ([72.16.102.186]:43989 "EHLO
	mail1.imperiumsolutions.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161292AbXCNO3V (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 14 Mar 2007 10:29:21 -0400
In-Reply-To: <20070314134323.GC1467@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org



Matthew Garrett wrote:
> On Tue, Mar 13, 2007 at 10:14:19PM -0500, Bret Hughes wrote:
>   
>> I am evaluating a motion computing LE1600 tablet for possible use with 
>> linux using Centos 4.4 since that is what we use for several servers and 
>> had the installation media handy.  This device uses a TouchKO serial 
>> touchscreen that has been used by linux in the past but the issue I am 
>> facing is that the bios does not expose the serial ports.  I spoke with 
>> an engineer at TouchKO familiar with the LE1600 project an he told me I 
>> would have to access the serial port via acpi.  Hmm says I, I guess I 
>> have some reading to do.  DO after a day or so of trying to get up to 
>> speed, I feel I can ask a fairly decent question or two. 
>>     
>
> It sounds like it ought to be exposed via ACPIPNP. If you do cat 
> /sys/bus/pnp/devices/*/id, do any of them look plausibly linked to the 
> tablet device? If so, add the id to drivers/serial/8250_pnp.c, build it, 
> see if that binds and gives you a serial port and if so send a patch.
>   
Thanks for the help.

nothing there:
[root@localhost serial]# ls -a /sys/bus/pnp/devices/
.  ..

nothing loaded in drivers either:
[root@localhost serial]# ls -Ra /sys/bus/pnp/drivers/
/sys/bus/pnp/drivers/:
.  ..  ide  parport_pc  serial  system

/sys/bus/pnp/drivers/ide:
.  ..

/sys/bus/pnp/drivers/parport_pc:
.  ..

/sys/bus/pnp/drivers/serial:
.  ..

/sys/bus/pnp/drivers/system:
.  ..


Is there a module I should load before this works? perhaps a kernel 
recompile with some additional modules are needed?

Now that I am back at the office and looking at the kernel .config via 
make xconfig I see that 8250/16550 device discovery via ACPI namespace 
(SERIAL_8250_ACPI) is not enabled.  Is is safe to assume that it should 
be (go ahead and groan, I probably would) anything else that should be 
included? 

I am going to enable it and start a compile.  I guess we will see what 
kind of horsepower this little dude has.

Thanks again,

Bret

