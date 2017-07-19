From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 3/3] ghes_edac: add platform check to enable ghes_edac
Date: Wed, 19 Jul 2017 07:55:44 +0200
Message-ID: <20170719055544.GE26030@nazgul.tnic>
References: <20170717215912.26070-1-toshi.kani@hpe.com>
 <20170717215912.26070-4-toshi.kani@hpe.com>
 <20170718060007.GB8736@nazgul.tnic>
 <1500407379.2042.21.camel@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1500407379.2042.21.camel@hpe.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Kani, Toshimitsu" <toshi.kani@hpe.com>
Cc: "tony.luck@intel.com" <tony.luck@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "mchehab@kernel.org" <mchehab@kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Jul 18, 2017 at 07:58:54PM +0000, Kani, Toshimitsu wrote:
> I have HPE Haswell and Skylake test systems with GHES, but they do not
> hide IMCs from the OS.  So, the sb_edac and skx_edac drivers get
> attached on these systems when ghes_edac is disabled.

That's how it is supposed to work. The platform drivers are the
fallback, practically.

But this is the important piece of info I was looking for - having GHES
enabled in the firmware does not prevent the platform drivers from
loading. But I think we have a better solution, the FF thing.

> Hmm... what's the platform name of this box?  I can look into this case
> if you need.

You can but that's not addressing the issue as a whole so it'll be a
waste of time.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
