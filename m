From: Lin Ming <ming.m.lin@intel.com>
Subject: Re: [BUG] ACPI resource validation not working [Was: Re: ITE 8728F]
Date: Mon, 12 Dec 2011 20:42:50 +0800
Message-ID: <CAF1ivSaN6V5tz6ttUL9_1htFjVX8qEVv-eCq04s=_nPAaDMH6g@mail.gmail.com>
References: <CAKPcRGofYw_DcVL1QDorSp8Gr1ZL6-ur=oZnDs0w_e91ZuwKbQ@mail.gmail.com>
	<94F2FBAB4432B54E8AACC7DFDE6C92E316EE2575@ORSMSX101.amr.corp.intel.com>
	<1322531323.1467.10.camel@minggr>
	<CAKPcRGpXP=A-WHVLyvf_ZazY8br5d4-CxrDpnCbpJbcsnMVpiQ@mail.gmail.com>
	<1323396109.27764.44.camel@minggr>
	<20111212103726.56422cbb@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:52434 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752606Ab1LLMmv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 12 Dec 2011 07:42:51 -0500
Received: by qcqz2 with SMTP id z2so3461837qcq.19
        for <linux-acpi@vger.kernel.org>; Mon, 12 Dec 2011 04:42:51 -0800 (PST)
In-Reply-To: <20111212103726.56422cbb@endymion.delvare>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: Luca Tettamanti <kronos.it@gmail.com>, "Moore, Robert" <robert.moore@intel.com>, Nikolay Mikov <nik.mikov@gmail.com>, Thomas <trenn@suse.de>, linux-acpi@vger.kernel.org, lenb <lenb@kernel.org>

On Mon, Dec 12, 2011 at 5:37 PM, Jean Delvare <khali@linux-fr.org> wrot=
e:
> Hi Lin,
>
> On Fri, 09 Dec 2011 10:01:49 +0800, Lin Ming wrote:
>> On Tue, 2011-11-29 at 21:18 +0800, Luca Tettamanti wrote:
>> > On Tue, Nov 29, 2011 at 2:48 AM, Lin Ming <ming.m.lin@intel.com> w=
rote:
>> > > Yes, we should put the call back.
>> >
>> > Great, are you going to push this patch yourself?
>>
>> We have investigated this issue more and think that it's better to m=
ove
>> the resource validation code into ACPICA core.
>>
>> Here is the new patch.
>>
>> The major changes include:
>> - Remove acpi_os_validate_address/acpi_os_invalidate_address from os=
l.c.
>> =A0 They are reimplemented in ACPICA core:
>> =A0 acpi_ut_add_address_range/acpi_ut_remove_address_range.
>>
>> - Add new interface for drivers to check resource conflict:
>> =A0 acpi_check_address_range
>>
>> Could you help to test it?
>
> I have no objection for an upstream patch, but the main problem we ha=
ve
> at the moment is with already released kernels. Versions 2.6.39, 3.0
> and 3.1 currently have a regression as the ACPI resource conflict
> checks are inefficient, and this allows conflicting drivers to be
> loaded together. So you are free to reimplement things differently in
> version 3.2 and later, but for these 3 older versions we need the
> smallest possible patch, so that it is accepted in stable branches.
>
> In other words, I would like two patches, one just adding back the co=
de
> that was accidentally dropped, and a second one moving things around =
if
> you think it makes sense (and I tend to agree.) That way we can easil=
y
> backport only the first patch to kernel versions 2.6.39 to 3.1.

Sure.

I have send out the patch.

[PATCH] ACPICA: Put back the call to acpi_os_validate_address
http://marc.info/?l=3Dlinux-acpi&m=3D132257617527119&w=3D2

Regards,
Lin Ming
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
