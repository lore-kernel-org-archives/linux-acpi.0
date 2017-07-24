From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 3/3] ghes_edac: add platform check to enable ghes_edac
Date: Mon, 24 Jul 2017 18:37:54 +0200
Message-ID: <20170724163754.GA18184@nazgul.tnic>
References: <1500654661.2042.49.camel@hpe.com>
 <20170721140131.40079805@vento.lan>
 <20170721172344.GA11316@nazgul.tnic>
 <1500661773.2042.53.camel@hpe.com>
 <20170722062853.GA2050@nazgul.tnic>
 <1500907209.2042.55.camel@hpe.com>
 <20170724150432.GA31295@nazgul.tnic>
 <1500909372.2042.58.camel@hpe.com>
 <20170724153716.GA17708@nazgul.tnic>
 <1500911226.2042.60.camel@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:33640 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752649AbdGXQid (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 24 Jul 2017 12:38:33 -0400
Content-Disposition: inline
In-Reply-To: <1500911226.2042.60.camel@hpe.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Kani, Toshimitsu" <toshi.kani@hpe.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mchehab@s-opensource.com" <mchehab@s-opensource.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "mchehab@kernel.org" <mchehab@kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>, "tony.luck@intel.com" <tony.luck@intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>

On Mon, Jul 24, 2017 at 03:56:27PM +0000, Kani, Toshimitsu wrote:
> Yes, Mauro has already pointed this out.  As I replied to him, we do
> have a separate series of platforms that do not have built-in RAS, and

So this whitelist entry

+static struct acpi_oemlist oemlist[] = {
+       {"HPE   ", "Server  ", 0, ACPI_SIG_FADT, all_versions},
+       { } /* End */
+};

looks like it'll match every HP server platform not only the ones with
built-in RAS.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
