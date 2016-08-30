From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/2] ACPI / APD: Add device HID for Vulcan SPI controller
Date: Tue, 30 Aug 2016 14:06:19 +0200
Message-ID: <122714000.NkbVWt00qu@vostro.rjw.lan>
References: <1470751522-11060-1-git-send-email-kamlakant.patel@broadcom.com> <CAB=aS0OFv3fvrrmsKvUKuTyDXECVmC8xdtyfKNdoNMN7HcC7RA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:45852 "HELO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1757907AbcH3MAc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 30 Aug 2016 08:00:32 -0400
In-Reply-To: <CAB=aS0OFv3fvrrmsKvUKuTyDXECVmC8xdtyfKNdoNMN7HcC7RA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kamlakant Patel <kamlakant.patel@broadcom.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Jayachandran C <jchandra@broadcom.com>, Mark Brown <broonie@kernel.org>

On Monday, August 29, 2016 06:05:16 PM Kamlakant Patel wrote:
> Hi,
> 
> On Tue, Aug 9, 2016 at 7:35 PM,  <kamlakant.patel@broadcom.com> wrote:
> > From: Kamlakant Patel <kamlakant.patel@broadcom.com>
> >
> > Add device HID for SPI controller on Broadcom Vulcan ARM64.
> > The default frequency for SPI on Vulcan is 133MHz.
> >
> > Signed-off-by: Kamlakant Patel <kamlakant.patel@broadcom.com>
> > ---
> >  drivers/acpi/acpi_apd.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c
> > index 1daf9c4..c80c8f8 100644
> > --- a/drivers/acpi/acpi_apd.c
> > +++ b/drivers/acpi/acpi_apd.c
> > @@ -87,6 +87,11 @@ static struct apd_device_desc xgene_i2c_desc = {
> >         .setup = acpi_apd_setup,
> >         .fixed_clk_rate = 100000000,
> >  };
> > +
> > +static struct apd_device_desc vulcan_spi_desc = {
> > +       .setup = acpi_apd_setup,
> > +       .fixed_clk_rate = 133000000,
> > +};
> >  #endif
> >
> >  #else
> > @@ -149,6 +154,7 @@ static const struct acpi_device_id acpi_apd_device_ids[] = {
> >  #endif
> >  #ifdef CONFIG_ARM64
> >         { "APMC0D0F", APD_ADDR(xgene_i2c_desc) },
> > +       { "BRCM900D", APD_ADDR(vulcan_spi_desc) },
> >  #endif
> >         { }
> >  };
> 
> Could you please review and apply this patch.

It's been queued up for 4.9 already.

Thanks,
Rafael

