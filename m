From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: ACPI errors from TPM PPI
Date: Sat, 6 Jul 2013 14:10:25 +0300
Message-ID: <20130706111025.GZ4898@intel.com>
References: <CAMfhd9XWfp420M9wF-ACya9hbQGUSkneRB6sry9=nj1KtB_ygw@mail.gmail.com>
 <10172565.WQexNecTHe@vostro.rjw.lan>
 <CAMfhd9U6qvm2kTb2D8PgzR8qCqZnDWhLNC4Ojzftc8PdmKwjnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:47699 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752945Ab3GFLE7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 6 Jul 2013 07:04:59 -0400
Content-Disposition: inline
In-Reply-To: <CAMfhd9U6qvm2kTb2D8PgzR8qCqZnDWhLNC4Ojzftc8PdmKwjnA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Adam Langley <agl@imperialviolet.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, xiaoyan.zhang@intel.com, Bob Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Fri, Jul 05, 2013 at 10:03:10AM -0400, Adam Langley wrote:
> On Thu, Jul 4, 2013 at 9:07 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >> This appears to be coming from acpi_evaluate_object_typed in
> >> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/char/tpm/tpm_ppi.c#n75,
> >> so I added a printk to get the actual value of |status| when it fails
> >> and it's 5 (aka AE_NOT_FOUND I believe).
> 
> In hindsight, the error was somewhat obvious. The driver is locating
> the TPM object in the ACPI tables by walking the tables with a
> callback [1]. The callback is using strstr to look for the substring
> "TPM" in the handle of the object and returns the first that it finds.
> On my system, if I alter the callback to print each match and not
> abort the walk I find three values:
> 
> \_SB_.PCI0.TPMX
> \_SB_.PCI0.LPCB.TPM_
> \_SB_.PCI0.ITPM
> 
> Of these, the second is the right one.
> 
> (I note that the callback also appears to have a memory leak in the
> case that the string doesn't contain "TPM".)
> 
> I'm sure that the strstr() worked on the computer that it was
> developed on, but it's rather fragile. I can get it working for me by
> using "LPCB.TPM" as the argument to strstr(), but who's to say that
> doesn't break someone else?

I wonder whether there is a real PNP Id associated with that device?

I have one sample ASL code that looks like:

    Device (\_SB.PCI0.LPCB.TPM)
    {
        Name (_HID, EisaId ("PNP0C31"))
        Name (_CID, EisaId ("PNP0C31"))
        Name (_STR, Unicode ("TPM 1.2 Device"))
        Name (_CRS, ResourceTemplate ()
        {
            Memory32Fixed (ReadOnly,
                0xFED40000,         // Address Base
                0x00005000,         // Address Length
                )
        })

Does your TPM_ device look similar?

That PNP0C31 can be matched in the TPM driver instead of trusting some
random device names that might change from vendor to vendor.
