From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 65/73] ACPICA: Fix for extraneous debug message for packages
Date: Tue, 22 Apr 2008 15:23:22 -0400
Message-ID: <200804221523.22999.lenb@kernel.org>
References: <1207974356-30687-1-git-send-email-lenb@kernel.org> <200804150309.25361.lenb@kernel.org> <48046902.8040900@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:47842 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757106AbYDVVlz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 22 Apr 2008 17:41:55 -0400
In-Reply-To: <48046902.8040900@gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>

On Tuesday 15 April 2008, Alexey Starikovskiy wrote:
> Len Brown wrote:
> > From: Len Brown <len.brown@intel.com>
> >
> > drivers/acpi/dispatcher/dsobject.c:499: warning: format =91%X=92 ex=
pects type =91unsigned int=92, but argument 4 has type =91acpi_native_u=
int=92
> > drivers/acpi/dispatcher/dsobject.c:507: warning: format =91%X=92 ex=
pects type =91unsigned int=92, but argument 7 has type =91acpi_native_u=
int=92
> >
> > Signed-off-by: Len Brown <len.brown@intel.com>
> > ---
> >  drivers/acpi/dispatcher/dsobject.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/drivers/acpi/dispatcher/dsobject.c b/drivers/acpi/disp=
atcher/dsobject.c
> > index 5184278..bdef2f0 100644
> > --- a/drivers/acpi/dispatcher/dsobject.c
> > +++ b/drivers/acpi/dispatcher/dsobject.c
> > @@ -373,7 +373,7 @@ acpi_ds_build_internal_package_obj(struct acpi_=
walk_state *walk_state,
> >  	union acpi_parse_object *parent;
> >  	union acpi_operand_object *obj_desc =3D NULL;
> >  	acpi_status status =3D AE_OK;
> > -	acpi_native_uint i;
> > +	u32 i;
> >  =20
> why not just unsigned ?

> >  	u16 index;
> >  	u16 reference_count;

No particular reason, u32 and unsigned are synonyms on the architecture=
s we care about.
Now that you point it out, i prefer unsigned, and will go with that.

This is used as an index into the arrary of elements in a package, so 8=
-bits
would probably work just as well.  Certainly acpi_native_uint was overk=
ill.

-Len
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
