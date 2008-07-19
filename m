From: "Guillaume Chazarain" <guichaz@gmail.com>
Subject: Re: [Bug #10724] ACPI: EC: GPE storm detected, disabling EC GPE
Date: Sat, 19 Jul 2008 14:30:42 +0200
Message-ID: <3d8471ca0807190530k6bd91b1ao8995cbad1f4e3b93@mail.gmail.com>
References: <aPfh5-7kW-5@gated-at.bofh.it> <aPfhe-7kW-31@gated-at.bofh.it>
	 <aQUio-2qG-25@gated-at.bofh.it> <aR0nM-6kd-15@gated-at.bofh.it>
	 <aR3vi-3MV-15@gated-at.bofh.it> <aR4Ur-6c7-27@gated-at.bofh.it>
	 <aReqy-5vm-1@gated-at.bofh.it>
	 <50b515e4-6cd1-4b18-93e3-ecfab5925f02@34g2000hsf.googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.187]:58242 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755338AbYGSMao (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 19 Jul 2008 08:30:44 -0400
Received: by mu-out-0910.google.com with SMTP id w8so481367mue.1
        for <linux-acpi@vger.kernel.org>; Sat, 19 Jul 2008 05:30:42 -0700 (PDT)
In-Reply-To: <50b515e4-6cd1-4b18-93e3-ecfab5925f02@34g2000hsf.googlegroups.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Jenkins <aj504@cs.york.ac.uk>
Cc: Fabio Comolli <fabio.comolli@gmail.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Alexey Starikovskiy <astarikovskiy@suse.de>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, Jul 19, 2008 at 2:22 PM, Alan Jenkins <aj504@cs.york.ac.uk> wrote:
> I'm not sure what could happen if it's broken somehow :-).  If you
> have ACPI hotkeys (i.e. running acpi_listen shows events when you
> press hotkeys), please check they still work.

The symptoms for me (still present in 2.6.26) were that ACPI hotkeys
were very laggy, and your patches fix that completely. Nice work :-)

BTW, I have an Asus V6VA.

Thanks.

-- 
Guillaume
