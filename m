From: Berthold Cogel <cogel@rrz.uni-koeln.de>
Subject: Re: Was: Re: UBUNTU - acpi battery on ACER TRAVELMATE 4000 WLMI
Date: Sat, 22 Apr 2006 20:02:45 +0200
Message-ID: <444A6FC5.7050705@rrz.uni-koeln.de>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005D98454@hdsmsx401.amr.corp.intel.com>	<m21wytlwv3.fsf@phoenix.squirrel.nl>	<4446C84B.7020104@rrz.uni-koeln.de>	<m2vet41q9n.fsf@phoenix.squirrel.nl>	<44480F0B.5020106@rrz.uni-koeln.de> <m2k69ji8c2.fsf@phoenix.squirrel.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out.rrz.uni-koeln.de ([134.95.19.53]:17563 "EHLO
	smtp-out.rrz.uni-koeln.de") by vger.kernel.org with ESMTP
	id S1750782AbWDVSCr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 22 Apr 2006 14:02:47 -0400
In-Reply-To: <m2k69ji8c2.fsf@phoenix.squirrel.nl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Johan Vromans <jvromans@squirrel.nl>

Johan Vromans wrote:
> Berthold Cogel <cogel@rrz.uni-koeln.de> writes:
> 
>> Johan Vromans wrote:
>>> https://sourceforge.net/project/showfiles.php?group_id=129330
>> Thanks! I've overlooked the patches at Sourceforge.
>> Is there any chance to get the patch into the kernel somehow?
> 
> There are two patches required. One patch is to allow a
> custom-supplied DSDT in initrd. This is a harmless patch that would be
> very nice to have in the kernel, and the feature could even be enabled
> by default[1]. Several distro's already do this.

I would appreciate this. I'm using this patch for my kernels. But there
seems to be a problem with the latest ACPI patches with at least kernel
2.6.16.9, which I tried yesterday.

linux-2.6.16.9
acpi-release-20060310-2.6.16.diff
acpi-dsdt-initrd-v0.8.1-2.6.16.patch


make bzImage

....

  LD      init/built-in.o
  LD      .tmp_vmlinux1
drivers/built-in.o: In function `acpi_find_dsdt_initrd':
(.text+0x2526d): undefined reference to `ACPI_MEM_ALLOCATE'
drivers/built-in.o: In function `acpi_find_dsdt_initrd':
(.text+0x252c8): undefined reference to `ACPI_MEM_FREE'
drivers/built-in.o: In function `acpi_tb_get_table_body':
(.text+0x3772e): undefined reference to `ACPI_MEM_FREE'
make: *** [.tmp_vmlinux1] Fehler 1

Building the kernel with the ACPI patches or with the initrd patch
works. But the combination .....

Seems that something has been changed in the ACPI patches.


> But the best solution would be to have a kernel module that deals with
> this kind of smart batttery subsystems, and provide the correct
> information for userland (hal?) to react upon. This is basically the
> original approach taken by Pedro Venda, Bruno Ducrot and completed for
> 2.6.10 (or so) by Rich Townsend[2]. Unfortunately, recent changes to

This was what I used in the first time with kernel 2.6.11 when I got my
notebook.

> the i2c drivers conflict with the changes required for this approach,
> and I haven't been able to find out how to modify the patches for the
> 2.6.16 kernel. (Help appreciated.)

I haven't been much of a software developer myself and my C is rusty. I
read LKML just out of curiosity. But I'm willing to do the testing part.

Berthold
