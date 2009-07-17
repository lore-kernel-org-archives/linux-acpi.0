From: Len Brown <lenb@kernel.org>
Subject: Re: next: sfi build fails when !CONFIG_ACPI
Date: Thu, 16 Jul 2009 21:46:15 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0907162145140.3531@sony-vgn-z540>
References: <a4423d670907160148n66760052wbef60e4a2c3c7941@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.globalsuite.net ([69.46.103.200]:36111 "HELO
	mail.globalsuite.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754461AbZGUSV2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 21 Jul 2009 14:21:28 -0400
In-Reply-To: <a4423d670907160148n66760052wbef60e4a2c3c7941@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexander Beregalov <a.beregalov@gmail.com>
Cc: linux-next <linux-next@vger.kernel.org>, Feng Tang <feng.tang@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org

> drivers/sfi/sfi_core.c: In function 'sfi_init':
> drivers/sfi/sfi_core.c:346: error: 'acpi_disabled' undeclared (first
> use in this function)
> drivers/sfi/sfi_core.c:346: error: (Each undeclared identifier is
> reported only once
> drivers/sfi/sfi_core.c:346: error: for each function it appears in.)
> 
> 
> $ grep ACPI .config
> # Power management and ACPI options

It builds for me.
Please send me the complete failing .config

thanks,
Len Brown, Intel Open Source Technology Center
