From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 0/2] ACPI: Re-factor and remove ./drivers/acpi/atomicio.[ch]
Date: Fri, 28 Oct 2011 09:03:03 -0600
Message-ID: <CAErSpo5waF5Nz92d612tp60bV=oLNyb=yo1xh6_TMhGSvQ07tw@mail.gmail.com>
References: <20110929215907.21126.24480.stgit@amt.stowe> <201110280349.26410.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:53286 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753364Ab1J1PD1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 28 Oct 2011 11:03:27 -0400
Received: from hpaq6.eem.corp.google.com (hpaq6.eem.corp.google.com [172.25.149.6])
	by smtp-out.google.com with ESMTP id p9SF3PP6020523
	for <linux-acpi@vger.kernel.org>; Fri, 28 Oct 2011 08:03:26 -0700
Received: from qyk30 (qyk30.prod.google.com [10.241.83.158])
	by hpaq6.eem.corp.google.com with ESMTP id p9SF1JgB022861
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Fri, 28 Oct 2011 08:03:24 -0700
Received: by qyk30 with SMTP id 30so5644547qyk.5
        for <linux-acpi@vger.kernel.org>; Fri, 28 Oct 2011 08:03:24 -0700 (PDT)
In-Reply-To: <201110280349.26410.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Myron Stowe <myron.stowe@redhat.com>, Len Brown <len.brown@intel.com>, bondd@us.ibm.com, lenb@kernel.org, linux-acpi@vger.kernel.org, rjw@sisk.pl, ying.huang@intel.com

On Thu, Oct 27, 2011 at 7:49 PM, Thomas Renninger <trenn@suse.de> wrote=
:
> On Thursday 29 September 2011 23:59:08 Myron Stowe wrote:
> ..
>> Myron Stowe (2):
>> =A0 =A0 =A0 ACPI: Convert acpi_pre_map_gar()/acpi_atomic_read() and =
remove ./drivers/acpi/atomicio.[ch]
>> =A0 =A0 =A0 ACPI: Export interfaces for ioremapping/iounmapping ACPI=
 registers
>
> Would be great to know whether these are going to be accepted.
> If yes, this check should get removed as well:
>
> drivers/acpi/acpica/hwregs.c:
> acpi_status
> acpi_hw_validate_register(struct acpi_generic_address *reg,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0u8 max_bit_width, =
u64 *address)
> {
> ...
> =A0 =A0 =A0 =A0if (reg->bit_offset !=3D 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ACPI_WARNING((AE_INFO,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"Unsupport=
ed register bit offset: 0x%X",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg->bit_o=
ffset));
> =A0 =A0 =A0 =A0}
>
> because APEI GAR declarations do use bit_offset !=3D 0.

Half of this makes sense to me.  Myron's patch changes APEI from using
acpi_atomic_read() (which doesn't call acpi_hw_validate_register()) to
using acpi_read(), which *does* call it.  So after Myron's patch,
we'll see warnings we didn't see before.

The part that doesn't make sense to me is just removing the warning.
That warning looks to me like it's saying "oops, here's something we
should support, but haven't implemented yet."  Wouldn't it be better
to implement support for bit_offset in acpi_read() at the same time we
remove the warning?  Then Myron could update his patch to drop the
bit_offset support in __apei_exec_read_register() when converting to
acpi_read().

If APEI uses bit_offset !=3D 0, it's at least possible that other areas
will use it in the future, and it'd be nicer to have all the support
in acpi_read() rather than forcing APEI and others to each implement
their own support for it.

Bjorn
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
