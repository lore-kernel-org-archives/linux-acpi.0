From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [2.6 patch] the scheduled ACPI_PROCFS removal
Date: Mon, 9 Jul 2007 23:06:23 +0100
Message-ID: <20070709230623.417cb0df@the-village.bc.nu>
References: <20070709145755.GD3492@stusta.de>
	<20070709174544.2a6b7067@the-village.bc.nu>
	<Pine.LNX.4.64.0707092044520.2887@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:34316 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755403AbXGIWCJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Jul 2007 18:02:09 -0400
In-Reply-To: <Pine.LNX.4.64.0707092044520.2887@fbirervta.pbzchgretzou.qr>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jan Engelhardt <jengelh@computergmbh.de>
Cc: Adrian Bunk <bunk@stusta.de>, Zhang Rui <rui.zhang@intel.com>, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 9 Jul 2007 20:46:20 +0200 (CEST)
Jan Engelhardt <jengelh@computergmbh.de> wrote:

> 
> On Jul 9 2007 17:45, Alan Cox wrote:
> >
> >> This patch contains the scheduled removal of the ACPI procfs interface.
> >
> >What part of "we do not gratuitously break user space interfaces" is so
> >hard for people to understand.
> 
> Generally I am with you on that, but if everyone keeps on using /proc --
> and I do[*] -- we will never get rid of it.

And why do we need to get rid of it ?
