From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 3/3] ghes_edac: add platform check to enable ghes_edac
Date: Wed, 19 Jul 2017 17:57:18 +0200
Message-ID: <20170719155718.GD16124@nazgul.tnic>
References: <20170717215912.26070-1-toshi.kani@hpe.com>
 <20170717215912.26070-4-toshi.kani@hpe.com>
 <20170718060007.GB8736@nazgul.tnic>
 <1500407379.2042.21.camel@hpe.com>
 <20170718181545.32bd9181@vento.lan>
 <20170719055838.GF26030@nazgul.tnic>
 <3908561D78D1C84285E8C5FCA982C28F6130D126@ORSMSX114.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F6130D126@ORSMSX114.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>, "Kani, Toshimitsu" <toshi.kani@hpe.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "mchehab@kernel.org" <mchehab@kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Jul 19, 2017 at 03:14:32PM +0000, Luck, Tony wrote:
> Later when GHES gives you a NODE/CARD/MODULE) in an error record.  You need
> to match these up. But SMBIOS only gave you two strings "Locator" and "Bank
> Locator" which have no defined syntax. You are at the mercy of the BIOS writer
> to put in something parseable.

Well, at some point it is only so much we can do, right?

I mean, if FW says it wants to do firmware-first and we go and adhere
to that, it should be expected that said FW vendor marks the silkscreen
labels and DMI data accordingly.

I mean, it is time for FW to put its money where its mouth is, no?

How else would you do this?

Firmware First but the kernel does the figuring out which DIMMs are
where. So FW can't have the cake and eat it too.

:-)

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
