From: Zhang Rui <rui.zhang@intel.com>
Subject: RE: [RESEND] [PATCH 3/6] ACPI: create sysfs I/F for inactive tables
Date: Mon, 17 Nov 2008 10:01:37 +0800
Message-ID: <1226887297.15014.244.camel@rzhang-dt>
References: <1226478545.15014.173.camel@rzhang-dt>
	 <982D8D05B6407A49AD506E6C3AC8E7D6BEF9369129@caralain.haven.nynaeve.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:10860 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754567AbYKQCBm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 16 Nov 2008 21:01:42 -0500
In-Reply-To: <982D8D05B6407A49AD506E6C3AC8E7D6BEF9369129@caralain.haven.nynaeve.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Skywing <Skywing@valhallalegends.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, "Moore, Robert" <robert.moore@intel.com>

On Thu, 2008-11-13 at 04:32 +0800, Skywing wrote:
> Zhang Rui wrote:
>=20
> > +		if (strncmp(table_attr->name, "NULL", ACPI_NAME_SIZE))
> > +			memcpy(name, table_attr->name, ACPI_NAME_SIZE);
> > +		else
> > +			memcpy(name, "\0\0\0\0", ACPI_NAME_SIZE);
> > +		status =3D acpi_get_table(name,
> > +					table_attr->instance, &table_header);
>=20
>  Minor nit / suggestion: Wouldn't it be a bit better to use memset in=
stead
>  of memcpy for the \0\0\0\0 memcpy case?
that works as well.

>  Otherwise, you need to make sure
>  that you have at least as many \0's in the string literal as ACPI_NA=
ME_SIZE,
>  which is a lil bit ugly.
>  If you are cleaning things up to use symbolic constants there, you m=
ight consider changing it to a memset while you're at it.
>=20
=EF=BB=BFwell, we have an ugly ACPI table here, with the signature =EF=BB=
=BF"\0\0\0\0".
and the code =EF=BB=BFmemcpy(name, "\0\0\0\0", ACPI_NAME_SIZE) is used =
to set a
valid table signature rather than clearing this piece of memeory.
so IMO, using memcpy also makes sense here. :)

thanks,
rui

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
