From: "Yasha Okshtein" <flyashi@gmail.com>
Subject: Re: [GIT PATCH] ACPI patches for 2.6.23-rc1
Date: Tue, 31 Jul 2007 18:34:49 -0700
Message-ID: <6b01c6170707311834o27a72f8cpebf65cb65c2f2d1f@mail.gmail.com>
References: <200707251238.50218.lenb@kernel.org> <46A98FF9.8060801@l4x.org>
	 <je8x91flu9.fsf@sykes.suse.de> <46AAF709.9060407@l4x.org>
Reply-To: flyashi@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.186]:54839 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761185AbXHABeu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 31 Jul 2007 21:34:50 -0400
Received: by fk-out-0910.google.com with SMTP id z23so48894fkz
        for <linux-acpi@vger.kernel.org>; Tue, 31 Jul 2007 18:34:49 -0700 (PDT)
In-Reply-To: <46AAF709.9060407@l4x.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jan Dittmer <jdi@l4x.org>
Cc: Andreas Schwab <schwab@suse.de>, Len Brown <lenb@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Renninger <trenn@suse.de>

On 7/28/07, Jan Dittmer <jdi@l4x.org> wrote:
> Andreas Schwab wrote:
> > Jan Dittmer <jdi@l4x.org> writes:
> >> Len Brown wrote:
> >> FATAL: drivers/acpi/button: sizeof(struct acpi_device_id)=20 is not a modulo of the size of section __mod_acpi_device_table=144.
> > Are you cross-compiling?  The definition of kernel_ulong_t won't work on
> > x86.
> Yes, sorry, should have mentioned that. Build system is x86. Still,
> it didn't happen before the recent acpi merge.

I also have the same error, which I didn't have in 2.6.22:

FATAL: drivers/acpi/ac: sizeof(struct acpi_device_id)=20 is not a
modulo of the size of section __mod_acpi_device_table=48.
Fix definition of struct acpi_device_id in mod_devicetable.h
make[1]: *** [__modpost] Error 1

Build system is x86_64. I'm not cross-compiling, as the target machine
(not the build machine) is also x86_64.

 - Yasha
