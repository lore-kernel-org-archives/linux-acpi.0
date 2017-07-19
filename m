From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 3/3] ghes_edac: add platform check to enable ghes_edac
Date: Wed, 19 Jul 2017 07:58:38 +0200
Message-ID: <20170719055838.GF26030@nazgul.tnic>
References: <20170717215912.26070-1-toshi.kani@hpe.com>
 <20170717215912.26070-4-toshi.kani@hpe.com>
 <20170718060007.GB8736@nazgul.tnic>
 <1500407379.2042.21.camel@hpe.com>
 <20170718181545.32bd9181@vento.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170718181545.32bd9181@vento.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc: "Kani, Toshimitsu" <toshi.kani@hpe.com>, "tony.luck@intel.com" <tony.luck@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "mchehab@kernel.org" <mchehab@kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Jul 18, 2017 at 06:15:45PM -0300, Mauro Carvalho Chehab wrote:
> The way it is, ghes_edac is a poor man's driver. What it hopefully
> provide is a detection that an error happened, without really telling
> the user what component should be replaced.

I beg to differ. From the UEFI spec:

"The module number of the memory error location. (NODE, CARD, and MODULE
should provide the information necessary to identify the failing FRU)."

So this tuple is sufficient to pinpoint the DIMM, IIUC.

Which means, ghes_edac can have a single layer of DIMMs without channels.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
