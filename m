From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: Warning: pnp 00:0b: can't evaluate _CRS: 12311
Date: Mon, 23 Apr 2012 16:04:25 -0600
Message-ID: <CAErSpo5vZSf_EZr6-XnAA8N2Luv6rA92YtZsidWZCZ8rarkPUQ@mail.gmail.com>
References: <CA+icZUWVwUr19xL0Dn5mHnZjQaVjj6VYD3BMMktEWO0vgoZEXw@mail.gmail.com>
 <CA+icZUUGFaz0c-tHa9EGUxZaxPj_M=zrE+kE0dv5UMoA6GyN3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+icZUUGFaz0c-tHa9EGUxZaxPj_M=zrE+kE0dv5UMoA6GyN3w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sedat.dilek@gmail.com
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Adam Belay <abelay@mit.edu>, linux-kernel@vger.kernel.org, Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Mon, Apr 23, 2012 at 6:03 AM, Sedat Dilek <sedat.dilek@googlemail.co=
m> wrote:
> On Mon, Apr 23, 2012 at 11:48 AM, Sedat Dilek
> <sedat.dilek@googlemail.com> wrote:
>> [ Please CC me I am not subscribed to this ML ]
>>
>> Hi,
>>
>> with a self-compiled linux-3.4-rc4 I am seeing this bugs/failures/wa=
rnings:
>>
>> [ =A0 =A00.241572] [Firmware Bug]: ACPI: BIOS _OSI(Linux) query igno=
red
>>
>> [ =A0 =A00.279385] =A0pci0000:00: ACPI _OSC request failed (AE_ERROR=
),
>> returned control mask: 0x1d
>>
>> [ =A0 =A00.293699] system 00:0a: Plug and Play ACPI device, IDs PNP0=
c02 (active)
>> [ =A0 =A00.294032] ACPI Error: Invalid/unsupported resource descript=
or:
>> Type 0x00 (20120320/utresrc-650)
>> [ =A0 =A00.294037] pnp 00:0b: can't evaluate _CRS: 12311
>>
>> The same outputs I have seen also with an unsupported drm-intel-next
>> kernel from Ubuntu/PPA archives [1].
>>
>> What does ist mean? Is it harmless? Buggy firmware/bios?
>>
>> Do you need more background infos (dmesg, kernel-config, etc.)?
>>
>> Regards,
>> - Sedat -
>>
>> [1] http://kernel.ubuntu.com/~kernel-ppa/mainline/drm-intel-next/cur=
rent/
>
> I have upgraded this Samsung series-5 notebook from BIOS version 05XK
> to 06XK, but the pnp/_CRS warning still remains.

Resource type 0 is "reserved" per the ACPI spec, so this is likely a
BIOS defect.  However, we might be able to handle it better than we
currently do.

I would expect all versions of Linux would report this error -- can
you confirm that or identify a version that didn't complain?  Also,
can you collect an acpidump (see
http://www.lesswatts.org/projects/acpi/utilities.php)?

In acpi_ut_validate_resource(), we return AE_AML_INVALID_RESOURCE_TYPE
(0x3017 =3D=3D 12311), which explains the messages you see.  The commen=
ts
in acpi_ut_walk_aml_resources() suggest that we can't continue because
the length may be bogus if the type is invalid.  But I suspect that if
we just treat it as a zero-length descriptor and ignore it, things
will probably work, and that's likely what Windows does.

Bjorn
