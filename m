From: Johan Vromans <jvromans@squirrel.nl>
Subject: Re: Was: Re: UBUNTU - acpi battery on ACER TRAVELMATE 4000 WLMI
Date: Fri, 21 Apr 2006 11:30:53 +0200
Message-ID: <m2k69ji8c2.fsf@phoenix.squirrel.nl>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005D98454@hdsmsx401.amr.corp.intel.com>
	<m21wytlwv3.fsf@phoenix.squirrel.nl>
	<4446C84B.7020104@rrz.uni-koeln.de>
	<m2vet41q9n.fsf@phoenix.squirrel.nl>
	<44480F0B.5020106@rrz.uni-koeln.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-vbr11.xs4all.nl ([194.109.24.31]:29970 "EHLO
	smtp-vbr11.xs4all.nl") by vger.kernel.org with ESMTP
	id S1751141AbWDUJa7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 21 Apr 2006 05:30:59 -0400
In-Reply-To: <44480F0B.5020106@rrz.uni-koeln.de> (Berthold Cogel's message
 of "Fri, 21 Apr 2006 00:45:31 +0200")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Berthold Cogel <cogel@rrz.uni-koeln.de>
Cc: Johan Vromans <jvromans@squirrel.nl>, linux-acpi@vger.kernel.org

Berthold Cogel <cogel@rrz.uni-koeln.de> writes:

> Johan Vromans wrote:
>> https://sourceforge.net/project/showfiles.php?group_id=129330
>
> Thanks! I've overlooked the patches at Sourceforge.
> Is there any chance to get the patch into the kernel somehow?

There are two patches required. One patch is to allow a
custom-supplied DSDT in initrd. This is a harmless patch that would be
very nice to have in the kernel, and the feature could even be enabled
by default[1]. Several distro's already do this.

The other patch (I'm replying for Rich now, so don't point _me_ down
on the deeper details) concerns the use of a semaphore instead of spin
lock in ec. This is to overcome loss of interrupts while reading out
the bus. There has been much debate about this patch, and it can be
argued that it implements the right solution. (It does the job,
though.)

But the best solution would be to have a kernel module that deals with
this kind of smart batttery subsystems, and provide the correct
information for userland (hal?) to react upon. This is basically the
original approach taken by Pedro Venda, Bruno Ducrot and completed for
2.6.10 (or so) by Rich Townsend[2]. Unfortunately, recent changes to
the i2c drivers conflict with the changes required for this approach,
and I haven't been able to find out how to modify the patches for the
2.6.16 kernel. (Help appreciated.)

-- Johan

[1] For my Acer Travelmate 4001WLMi I need to supply a custom DSDT
    anyway, since some of the original DSDT data is just wrong...
[2] http://shayol.bartol.udel.edu/~rhdt/download/acpi_sbs-20050120.tar.gz
