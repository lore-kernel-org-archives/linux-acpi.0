From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: Re: [PATCH 3/3] ghes_edac: add platform check to enable ghes_edac
Date: Thu, 20 Jul 2017 15:16:51 -0300
Message-ID: <20170720151651.5e74aee7@vento.lan>
References: <20170718080836.GB8372@nazgul.tnic>
        <1500412288.2042.25.camel@hpe.com>
        <20170719055235.GD26030@nazgul.tnic>
        <1500480051.2042.27.camel@hpe.com>
        <20170719162204.GE16124@nazgul.tnic>
        <1500482822.2042.31.camel@hpe.com>
        <20170720041645.GA14367@nazgul.tnic>
        <1500561189.2042.35.camel@hpe.com>
        <20170720150409.GB20712@nazgul.tnic>
        <3908561D78D1C84285E8C5FCA982C28F6130F211@ORSMSX114.amr.corp.intel.com>
        <20170720170504.GA23149@nazgul.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170720170504.GA23149@nazgul.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: "Luck, Tony" <tony.luck@intel.com>, "Kani, Toshimitsu" <toshi.kani@hpe.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "mchehab@kernel.org" <mchehab@kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Em Thu, 20 Jul 2017 19:05:04 +0200
Borislav Petkov <bp@alien8.de> escreveu:

> On Thu, Jul 20, 2017 at 04:55:59PM +0000, Luck, Tony wrote:
> > Add a module parameter to those edac drivers that can override the check
> > and let them load anyway.  I'm not paranoid, I just assume that there is a BIOS
> > out there that sets the OSC/WHEA bits, but isn't generating useful GHES logs.  
> 
> Or add that parameter to edac_core.ko and let it control which EDAC
> driver gets loaded? Something like
> 
> edac=ignore_ghes
> 
> or so. And then the other EDAC drivers query it.

Works for me.

Thanks,
Mauro
