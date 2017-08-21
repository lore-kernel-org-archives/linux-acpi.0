From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] ACPICA: Check whether ACPI is disabled before getting a
 table
Date: Mon, 21 Aug 2017 17:34:15 +0200
Message-ID: <20170821153415.54cwpytwfuq2bpec@pd.tnic>
References: <20170818194644.14538-1-toshi.kani@hpe.com>
 <20170818194644.14538-2-toshi.kani@hpe.com>
 <20170821112657.hrtjoeagxhc67rrr@pd.tnic>
 <CAJZ5v0i_-Sb_o24EcmHN37cQ3fqVf53a+Yc_weX_1Mv7VAOw3g@mail.gmail.com>
 <20170821132054.mwhdxkcka4ocp6h5@pd.tnic>
 <CAJZ5v0iE_H6xeyvzCEMRKhE=iuaP8aUOP4_bT=y2fMJ7htxyew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iE_H6xeyvzCEMRKhE=iuaP8aUOP4_bT=y2fMJ7htxyew@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Toshi Kani <toshi.kani@hpe.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mauro Carvalho Chehab <mchehab@kernel.org>, Tony Luck <tony.luck@intel.com>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "open list:EDAC-CORE" <linux-edac@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, Aug 21, 2017 at 03:30:47PM +0200, Rafael J. Wysocki wrote:
> Is acpi_disabled an ACPICA variable?

Doesn't look like it: it is defined in arch/x86/kernel/acpi/boot.c

> If not, this cannot go upstream. Not a big deal I guess, but somewhat
> yucky.

Uff, there's that "sync" of keeping ACPICA code and its version in the
kernel the same. Yuck.

Oh well.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
