From: Ilia Mirkin <imirkin@alum.mit.edu>
Subject: Re: ACPI info has non-printable chars
Date: Tue, 12 Jan 2010 20:43:13 -0500
Message-ID: <87d699441001121743y66284e28y4c8dceb5c17a4183@mail.gmail.com>
References: <87d699441001121415y6b37ed63v25b1913ccc959d46@mail.gmail.com>
	 <1263344599.12263.2251.camel@rzhang1-desktop>
	 <1263345583.3598.58.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.24]:23816 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751430Ab0AMBnO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Jan 2010 20:43:14 -0500
Received: by qw-out-2122.google.com with SMTP id 8so3500800qwh.37
        for <linux-acpi@vger.kernel.org>; Tue, 12 Jan 2010 17:43:13 -0800 (PST)
In-Reply-To: <1263345583.3598.58.camel@minggr.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Tue, Jan 12, 2010 at 8:19 PM, Lin Ming <ming.m.lin@intel.com> wrote:
> On Wed, 2010-01-13 at 09:03 +0800, Zhang, Rui wrote:
>> CC Lin Ming, the ACPICA expert.
>>
>> On Wed, 2010-01-13 at 06:15 +0800, Ilia Mirkin wrote:
>> > Hi,
>> >
>> > I just got a new motherboard (GIGABYTE GA-EX58-UD3R) and I'm seein=
g
>> > the following in the kernel log (2.6.31-gentoo-r6, which I believe=
 is
>> > basically 2.6.31.6)
>> >
>> > ...
>> > [ =A0 =A00.000000] ACPI: TAMG 00000000cfee7330 00AE2 (v01 GBT =A0 =
=A0GBT =A0 B0
>> > 5455312E BG^A^A 53450101)
>>
>> non-printable chars in Creator ID field.
>>
>> > ...
>> > [ =A0 =A00.713697] ACPI Warning: Incorrect checksum in table [TAMG=
] - 9D,
>> > should be 9C 20090521 tbutils-246
>> >
>> > acpidump shows:
>> >
>> > TAMG @ 0xcfee7330
>> > =A0 0000: 54 41 4d 47 e2 0a 00 00 01 9d 47 42 54 20 20 20 =A0TAMG.=
=2E....GBT
>> > =A0 0010: 47 42 54 20 20 20 42 30 2e 31 55 54 42 47 01 01 =A0GBT =A0=
 B0.1UTBG..
>> > =A0 0020: 01 01 45 53 44 54 3d 20 ef 00 08 00 0f 00 2c 01 =A0..ESD=
T=3D ......,.
>> >
>> > So those ^A's are really in there, but it's a little annoying (and=
 it
>> > causes less to go into binary viewing mode when it shows up in
>> > /var/log/messages). Would it be reasonable to add some kind of
>> > escaping code for such situations so that it might print like
>> > "BG\x01\x01"?
>> >
>>
>> Ming, any comments on this?
>
> Ilia, please try 2.6.32, that we support non-printable characters.
> See below commit.
>
> commit cf02cd47d4747abf8ff0617e15fc05a00202e6d5
> Author: Bob Moore <robert.moore@intel.com>
> Date: =A0 Wed Jun 24 11:38:46 2009 +0800
>
> =A0 =A0ACPICA: Dump table header - suppress output of non-printable c=
haracters
>
> =A0 =A0Function acpi_tb_print_table_header. Some ACPI tables contain
> =A0 =A0non-printable characters in one of the string fields of the th=
e
> =A0 =A0header - Signature, OemId, OemTableId, or CompilerId. Invalid
> =A0 =A0characters are replaced by '?'. ACPICA BZ 788.
>
> =A0 =A0http://acpica.org/bugzilla/show_bug.cgi?id=3D788
>
> =A0 =A0Signed-off-by: Bob Moore <robert.moore@intel.com>
> =A0 =A0Signed-off-by: Lin Ming <ming.m.lin@intel.com>
> =A0 =A0Signed-off-by: Len Brown <len.brown@intel.com>
>

Ah yes, that will almost certainly fix it. Thanks for tracking that
down, and apologies for the noise. I will be sure to respond if the
problem still appears with the latest kernels.

Thanks,

--=20
Ilia Mirkin
imirkin@alum.mit.edu
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
