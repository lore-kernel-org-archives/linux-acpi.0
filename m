From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: RE: [PATCH][BUTTON] remove procfs-interface
Date: Thu, 12 Jul 2007 17:46:52 +0800
Message-ID: <823A93EED437D048963A3697DB0E35DE7314AB@pdsmsx414.ccr.corp.intel.com>
References: <4695F726.7030203@nachtwindheim.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:13798 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755796AbXGLJq7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Jul 2007 05:46:59 -0400
Content-class: urn:content-classes:message
In-Reply-To: <4695F726.7030203@nachtwindheim.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henne <henne@nachtwindheim.de>, Arjan van de Ven <arjan@infradead.org>
Cc: "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org

Well, the ACPI sysfs conversion is not finished yet
and some user space tools still use the ACPI procfs.
The schedule of removing ACPI procfs I/F will be changed to Jan 08.
I'm about to send a patch to update it.

I'm not sure if the button sysfs I/F is already finished.
We'd better make a double check. :)

Thanks,
Rui

-----Original Message-----
=46rom: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vger.=
kernel.org] On Behalf Of Henne
Sent: 2007=C4=EA7=D4=C212=C8=D5 17:41
To: Arjan van de Ven
Cc: Brown, Len; linux-acpi@vger.kernel.org; akpm@linux-foundation.org; =
linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ACPI][BUTTON] remove procfs-interface

Arjan van de Ven wrote:

> On Thu, 2007-07-12 at 10:58 +0200, Henne wrote:
>  =20
>> Removes the proc_fs interface from the ACPI button driver.
>> Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>
>>
>> ---
>>    =20
>
> you forgot to say why.....
>
>
>  =20
=46irst, because refering to /Documentation/feature-removal-schedule.tx=
t it should be done:

>What:   /proc/acpi/button
>When:   August 2007
>Why:    /proc/acpi/button has been replaced by events to the input lay=
er
>        since 2.6.20.
>Who:    Len Brown <len.brown@intel.com>

Second, refering to /Documentation/feature-removal-schedule.txt
=20
>What:   ACPI procfs interface
>When:   July 2007
>Why:    After ACPI sysfs conversion, ACPI attributes will be duplicate=
d
>        in sysfs and the ACPI procfs interface should be removed.
>Who:    Zhang Rui <rui.zhang@intel.com>

The button driver uses acpi_root_dir which won't be available if acpi i=
s removed this month.
That would lead to errors, I think.



-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
