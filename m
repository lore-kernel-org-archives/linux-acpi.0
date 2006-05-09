From: Berthold Cogel <cogel@rrz.uni-koeln.de>
Subject: Re: Was: Re: UBUNTU - acpi battery on ACER TRAVELMATE 4000 WLMI
Date: Wed, 10 May 2006 01:43:38 +0200
Message-ID: <4461292A.60607@rrz.uni-koeln.de>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005D98454@hdsmsx401.amr.corp.intel.com>	<m21wytlwv3.fsf@phoenix.squirrel.nl>	<4446C84B.7020104@rrz.uni-koeln.de>	<m23bg5ihym.fsf@phoenix.squirrel.nl>	<444BF809.3090000@rrz.uni-koeln.de> <m2hd4j2u3t.fsf@phoenix.squirrel.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out.rrz.uni-koeln.de ([134.95.19.53]:16784 "EHLO
	smtp-out.rrz.uni-koeln.de") by vger.kernel.org with ESMTP
	id S932229AbWEIXoP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 9 May 2006 19:44:15 -0400
In-Reply-To: <m2hd4j2u3t.fsf@phoenix.squirrel.nl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Johan Vromans <jvromans@squirrel.nl>
Cc: linux-acpi@vger.kernel.org

Johan Vromans wrote:
> 
>> I'm not sure if I can do the test before May, but I try.
> 
> Okay, I've packed it up with the rest of Rich' sources in what I've
> shamelessly called acpi_sbs-20060422. You can fetch it from
> http://www.squirrel.nl/pub/xfer/acpi_sbs-20060422.tar.bz2
> 
> Remember -- use at your own risk. I merely removed the code that
> didn't compile... But it seems to work for me.
> 
> -- Johan

Hello Johan,

the modules work great. Without a patched DSDT. Just out of the box.

But there are still some minor flaws. I got some warnings during compile
with kernel 2.6.16.13:

  CC [M]  /usr/src/acpi_sbs-20060422/i2c-acpi-ec.o
/usr/src/acpi_sbs-20060422/i2c-acpi-ec.c: In function 'acpi_ec_smb_access':
/usr/src/acpi_sbs-20060422/i2c-acpi-ec.c:144: warning: 'len' may be used
uninitialized in this function
/usr/src/acpi_sbs-20060422/i2c-acpi-ec.c:144: warning: 'temp[0]' may be
used uninitialized in this function
/usr/src/acpi_sbs-20060422/i2c-acpi-ec.c:144: warning: 'temp[1]' may be
used uninitialized in this function

And the Makefile installed the modules in the root filesystem. I used a
Makefile from an older version of Rich's package, which did the job.
I've attached the file.


It would be nice to have this in the kernel.

I don't know if it is possible to merge the ac-adapter/battery part of
the modules with the corresponding kernel modules (to provide the legacy
interfaces ?).
The code could then be switched with a configuration option, which also
enables the rest of the code in additional modules (acpi_sbs, i2c_acpi_ec).

This would simplify the configuration and reduces the need to read the
kernel docs. ;-)


Regards,

Berthold
