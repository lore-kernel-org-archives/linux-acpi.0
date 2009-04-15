From: Brice Goglin <Brice.Goglin@ens-lyon.org>
Subject: Re: Linux 2.6.30-rc2
Date: Wed, 15 Apr 2009 09:43:06 +0200
Message-ID: <49E5900A.6060807@ens-lyon.org>
References: <alpine.LFD.2.00.0904141628570.4132@localhost.localdomain>	 <49E57CEA.1020401@ens-lyon.org>	 <1239780780.5564.130.camel@localhost.localdomain> <1239781316.7661.356.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:56043 "EHLO
	mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752443AbZDOHm7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 15 Apr 2009 03:42:59 -0400
In-Reply-To: <1239781316.7661.356.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: yakui_zhao <yakui.zhao@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Zhang Rui wrote:
> On Wed, 2009-04-15 at 15:33 +0800, yakui_zhao wrote:
>   
>> On Wed, 2009-04-15 at 14:21 +0800, Brice Goglin wrote:
>>     
>>> CC [M]  drivers/acpi/video.o
>>>   <no warning>
>>>   ...
>>>   LD      .tmp_vmlinux1
>>> drivers/built-in.o: In function `intel_opregion_init':
>>> (.text+0x813e2): undefined reference to `acpi_video_register'
>>> make: *** [.tmp_vmlinux1] Error 1
>>>       
>> Will you please try the patch in the comment #16/#21 of 
>> http://bugzilla.kernel.org/show_bug.cgi?id=13065 ?
>>
>>     
> you must mean http://bugzilla.kernel.org/show_bug.cgi?id=13048 .
>
> Brice,
> we already have two patches to fix this issue, but they're still under
> discussion http://marc.info/?l=linux-acpi&m=123967821529829&w=2
>   

Ok good, thanks. I'll disable ACPI_VIDEO for now.

Brice

