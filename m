From: "Yinghai Lu" <yhlu.kernel@gmail.com>
Subject: Re: [PATCH] ACPI: Unneccessary to scan the PCI bus already scanned.
Date: Mon, 3 Mar 2008 02:33:12 -0800
Message-ID: <86802c440803030233s1b0cc0a6nbed683ee3d4fac63@mail.gmail.com>
References: <1204525186.4080.11.camel@yakui_zhao.sh.intel.com>
	 <20080303073214.GA5934@elte.hu>
	 <86802c440803030006m1879838awc238f07bc98ed43e@mail.gmail.com>
	 <86802c440803030030p4ff9cec5tdb25d1cdc131d377@mail.gmail.com>
	 <86802c440803030201i684f31c1m97fb3f1f1927d4f4@mail.gmail.com>
	 <20080303101040.GG18281@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.188]:60657 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751568AbYCCKdP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 3 Mar 2008 05:33:15 -0500
Received: by rv-out-0910.google.com with SMTP id k20so3809249rvb.1
        for <linux-acpi@vger.kernel.org>; Mon, 03 Mar 2008 02:33:12 -0800 (PST)
In-Reply-To: <20080303101040.GG18281@elte.hu>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Greg KH <gregkh@suse.de>, Muli Ben-Yehuda <muli@il.ibm.com>, Zhao Yakui <yakui.zhao@intel.com>, lenb@kernel.org, linux-acpi@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Mon, Mar 3, 2008 at 2:10 AM, Ingo Molnar <mingo@elte.hu> wrote:
>
>  * Yinghai Lu <yhlu.kernel@gmail.com> wrote:
>
>
> > also please use attached patch to replace the one patch in x86.git#
>  > testing. old one can not be applied after Yakui's patch.
>
>  ok, thanks. Note, i still have the patch below filed up against it - is
>  that still needed?
>
>         Ingo
>
>  -------------->
>  Subject: x86: fix k8-bus_64.c build
>  From: Ingo Molnar <mingo@elte.hu>
>  Date: Wed Feb 20 10:30:15 CET 2008
>

yes. still needed, or you can fold that to next one about multi pci root.

YH
