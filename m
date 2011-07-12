From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH v2] acpi: introduce "acpi_rsdp=" parameter for kdump
Date: Tue, 12 Jul 2011 09:31:19 -0400
Message-ID: <20110712133119.GA7377@dumpdata.com>
References: <E8CC3FDD41FF9Findou.takao@jp.fujitsu.com>
 <4E1C223A.9000705@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:40386 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752948Ab1GLNbk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Jul 2011 09:31:40 -0400
Content-Disposition: inline
In-Reply-To: <4E1C223A.9000705@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Cong Wang <amwang@redhat.com>
Cc: Takao Indoh <indou.takao@jp.fujitsu.com>, linux-kernel@vger.kernel.org, ebiederm@xmission.com, vgoyal@redhat.com, rdunlap@xenotime.net, lenb@kernel.org, linux-doc@vger.kernel.org, linux-acpi@vger.kernel.org, mjg@redhat.com

On Tue, Jul 12, 2011 at 06:30:18PM +0800, Cong Wang wrote:
> =E4=BA=8E 2011=E5=B9=B407=E6=9C=8811=E6=97=A5 23:14, Takao Indoh =E5=86=
=99=E9=81=93:
> >Revised version of the patch which was posted by Cong WANG
> >
> >Changes in v2:
> >* Change parameter name from "acpi_addr" to "acpi_rsdp"
> >* Add CONFIG_KEXEC
>=20
> Thanks for updating it! Definitely looks good to me,

The only comment I've is that it would be good to include in the
patch description which sysfs attribute is used by the kexec tools
to read in the physical address to be passed in.

Otherwise it looks good to me too.
>=20
> Reviewed-by: WANG Cong <amwang@redhat.com>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
