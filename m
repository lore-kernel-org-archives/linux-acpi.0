From: Mattia Dongili <malattia@linux.it>
Subject: Re: [PATCH] sony-laptop - fix using of uninitialized variable
Date: Sun, 10 Jan 2010 19:52:21 +0900
Message-ID: <20100110105220.GB2837@kamineko.org>
References: <20100110081544.GD16057@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static-220-247-10-204.b-man.svips.gol.ne.jp ([220.247.10.204]:42321
	"EHLO smtp.kamineko.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753076Ab0AJKwX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 10 Jan 2010 05:52:23 -0500
Content-Disposition: inline
In-Reply-To: <20100110081544.GD16057@core.coreip.homeip.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

On Sun, Jan 10, 2010 at 12:15:44AM -0800, Dmitry Torokhov wrote:
> CC [M]  drivers/platform/x86/sony-laptop.o
> drivers/platform/x86/sony-laptop.c: In function 'sony_nc_rfkill_setup':
> drivers/platform/x86/sony-laptop.c:1162: warning: 'i' may be used uninitialized in this function
> 
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> ---
> 
> This is a real warning and without the fix we may be setting up
> non-existing rfkill devices so please consider for .33.

Thanks Dmitry.

Len, please submit this for 2.6.33 and add my
Acked-by: Mattia Dongili <malattia@linux.it>
-- 
mattia
:wq!
