From: li guang <lig.fnst@cn.fujitsu.com>
Subject: Re: [PATCH RFC v2 2/3] ec: add ec space notifier
Date: Mon, 10 Jun 2013 08:46:54 +0800
Message-ID: <1370825214.21655.20.camel@liguang.fnst.cn.fujitsu.com>
References: <1370482835-764-1-git-send-email-lig.fnst@cn.fujitsu.com>
	 <1370482835-764-3-git-send-email-lig.fnst@cn.fujitsu.com>
	 <10739719.ouMOhAfYPv@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <10739719.ouMOhAfYPv@vostro.rjw.lan>
Sender: platform-driver-x86-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <lenb@kernel.org>, Matthew Garrett <matthew.garrett@nebula.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, Andreas =?ISO-8859-1?Q?F=E4rber?= <afaerber@suse.de>, Igor Mammedov <imammedo@redhat.com>
List-Id: linux-acpi@vger.kernel.org

=E5=9C=A8 2013-06-06=E5=9B=9B=E7=9A=84 12:59 +0200=EF=BC=8CRafael J. Wy=
socki=E5=86=99=E9=81=93=EF=BC=9A
> On Thursday, June 06, 2013 09:40:34 AM liguang wrote:
> > add a notifier for anyone who are instresting in
> > ec space changing.
> >=20
> > Signed-off-by: liguang <lig.fnst@cn.fujitsu.com>
>=20
> I'm not going to apply this anyway, but can you please explain what's=
 the
> problem you're trying to solve here?

OK, currently it is for QEMU to do cpu online automatically after
hot-plug a cpu,
and maybe potentially for real platform's cpu
plug/unplug implementation.
with this notifier, we don't need any GPIOes,IO ports, and other
hardware cost if we do have an EC chip in board to trigger kernel's=20
cpu process for this.

Yep, you said you'll reject this anyway,
but I have to ask do this notifier offend
any rules of your development?
or some other reasons?

Thanks!

>=20
> > ---
> >  drivers/acpi/ec.c    |   32 ++++++++++++++++++++++++++++++++
> >  include/linux/acpi.h |    2 ++
> >  2 files changed, 34 insertions(+), 0 deletions(-)
> >=20
> > diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> > index edc0081..dee3417 100644
> > --- a/drivers/acpi/ec.c
> > +++ b/drivers/acpi/ec.c
> > @@ -124,6 +124,35 @@ static int EC_FLAGS_MSI; /* Out-of-spec MSI co=
ntroller */
> >  static int EC_FLAGS_VALIDATE_ECDT; /* ASUStec ECDTs need to be val=
idated */
> >  static int EC_FLAGS_SKIP_DSDT_SCAN; /* Not all BIOS survive early =
DSDT scan */
> > =20
> > +/* notifier chain for who are intresting in ec space changing */
> > +static RAW_NOTIFIER_HEAD(ec_space_chain);
> > +
> > +int __ref register_ec_space_notifier(struct notifier_block *nb)
> > +{
> > +        int ret;
> > +
> > +        ret =3D raw_notifier_chain_register(&ec_space_chain, nb);
> > +
> > +        return ret;
> > +}
> > +EXPORT_SYMBOL(register_ec_space_notifier);
> > +
> > +void __ref unregister_ec_space_notifier(struct notifier_block *nb)
> > +{
> > +
> > +        raw_notifier_chain_unregister(&ec_space_chain, nb);
> > +}
> > +EXPORT_SYMBOL(unregister_ec_space_notifier);
> > +
> > +static int ec_space_notify(void *data)
> > +{
> > +    int ret;
> > +
> > +    ret =3D __raw_notifier_call_chain(&ec_space_chain, 0, data, -1=
, NULL);
> > +
> > +     return notifier_to_errno(ret);
> > +}
> > +
> >  /* ---------------------------------------------------------------=
-----------
> >                               Transaction Management
> >     ---------------------------------------------------------------=
----------- */
> > @@ -638,6 +667,9 @@ static u32 acpi_ec_gpe_handler(acpi_handle gpe_=
device,
> >  		wake_up(&ec->wait);
> >  		ec_check_sci(ec, acpi_ec_read_status(ec));
> >  	}
> > +
> > +	ec_space_notify(data);
> > +
> >  	return ACPI_INTERRUPT_HANDLED | ACPI_REENABLE_GPE;
> >  }
> > =20
> > diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> > index 17b5b59..4fe2247 100644
> > --- a/include/linux/acpi.h
> > +++ b/include/linux/acpi.h
> > @@ -158,6 +158,8 @@ extern int ec_transaction(u8 command,
> >                            const u8 *wdata, unsigned wdata_len,
> >                            u8 *rdata, unsigned rdata_len);
> >  extern acpi_handle ec_get_handle(void);
> > +extern int register_ec_space_notifier(struct notifier_block *nb);
> > +extern void unregister_ec_space_notifier(struct notifier_block *nb=
);
> > =20
> >  #if defined(CONFIG_ACPI_WMI) || defined(CONFIG_ACPI_WMI_MODULE)
> > =20
> >=20
