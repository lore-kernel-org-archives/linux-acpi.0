From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 1/2] init: Introduce early initrd files through uncompressed
 cpio passing
Date: Mon, 23 Jul 2012 08:09:16 -0700
Message-ID: <500D691C.7010203@zytor.com>
References: <1342607764-66747-1-git-send-email-trenn@suse.de> <1342607764-66747-2-git-send-email-trenn@suse.de> <500AC8F6.4010802@zytor.com> <201207231640.35023.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:59691 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753660Ab2GWPJ3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 23 Jul 2012 11:09:29 -0400
In-Reply-To: <201207231640.35023.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: linux-kernel@vger.kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, initramfs@vger.kernel.org, bigeasy@linutronix.de, Fenghua Yu <fenghua.yu@intel.com>

On 07/23/2012 07:40 AM, Thomas Renninger wrote:
> This is another problem and I expect I call:
> early_initrd_find_cpio_data()
> early enough for Fenghua's needs.
> If not, how early exactly is this needed?

We're calling that from arch-specific code before even turning paging 
on.  This has a couple of consequences:

1. ALL STATIC POINTERS ARE FORBIDDEN.  Period.  The code must be able to 
be executed from a nonstandard linear address, and any static pointer 
(like a function pointer) breaks that.

2. Any ideas of doing everything at the same time, or uniform 
architecture, is clearly out the window... we're just barely capable of 
using C at this point at all.

Now, you definitely do have a valid point about being able to iterate 
over multiple files with a common prefix.  We could do that with either 
a callback (where the callback is passed in as an argument), but I think 
it might be nicer to do that as an iterator interface... let me ketch on 
this.

> If (just an example) CPU microcode files get passed via "early initrd",
> the same path could be provided than needed by request_fw().

This will all be obsolete.  request_fw is available way, way, way too late.


-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.

