From: Lan Tianyu <lantianyu1986@gmail.com>
Subject: Re: [PATCH 2/4] ACPI: export symbol acpi_get_table_with_size
Date: Wed, 22 Aug 2012 16:31:37 +0800
Message-ID: <CAOLK0pwyHKb7fMsJU27Vqb3O-XCBM1X44w28+OYorkjsMFdSqQ@mail.gmail.com>
References: <20120817170313.GA11909@srcf.ucam.org>
	<1345475993-23853-1-git-send-email-alexdeucher@gmail.com>
	<1345475993-23853-2-git-send-email-alexdeucher@gmail.com>
	<CADnq5_MnkMp8tmVX1J4xJRXxiTs4kjdXGbB+gPgbNTD24yjByg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:33285 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750769Ab2HVIbi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 22 Aug 2012 04:31:38 -0400
In-Reply-To: <CADnq5_MnkMp8tmVX1J4xJRXxiTs4kjdXGbB+gPgbNTD24yjByg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alex Deucher <alexdeucher@gmail.com>
Cc: airlied@gmail.com, dri-devel@lists.freedesktop.org, equinox@diac24.net, linux-acpi@vger.kernel.org, Alex Deucher <alexander.deucher@amd.com>, stable@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>, feng.tang@intel.com, robert.moore@intel.com

2012/8/21 Alex Deucher <alexdeucher@gmail.com>:
> Any objections from the ACPI folks to this patch going into 3.6 and stable?
>
hi Alex:
                I saw the patch from Feng Tang.
http://marc.info/?l=linux-acpi&m=134380363332502&w=2
which is trying to replace acpi_get_table_with_size() with
acpi_get_table(). Since the size can be get
via struct acpi_table_header->length, acpi_get_table_with_size() is
redundant and it will be removed.
> Alex
>
> On Mon, Aug 20, 2012 at 11:19 AM,  <alexdeucher@gmail.com> wrote:
>> From: Alex Deucher <alexander.deucher@amd.com>
>>
>> We need it in the radeon drm module to fetch
>> and verify the vbios image on UEFI systems.
>>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> Cc: stable@vger.kernel.org
>> ---
>>  drivers/acpi/acpica/tbxface.c |    1 +
>>  1 files changed, 1 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/acpi/acpica/tbxface.c b/drivers/acpi/acpica/tbxface.c
>> index ea4c6d5..29e51bc 100644
>> --- a/drivers/acpi/acpica/tbxface.c
>> +++ b/drivers/acpi/acpica/tbxface.c
>> @@ -387,6 +387,7 @@ acpi_get_table_with_size(char *signature,
>>
>>         return (AE_NOT_FOUND);
>>  }
>> +ACPI_EXPORT_SYMBOL(acpi_get_table_with_size)
>>
>>  acpi_status
>>  acpi_get_table(char *signature,
>> --
>> 1.7.7.5
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best regards
Tianyu Lan
