From: Johannes Stezenbach <js@sig21.net>
Subject: Re: Cherryview wake up events
Date: Tue, 31 Jan 2017 15:37:40 +0100
Message-ID: <20170131143740.lgn2svjskjulsucf@sig21.net>
References: <CAHp75Vfc0g5znBm72Jx-C+p-9+3j69ecJBaVvm+Onf+sqf=7HA@mail.gmail.com>
 <20170124135250.d72silj6jlxh7zqk@sig21.net>
 <CAHp75VfUgwZkA7FVhdCY2CRFbtE55Q01MBbpmXVeMvLNEQLV2w@mail.gmail.com>
 <20170124192314.gw6njffcgwyfm2gp@sig21.net>
 <CAHp75VdHHvy2djYSTStPPcKUJFHLSAH_z7VzWW_12Qia3n2XyQ@mail.gmail.com>
 <20170127113845.zt5jwjzumafclvzc@sig21.net>
 <CAHp75Ve6pwaDM3ookO9e_4c1R_U9_X3aF43XGtD5Z2+6G6f6zA@mail.gmail.com>
 <20170127133058.pxuovuuqpnffx3py@sig21.net>
 <20170130205745.wwavipta5hbz5zfz@sig21.net>
 <CAHp75Vfdk2u2wQa9ZR1vGCAPYL4rnSF78pJR98t+J0+Sn9LuqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.sig21.net ([80.244.240.74]:58506 "EHLO mail.sig21.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750737AbdAaOiN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 31 Jan 2017 09:38:13 -0500
Content-Disposition: inline
In-Reply-To: <CAHp75Vfdk2u2wQa9ZR1vGCAPYL4rnSF78pJR98t+J0+Sn9LuqA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Cohen <david.a.cohen@linux.intel.com>

Hi Andy and Mika,

On Tue, Jan 31, 2017 at 12:05:07AM +0200, Andy Shevchenko wrote:
> On Mon, Jan 30, 2017 at 10:57 PM, Johannes Stezenbach <js@sig21.net> wrote:
> >
> > I checked the reference source code, my impression is the
> > TI Dollar Cove and and AXP288 are completely different hardware.
> 
> Thanks for checking.
> 
> Yes, due to not obvious communication to PMIC. I suppose that the IP
> core is quite similar in all of them, the difference is just how OS
> and other MCUs in SoC communicate with it.
> 
> So, basically what it means that I2C direct communication is prohibited here.

Not sure about that, but I guess this is needed:
https://lists.freedesktop.org/archives/intel-gfx/2017-January/117696.html

> >> > This is known: http://www.spinics.net/lists/intel-gfx/msg117738.html
> >
> > Interestingly via this link I found Intel also published
> > the TI DCove source in a patch series against an unspecified kernel:
> > https://github.com/01org/ProductionKernelQuilts
> > specifically
> > https://github.com/01org/ProductionKernelQuilts/blob/master/uefi/cht-m1stable/patches/mfd-intel_soc_pmic-add-TI-variant-of-dollar-cove.patch
> > https://github.com/01org/ProductionKernelQuilts/blob/master/uefi/cht-m1stable/patches/PWRBTN-add-driver-for-TI-PMIC.patch
> > and some more (the series is quite messy).

FWIW, now I came across yet another source for this driver:
https://android.googlesource.com/kernel/x86/+/android-x86-grant-3.10-marshmallow-mr1-wear-release/drivers/external_drivers/drivers/mfd/intel_pmic/
(but seems to be older)

> > For the Asus E200HA I'm not sure if the charger and coulomb
> > counter drivers are needed since charging just works and
> > the battery status is reported via ACPI.  It seems these
> > drivers are only for tablets without ACPI support, right?
> 
> Have no idea.
> 
> What that code reminds me is MID family of devices. So, power button
> is (reasonable) easy to get support of in that case.
> Look into drivers/platform/x86/intel_mid_powerbtn.c. I recently
> updated it to support Basin Cove on Intel Edison.

You seem to suggest I should try and tackle it myself,
which I would do, but for one I don't want to step on
Mika's toes, secondly ISTR you indicated you have newer,
better source than what is available publicly?
If you want me to take it, please let me know which tree
to work against and any other suggestions you have.

Some more questions:
- Powerbutton driver seems simple enough, the only specialty
  of the TI dcove PB driver is the workarond for lost button
  press event after resume.  However, I still don't see how
  the PB would cause thermal event irqs on E200HA and how the
  PMIC driver would change it?
- Wakeup from freeze state (E200HA doesn't support suspend / ACPI S3)
  is only step 1, to make it usable we need S0ix support.
  Any hints about that?

I think the mfd driver would be similar to intel_soc_pmic_crc.c,
the dollar_cove_ti_powerbtn.c I would keep instead of merging
it into intel_mid_powerbtn.c.  I guess what we need is in
drivers/acpi/pmic/ something similar to intel_pmic_crc.c,
the ProductionKernelQuilts has 0001-ACPI-Adding-support-for-TI-pmic-opregion.patch.


Thanks,
Johannes
