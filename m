From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH v5 2/2] ACPI: Add Intel MID SPI early console support.
Date: Wed, 10 Oct 2012 03:10:53 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E88B9CA24@SHSMSX101.ccr.corp.intel.com>
References: <cover.1347453194.git.zetalog@gmail.com>
 <534b1bf9fba2b51bdff554e100931713dd7da2a9.1349749925.git.lv.zheng@intel.com>
 <20121009170613.GF25276@phenom.dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20121009170613.GF25276@phenom.dumpdata.com>
Content-Language: en-US
Sender: platform-driver-x86-owner@vger.kernel.org
To: Konrad Rzeszutek Wilk <konrad@kernel.org>
Cc: "Brown, Len" <len.brown@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Jason Wessel <jason.wessel@windriver.com>, "Tang, Feng" <feng.tang@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

> > +#ifdef CONFIG_EARLY_PRINTK_INTEL_MID_SPI
> > +	if (info->port_type == ACPI_DBG2_SERIAL_PORT
> > +	    && info->port_subtype == ACPI_DBG2_INTEL_MID_SPI
> > +	    && info->register_count > 0) {
> Is it ever going to be zero?

NAK.
No register base definition (buggy BIOS?) is meaningless for ACPI launched MID_SPI earlycon.

Thanks and best regards/Lv Zheng
