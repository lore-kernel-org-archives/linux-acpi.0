From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 3/3] ACPI / PMIC: Add opregion driver for Intel Dollar Cove TI PMIC
Date: Sat, 26 Aug 2017 14:52:24 +0200
Message-ID: <1951917.lb8WZjqdIa@aspire.rjw.lan>
References: <20170825134443.14843-1-tiwai@suse.de> <CAHp75VeuEcBpQ6qcH+c=GYgNndjoLEn=C9NSJvOcYVgraOLWkQ@mail.gmail.com> <s5hvalbfyjg.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <s5hvalbfyjg.wl-tiwai@suse.de>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Lee Jones <lee.jones@linaro.org>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Johannes Stezenbach <js@sig21.net>, Hans de Goede <hdegoede@redhat.com>, Platform Driver <platform-driver-x86@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Friday, August 25, 2017 5:38:11 PM CEST Takashi Iwai wrote:
> On Fri, 25 Aug 2017 17:24:19 +0200,
> Andy Shevchenko wrote:
> > 
> > On Fri, Aug 25, 2017 at 4:44 PM, Takashi Iwai <tiwai@suse.de> wrote:
> > 
> > One really minor nit (fine if it will be ignored):
> > 
> > > +config CHTDC_TI_PMIC_OPREGION
> > 
> > CHTDC_TI_PMIC_OPREGION -> CHT_DC_TI_PMIC_OPREGION
> 
> Ah, the world is inconsistent...
> 
> > >  obj-$(CONFIG_XPOWER_PMIC_OPREGION) += pmic/intel_pmic_xpower.o
> > >  obj-$(CONFIG_BXT_WC_PMIC_OPREGION) += pmic/intel_pmic_bxtwc.o
> > >  obj-$(CONFIG_CHT_WC_PMIC_OPREGION) += pmic/intel_pmic_chtwc.o
> > > +obj-$(CONFIG_CHTDC_TI_PMIC_OPREGION) += pmic/intel_pmic_chtdc_ti.o
> > 
> > Ditto (as you can notice by above context).
> 
> ... where the file name is combined.
> 
> I really don't mind, too.
> 
> Rafael, please let me know if you want a resubmission with this
> correction.

Yes, please (but just this one patch should be sufficient).

Thanks,
Rafael
