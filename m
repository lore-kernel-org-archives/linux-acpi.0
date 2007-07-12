From: Richard Hughes <hughsient@gmail.com>
Subject: Re: [2.6 patch] the scheduled ACPI_PROCFS removal
Date: Thu, 12 Jul 2007 10:18:17 +0100
Message-ID: <1184231897.2380.2.camel@work>
References: <20070709145755.GD3492@stusta.de>
	 <20070709174544.2a6b7067@the-village.bc.nu>
	 <Pine.LNX.4.64.0707092044520.2887@fbirervta.pbzchgretzou.qr>
	 <46951969.4030109@tmr.com>  <4695BCEA.4060108@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.232]:46684 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755496AbXGLJVe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Jul 2007 05:21:34 -0400
Received: by wx-out-0506.google.com with SMTP id h31so86574wxd
        for <linux-acpi@vger.kernel.org>; Thu, 12 Jul 2007 02:21:33 -0700 (PDT)
In-Reply-To: <4695BCEA.4060108@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: Bill Davidsen <davidsen@tmr.com>, Jan Engelhardt <jengelh@computergmbh.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Adrian Bunk <bunk@stusta.de>, Zhang Rui <rui.zhang@intel.com>, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 2007-07-12 at 09:32 +0400, Alexey Starikovskiy wrote:
> >> [*] Does someone have an alternative for
> >> /proc/acpi/battery/BAT1/{state,info}?
> I'm working on it. Should have proto by the end of week.

If you are using the power_supply class (i hope you are ;-) then a HAL
from freedesktop git should make userspace continue to just work. Please
yell if you notice any differences.

Richard.


