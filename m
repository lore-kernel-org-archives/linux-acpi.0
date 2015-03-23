From: Matt Fleming <matt@codeblueprint.co.uk>
Subject: Re: [PATCH] ACPI: Adjust the return value of _REV on x86
Date: Mon, 23 Mar 2015 12:04:47 +0000
Message-ID: <20150323120331.GA3007@codeblueprint.co.uk>
References: <1426150247-18309-1-git-send-email-matthew.garrett@nebula.com>
 <1426363131-14530-1-git-send-email-jason.ekstrand@intel.com>
 <CAOFGe95CiLcHtzD3Vv-KJoCXfeHCyGa55OBkzHSZMWwdOyLnfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:33969 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752152AbbCWMEu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Mar 2015 08:04:50 -0400
Received: by wgs2 with SMTP id 2so37139761wgs.1
        for <linux-acpi@vger.kernel.org>; Mon, 23 Mar 2015 05:04:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAOFGe95CiLcHtzD3Vv-KJoCXfeHCyGa55OBkzHSZMWwdOyLnfg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jason Ekstrand <jason@jlekstrand.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Bard Liao <bardliao@realtek.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, linux-acpi@vger.kernel.org, lenb@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On Mon, 16 Mar, at 04:21:51PM, Jason Ekstrand wrote:
> 
> A quick update on the Dell XPS 13 for those of you who are following
> this discussion but aren't aware of the XPS 13-specific discussions.
> The "problem" triggered by _REV=5 is not a *real* problem.  The reason
> they special-cased it for the XPS 13 is that the sound card is
> dual-mode and can run over either HDA and I2S.  Since the I2S support
> on Linux isn't great at the moment, they special-cased linux to run it
> in HDA mode which has good support.  The problem is that, in the A01
> bios update where they changed this, they made a mistake that left the
> sound card in an invalid state.  A one-line change to the DSDT table
> in the bios puts it into HDA mode properly and fixes both the audio
> and suspend/resume issues.  They should be coming out with a bios
> update shortly to fix this.
> 
> I'm not knowledgeable enough to weigh in on the philosophical issues
> here, but I thought it was worth explaining the reason for the linux
> special-casing.  In the case of the new XPS 13, Dell was doing
> something useful with their special-casing, they just made a mistake.
> If we did start advertising _REV=2 this would cause the laptop (with
> the fixed bios) to load the sound card in I2S mode and it would be
> less reliable.

Sadly no, Dell are not doing something useful. Their use of _REV is
entirely misguided for the same reasons using _OSI(Linux) is discouraged
in drivers/acpi/osl.c; namely that working around kernel bugs in the
BIOS is a terrible solution.

Non-Windows BIOS code paths are not validated to the same degree as
those traversed by running Windows, which is exactly why we try so hard
to emulate Windows whenever we interact with the BIOS.

The real way to fix this is to add the necessary support and bug fixes
to the kernel, exactly as Bard (Cc'd) has been doing.

P.S If Dell XPS13 owners try this patch and audio isn't magically
detected, make sure you perform *two* cold boots. There appears to be some
level of caching going where the last read _REV value is used.

-- 
Matt Fleming, Intel Open Source Technology Center
