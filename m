From: Toshi Kani <toshi.kani@hpe.com>
Subject: Re: [PATCH v2 1/3] ACPI/NFIT: Update Control Region Structure to
 comply ACPI 6.1
Date: Tue, 01 Mar 2016 12:10:38 -0700
Message-ID: <1456859438.15454.78.camel@hpe.com>
References: <1456178130-26468-1-git-send-email-toshi.kani@hpe.com>
	 <1456178130-26468-2-git-send-email-toshi.kani@hpe.com>
	 <94F2FBAB4432B54E8AACC7DFDE6C92E37E44D64B@ORSMSX110.amr.corp.intel.com>
	 <1456850284.15454.23.camel@hpe.com>
	 <94F2FBAB4432B54E8AACC7DFDE6C92E37E44D6E1@ORSMSX110.amr.corp.intel.com>
	 <1456853819.15454.45.camel@hpe.com>
	 <94F2FBAB4432B54E8AACC7DFDE6C92E37E44D782@ORSMSX110.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <94F2FBAB4432B54E8AACC7DFDE6C92E37E44D782@ORSMSX110.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "Williams, Dan J" <dan.j.williams@intel.com>
Cc: "Zheng, Lv" <lv.zheng@intel.com>, "elliott@hpe.com" <elliott@hpe.com>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, 2016-03-01 at 17:37 +0000, Moore, Robert wrote:
>=20
> > -----Original Message-----
> > From: Toshi Kani [mailto:toshi.kani@hpe.com]
> > Sent: Tuesday, March 01, 2016 9:37 AM
> > To: Moore, Robert; rjw@rjwysocki.net; Williams, Dan J
> > Cc: Zheng, Lv; elliott@hpe.com; linux-nvdimm@lists.01.org; linux-
> > acpi@vger.kernel.org; linux-kernel@vger.kernel.org; devel@acpica.or=
g
> > Subject: Re: [PATCH v2 1/3] ACPI/NFIT: Update Control Region Struct=
ure
> > to
> > comply ACPI 6.1
> >=20
> > On Tue, 2016-03-01 at 16:03 +0000, Moore, Robert wrote:
> > > We have a bunch of macros in include/acmacros.h -- like this:
> > >=20
> > > ACPI_MOVE_16_TO_16(d, s)
> >=20
> > There is a problem in using the ACPICA byte-swap macros. =C2=A0ACPI=
 is
> > little-endian arch, so the macros are set to perform byte-swappings
> > when the CPU arch is big-endian. =C2=A0This case, however, is the o=
ther way
> > around. =C2=A0The fields in question are defined & stored as arrays=
 of
> > bytes.
>=20
> That's not what I see in the ACPI spec. The fields are defined like a=
ny
> other ACPI table.
>=20
> Vendor ID 2 6=C2=A0
> Identifier indicating the vendor of the NVDIMM.
> This field shall be set to the value of the NVDIMM SPD Module
> Manufacturer ID Code field a with byte 0 set to DDR4 SPD byte
> 320 and byte 1 set to DDR4 SPD byte 321.

They are different from other fields because the spec defines "byte
locations" of the fields. =C2=A0The above case, Vendor ID, is defined t=
hat:
=C2=A0-=C2=A0byte 0 set to DDR4 SPD byte 320
=C2=A0-=C2=A0byte 1 set to DDR4 SPD byte 321

=46or instance, if SPD byte 320 is 0x12 and 321 is 0x34, then this fiel=
d is
stored as (0x12, 0x34). =C2=A0If you read this field as a 16-bit int va=
lue, you
will get 0x3412 on little-endian CPUs, such as x86.

Section 5.2.25.9 of ACPI 6.1 further clarifies that Vendor ID needs to =
be
represented as ("%02x%02x", byte0, byte1), which is "1234" in this case=
=2E

So, we will need to byte-swap when it is handled as a 16-bit int value =
on
little-endian CPUs. =C2=A0This is different from other fields with mult=
i-byte
numeric values, which are stored in little-endian format in ACPI.

Hence, my patch avoids this byte-swapping as I described in the change =
log
below.

|=C2=A0=C2=A0- Change 'struct acpi_nfit_control_region' to reflect the =
update.
|=C2=A0=C2=A0=C2=A0=C2=A0SPD IDs are defined as arrays of bytes, so tha=
t they can be
|=C2=A0=C2=A0=C2=A0=C2=A0treated in the same way regardless of CPU endi=
anness and are
|=C2=A0=C2=A0=C2=A0=C2=A0not miss-treated as little-endian numeric valu=
es.

I hope this makes it clear now.

> > Another issue is that it is not clear who needs to perform the byte=
-
> > swapping among ACPICA and drivers.=C2=A0=C2=A0If ACPICA, drivers mu=
st agree that
>
> ACPICA does not ever do anything with the "data tables" like NFIT, ot=
her
> than handing off the table when requested by a driver.

So, this means that the alternative is to change the NFIT driver to do =
the
byte-swapping for the fields when the CPU arch is little-endian. =C2=A0=
If we
cannot change the structure, we will have to take this course...

Thanks,
-Toshi
