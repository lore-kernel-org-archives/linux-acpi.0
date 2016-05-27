From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: IS_ERR_VALUE misuses
Date: Fri, 27 May 2016 13:45:31 -0700
Message-ID: <CAPcyv4immsBDL2vwZnN9QsfCaqKSLShKf-q2vPgw_mDVrTcPcA@mail.gmail.com>
References: <CA+55aFyi8_m0EJGcChe_SW_zzJUTJjPJjhEFbJzEL3gyhFNDLQ@mail.gmail.com>
	<CAPcyv4hpZENy-bh_4a_fAar3Ufe4g6Fxd2mpazCYn_xQJAwxKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:33892 "EHLO
	mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753485AbcE0Upd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 27 May 2016 16:45:33 -0400
Received: by mail-oi0-f47.google.com with SMTP id b65so191703407oia.1
        for <linux-acpi@vger.kernel.org>; Fri, 27 May 2016 13:45:32 -0700 (PDT)
In-Reply-To: <CAPcyv4hpZENy-bh_4a_fAar3Ufe4g6Fxd2mpazCYn_xQJAwxKg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Linux ACPI <linux-acpi@vger.kernel.org>, srinivas.kandagatla@linaro.org

[ Adding Srinivas ]

On Fri, May 27, 2016 at 1:41 PM, Dan Williams <dan.j.williams@intel.com=
> wrote:
> On Fri, May 27, 2016 at 1:15 PM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>> This is just a heads-up: for some reason the acpi layer and nvdimm u=
se
>> the IS_ERR_VALUE() macro, and they use it incorrectly.
>>
>> To see warnings about it, change the macro from
>>
>> #define IS_ERR_VALUE(x) unlikely((x) >=3D (unsigned long)-MAX_ERRNO)
>>
>> to do a cast to a pointer and back (ie make the "(x)" part be
>> "(unsigned long)(void *)(x)" instead, which then will cause warnings
>> like
>>
>>   warning: cast to pointer from integer of different size
>> [-Wint-to-pointer-cast]
>>
>> when passed an "int" argument.
>>
>> The reason "int" arguments are wrong is that the macro really is
>> designed to test the upper range of a pointer value. It happens to
>> work for signed integers too, but looking at the users, pretty much
>> none ofdrivers/nvmem them are right. The ACPI and nvdimm users are a=
ll about the
>> perfectly standard "zero for success, negative error code for
>> failure", and so using
>>
>>     if (IS_ERROR_VALUE(rc))
>>         return rc;
>>
>> is just plain garbage. The code generally should just do
>>
>>     if (rc)
>>         return rc;
>>
>> which is simpler, smaller, and generates better code.
>>
>> This bug seems to have been so common in the power management code
>> that we even have a coccinelle script for it. But for some reason
>> several uses remain in acpi_debug.c and now there are cases in
>> drivers/nvdimm/ too.
>>
>> There are random various crap cases like that elsewhere too, but acp=
i
>> and nvdimm were just more dense with this bug than most other places=
=2E
>>
>> The bug isn't fatal - as mentioned, IS_ERROR_VALUE() _does_ actually
>> work on the range of integers that are normal errors, but it's
>> pointless and actively misleading, and it's not meant for that use. =
So
>> it just adds complexity and worse code generation for no actual gain=
=2E
>>
>> I noticed this when I was looking at similar idiocy in fs/gfs2, wher=
e
>> the code in question caused warnings (for other reasons, but the mai=
n
>> reason was "code too complex for gcc to understand it")
>>
>
> So, I recompiled with that change and didn't see any new warnings.
> While "make coccicheck" did point out the following clean up, I did
> not see where drivers/nvdimm/ passes anything but a pointer to IS_ERR=
,
> what am I missing?


Ah, it looks like this feedback is meant for drivers/nvmem/ not drivers=
/nvdimm/

drivers/nvmem/core.c: In function =E2=80=98bin_attr_nvmem_read=E2=80=99=
:
drivers/nvmem/core.c:116:41: warning: cast to pointer from integer of
different size [-Wint-to-pointer-cast]
drivers/nvmem/core.c: In function =E2=80=98bin_attr_nvmem_write=E2=80=99=
:
drivers/nvmem/core.c:150:41: warning: cast to pointer from integer of
different size [-Wint-to-pointer-cast]
drivers/nvmem/core.c: In function =E2=80=98nvmem_add_cells=E2=80=99:
drivers/nvmem/core.c:369:42: warning: cast to pointer from integer of
different size [-Wint-to-pointer-cast]
drivers/nvmem/core.c: In function =E2=80=98__nvmem_cell_read=E2=80=99:
drivers/nvmem/core.c:966:41: warning: cast to pointer from integer of
different size [-Wint-to-pointer-cast]
drivers/nvmem/core.c: In function =E2=80=98nvmem_cell_read=E2=80=99:
drivers/nvmem/core.c:1001:41: warning: cast to pointer from integer of
different size [-Wint-to-pointer-cast]
drivers/nvmem/core.c: In function =E2=80=98nvmem_cell_write=E2=80=99:
drivers/nvmem/core.c:1086:41: warning: cast to pointer from integer of
different size [-Wint-to-pointer-cast]
drivers/nvmem/core.c: In function =E2=80=98nvmem_device_cell_read=E2=80=
=99:
drivers/nvmem/core.c:1114:41: warning: cast to pointer from integer of
different size [-Wint-to-pointer-cast]
drivers/nvmem/core.c:1118:41: warning: cast to pointer from integer of
different size [-Wint-to-pointer-cast]
drivers/nvmem/core.c: In function =E2=80=98nvmem_device_cell_write=E2=80=
=99:
drivers/nvmem/core.c:1144:41: warning: cast to pointer from integer of
different size [-Wint-to-pointer-cast]
drivers/nvmem/core.c: In function =E2=80=98nvmem_device_read=E2=80=99:
drivers/nvmem/core.c:1173:41: warning: cast to pointer from integer of
different size [-Wint-to-pointer-cast]
drivers/nvmem/core.c: In function =E2=80=98nvmem_device_write=E2=80=99:
drivers/nvmem/core.c:1201:41: warning: cast to pointer from integer of
different size [-Wint-to-pointer-cast]
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
