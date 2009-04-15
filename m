From: yakui_zhao <yakui.zhao@intel.com>
Subject: Re: Linux 2.6.30-rc2
Date: Wed, 15 Apr 2009 15:33:00 +0800
Message-ID: <1239780780.5564.130.camel@localhost.localdomain>
References: <alpine.LFD.2.00.0904141628570.4132@localhost.localdomain>
	 <49E57CEA.1020401@ens-lyon.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:11888 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751307AbZDOHbf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 15 Apr 2009 03:31:35 -0400
In-Reply-To: <49E57CEA.1020401@ens-lyon.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Brice Goglin <Brice.Goglin@ens-lyon.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Wed, 2009-04-15 at 14:21 +0800, Brice Goglin wrote:
> CC [M]  drivers/acpi/video.o
>   <no warning>
>   ...
>   LD      .tmp_vmlinux1
> drivers/built-in.o: In function `intel_opregion_init':
> (.text+0x813e2): undefined reference to `acpi_video_register'
> make: *** [.tmp_vmlinux1] Error 1
Will you please try the patch in the comment #16/#21 of 
http://bugzilla.kernel.org/show_bug.cgi?id=13065 ?

Thanks.
> 
> I think I had the same with -rc1.
> 
> .config is attached
> 
> Cheers,
> Brice
> 

