From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] toshiba_acpi: Add full hotkey support
Date: Sat, 7 Mar 2009 15:44:24 +0000
Message-ID: <20090307154424.GA3909@srcf.ucam.org>
References: <20090306003941.GA32403@srcf.ucam.org> <E1LfqwF-000B1G-00.arvidjaar-mail-ru@mx3.mail.ru> <20090307150640.GA3516@srcf.ucam.org> <200903071839.16508.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:38969 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751656AbZCGPo3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 7 Mar 2009 10:44:29 -0500
Content-Disposition: inline
In-Reply-To: <200903071839.16508.arvidjaar@mail.ru>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, hal@lists.freedesktop.org, Richard Hughes <hughsient@gmail.com>

On Sat, Mar 07, 2009 at 06:38:53PM +0300, Andrey Borzenkov wrote:

> - patch toshiba_acpi to return KEY_SUSPEND/KEY_HIBERNATE instead of 
> KEY_SLEEP/KEY_SUSPEND. This depends on commit 
> 6932b918e05b06165ed3457a9f3aa279099a7cbd in linux-next.
> 
> - patch HAL to recognize KEY_HIBERNATE and return "suspend" for 
> KEY_SUSPEND; right now it is:
> 
>         [KEY_SLEEP] = "sleep",
>         [KEY_SUSPEND] = "hibernate",

Ugh. Why are we changing this? The semantics were pretty clear before. 
The KEY_SUSPEND to hibernate mapping was decided years ago, and it's 
clearly an incompatible change as far as userspace goes.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
