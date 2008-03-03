From: "Yinghai Lu" <yhlu.kernel@gmail.com>
Subject: Re: [PATCH] ACPI: Unneccessary to scan the PCI bus already scanned.
Date: Mon, 3 Mar 2008 00:06:56 -0800
Message-ID: <86802c440803030006m1879838awc238f07bc98ed43e@mail.gmail.com>
References: <1204525186.4080.11.camel@yakui_zhao.sh.intel.com>
	 <20080303073214.GA5934@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.190]:18199 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751979AbYCCIG7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 3 Mar 2008 03:06:59 -0500
Received: by rv-out-0910.google.com with SMTP id k20so3762298rvb.1
        for <linux-acpi@vger.kernel.org>; Mon, 03 Mar 2008 00:06:57 -0800 (PST)
In-Reply-To: <20080303073214.GA5934@elte.hu>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Zhao Yakui <yakui.zhao@intel.com>, lenb@kernel.org, linux-acpi@vger.kernel.org

On Sun, Mar 2, 2008 at 11:32 PM, Ingo Molnar <mingo@elte.hu> wrote:
>
>  small typo:
>
>
>  > +              * If the desired bus exits, the content of bus->sysdata will
>                                         ^--- exists
>  > +              * be replaced by sd.
>
>  also, it's not clear to me why the patch helps. Why does "double
>  scanning" cause problems? We register devices twice? Shouldnt that just
>  work? (except for a few "device already exists" type of messages)

it seems
in pci_access_init, pci_pcibios_init scan that again before acpi get
chance to scan...

PCI: PCI BIOS revision 2.10 entry at 0xfdb44, last bus=2

does Greg have patch that remove pcibios_scan?

YH
