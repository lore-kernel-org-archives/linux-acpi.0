From: "Yinghai Lu" <yhlu.kernel@gmail.com>
Subject: Re: ACPI Error under 2.6.26-rc*
Date: Tue, 22 Jul 2008 01:18:05 -0700
Message-ID: <86802c440807220118y39545983s35a9439e12c8f0f9@mail.gmail.com>
References: <20080709083829.GA5748@linux.int.dgn.ag>
	 <1215739210.1617.28.camel@rzhang-dt>
	 <1215739682.1617.32.camel@rzhang-dt>
	 <20080714080914.GA4965@linux.int.dgn.ag>
	 <1216026701.1617.82.camel@rzhang-dt>
	 <20080715074130.GA4724@linux.int.dgn.ag>
	 <1216111260.1617.131.camel@rzhang-dt>
	 <20080717084102.GA4597@linux.int.dgn.ag>
	 <1216693359.1617.258.camel@rzhang-fc9>
	 <20080722080112.GA4653@linux.int.dgn.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754836AbYGVISY@vger.kernel.org>
In-Reply-To: <20080722080112.GA4653@linux.int.dgn.ag>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Andre Prendel <andre_prendel@gmx.de>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>
Cc: Zhang Rui <rui.zhang@intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, kernel-testers@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, "Zhao, Yakui" <yakui.zhao@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Tue, Jul 22, 2008 at 1:01 AM, Andre Prendel <andre_prendel@gmx.de> wrote:
> -----------------------
> dmesg (extract)
> -----------------------
> Linux version 2.6.26-default (andre@ubuntu) (gcc version 4.1.3 20070929 (prerelease) (Ubuntu 4.1.2-16ubuntu2)) #13 Mon Jul 21 22:48:01 CEST 2008
> BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
>  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
>  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
>  BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
>  BIOS-e820: 000000002fff0000 - 000000002fff8000 (ACPI data)
>  BIOS-e820: 000000002fff8000 - 0000000030000000 (ACPI NVS)
>  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
>  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
>  BIOS-e820: 00000000ffee0000 - 00000000fff00000 (reserved)
>  BIOS-e820: 00000000fffc0000 - 0000000100000000 (reserved)
> [...]
> ACPI: Interpreter disabled.
> Linux Plug and Play Support v0.97 (c) Adam Belay
> pnp: PnP ACPI: disabled
> [...]
>
> The bios problem still exists so maybe I will do an upgrade.

peter,

that system have different e820 for 2.6.26 to old kernel.

it should be
>  BIOS-e820: 000000001fff0000 - 000000001fff8000 (ACPI data)
>  BIOS-e820: 000000001fff8000 - 0000000020000000 (ACPI NVS)

YH
