From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 3/3] ghes_edac: add platform check to enable ghes_edac
Date: Fri, 21 Jul 2017 17:53:46 +0200
Message-ID: <20170721155346.GB13424@nazgul.tnic>
References: <20170718181545.32bd9181@vento.lan>
 <1500481869.2042.29.camel@hpe.com>
 <20170720043344.GC14367@nazgul.tnic>
 <1500579646.2042.37.camel@hpe.com>
 <20170721133441.GB5036@nazgul.tnic>
 <20170721104001.3cd2b884@vento.lan>
 <20170721134715.GC5036@nazgul.tnic>
 <1500649162.2042.43.camel@hpe.com>
 <20170721151317.GA13424@nazgul.tnic>
 <1500650732.2042.45.camel@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1500650732.2042.45.camel@hpe.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Kani, Toshimitsu" <toshi.kani@hpe.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mchehab@s-opensource.com" <mchehab@s-opensource.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "mchehab@kernel.org" <mchehab@kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>, "tony.luck@intel.com" <tony.luck@intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, Jul 21, 2017 at 03:34:50PM +0000, Kani, Toshimitsu wrote:
> I suppose it'd depend on vendors, but I do not think users can do it
> properly unless they have depth knowledge about the hardware.

I'm talking about a menu in the BIOS where you can set the thresholding
levels on the system. Does your BIOS have that?

> Corrected errors are normal and expected to occur on healthy hardware. 
> They do not need user's attention until they repeatedly occurred at a
> same place.

Apparently, you haven't been on enough maintanance calls, trying to calm
down the customer about the hardware error he sees in his logs...

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
