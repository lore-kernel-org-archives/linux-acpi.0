From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: ACPI Errors on Acer Aspire One
Date: Wed, 12 May 2010 10:12:53 +0800
Message-ID: <1273630373.22924.74.camel@rzhang1-desktop>
References: <AANLkTilF304TbgACKtvc_FA01uxHrdRBS2Q-o6Tm-n8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:1997 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751740Ab0ELCMN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 11 May 2010 22:12:13 -0400
In-Reply-To: <AANLkTilF304TbgACKtvc_FA01uxHrdRBS2Q-o6Tm-n8Q@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jaswinder Singh Rajput <jaswinderlinux@gmail.com>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Tue, 2010-05-11 at 22:55 +0800, Jaswinder Singh Rajput wrote:
> Hello,
> 
> With latest git kernel, I am getting following ACPI errors :
> 
> [    0.289038] ACPI Error (dsfield-0143): [CAPB] Namespace lookup
> failure, AE_ALREADY_EXISTS
> [    0.289399] ACPI Error (psparse-0537): Method parse/execution
> failed [\_SB_.PCI0._OSC] (Node f70477e8), AE_ALREADY_EXISTS
> [    0.299684] ACPI Error (dsfield-0143): [CAPB] Namespace lookup
> failure, AE_ALREADY_EXISTS
> [    0.300007] ACPI Error (psparse-0537): Method parse/execution
> failed [\_SB_.PCI0._OSC] (Node f70477e8), AE_ALREADY_EXISTS
> 
> 
> dmesg : http://userweb.kernel.org/~jaswinder/acer_netbook/dmesg_2634-rc7.txt
> .config : http://userweb.kernel.org/~jaswinder/acer_netbook/config_2634-rc7.txt
> 
please attach the acpidump output.

It would be great if you can file a new bug report at
https://bugzilla.kernel.org/enter_bug.cgi?product=ACPI
and attach the dmesg and acpidump there.

thanks,
rui

> How can I fix these errors.
> 
> Thanks,
> --
> Jaswinder Singh.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


