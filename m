From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] nfit: add Microsoft NVDIMM DSM command set to white list
Date: Wed, 8 Jun 2016 16:13:47 -0700
Message-ID: <CAPcyv4hT158NnSZ-RwK3Y-AYxNmJMbDXuvY2MN3xFye0S9nePg@mail.gmail.com>
References: <5cff32b5-7849-4e9d-0ba8-1f12e21814a9@gmail.com>
	<790a33bd-98e9-89c8-6667-e135ada69f80@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f51.google.com ([209.85.218.51]:33999 "EHLO
	mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424341AbcFHXNs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Jun 2016 19:13:48 -0400
Received: by mail-oi0-f51.google.com with SMTP id e72so37476367oib.1
        for <linux-acpi@vger.kernel.org>; Wed, 08 Jun 2016 16:13:48 -0700 (PDT)
In-Reply-To: <790a33bd-98e9-89c8-6667-e135ada69f80@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Stuart Hayes <stuart.w.hayes@gmail.com>
Cc: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Ross Zwisler <ross.zwisler@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux ACPI <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wed, Jun 8, 2016 at 2:47 PM, Stuart Hayes <stuart.w.hayes@gmail.com> wrote:
>
>
> On 5/26/2016 11:38 AM, Stuart Hayes wrote:
>>
>> Add the Microsoft _DSM command set to the white list of NVDIMM command
>> sets.
>>
>> This command set is documented at
>> https://msdn.microsoft.com/library/windows/hardware/mt604741.
>>
>> Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
>> ---
>>  drivers/acpi/nfit.c        | 9 ++++++---
>>  drivers/acpi/nfit.h        | 4 ++++
>>  include/uapi/linux/ndctl.h | 1 +
>>  3 files changed, 11 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/acpi/nfit.c b/drivers/acpi/nfit.c
>> index 2215fc8..48fc575 100644
>> --- a/drivers/acpi/nfit.c
>> +++ b/drivers/acpi/nfit.c
>> @@ -1130,11 +1130,11 @@ static int acpi_nfit_add_dimm(struct
>> acpi_nfit_desc *acpi_desc,
>>      }
>>
>>      /*
>> -     * Until standardization materializes we need to consider up to 3
>> +     * Until standardization materializes we need to consider several
>>       * different command sets.  Note, that checking for function0 (bit0)
>>       * tells us if any commands are reachable through this uuid.
>>       */
>> -    for (i = NVDIMM_FAMILY_INTEL; i <= NVDIMM_FAMILY_HPE2; i++)
>> +    for (i = NVDIMM_FAMILY_INTEL; i <= NVDIMM_FAMILY_MSFT; i++)
>>          if (acpi_check_dsm(adev_dimm->handle, to_nfit_uuid(i), 1, 1))
>>              break;
>>
>> @@ -1150,7 +1150,9 @@ static int acpi_nfit_add_dimm(struct acpi_nfit_desc
>> *acpi_desc,
>>          dsm_mask = 0x1fe;
>>          if (disable_vendor_specific)
>>              dsm_mask &= ~(1 << 8);
>> -    } else {
>> +    } else if (nfit_mem->family == NVDIMM_FAMILY_MSFT)
>> +        dsm_mask = 0xffffffff;
>> +    else {
>>          dev_err(dev, "unknown dimm command family\n");
>>          nfit_mem->family = -1;
>>          return force_enable_dimms ? 0 : -ENODEV;
>> @@ -2692,6 +2694,7 @@ static __init int nfit_init(void)
>>      acpi_str_to_uuid(UUID_NFIT_DIMM, nfit_uuid[NFIT_DEV_DIMM]);
>>      acpi_str_to_uuid(UUID_NFIT_DIMM_N_HPE1,
>> nfit_uuid[NFIT_DEV_DIMM_N_HPE1]);
>>      acpi_str_to_uuid(UUID_NFIT_DIMM_N_HPE2,
>> nfit_uuid[NFIT_DEV_DIMM_N_HPE2]);
>> +    acpi_str_to_uuid(UUID_NFIT_DIMM_N_MSFT,
>> nfit_uuid[NFIT_DEV_DIMM_N_MSFT]);
>>
>>      nfit_wq = create_singlethread_workqueue("nfit");
>>      if (!nfit_wq)
>> diff --git a/drivers/acpi/nfit.h b/drivers/acpi/nfit.h
>> index 11cb383..f06fa91 100644
>> --- a/drivers/acpi/nfit.h
>> +++ b/drivers/acpi/nfit.h
>> @@ -31,6 +31,9 @@
>>  #define UUID_NFIT_DIMM_N_HPE1 "9002c334-acf3-4c0e-9642-a235f0d53bc6"
>>  #define UUID_NFIT_DIMM_N_HPE2 "5008664b-b758-41a0-a03c-27c2f2d04f7e"
>>
>> +/* https://msdn.microsoft.com/library/windows/hardware/mt604741 */
>> +#define UUID_NFIT_DIMM_N_MSFT "1ee68b36-d4bd-4a1a-9a16-4f8e53d46e05"
>> +
>>  #define ACPI_NFIT_MEM_FAILED_MASK (ACPI_NFIT_MEM_SAVE_FAILED \
>>          | ACPI_NFIT_MEM_RESTORE_FAILED | ACPI_NFIT_MEM_FLUSH_FAILED \
>>          | ACPI_NFIT_MEM_NOT_ARMED)
>> @@ -40,6 +43,7 @@ enum nfit_uuids {
>>      NFIT_DEV_DIMM = NVDIMM_FAMILY_INTEL,
>>      NFIT_DEV_DIMM_N_HPE1 = NVDIMM_FAMILY_HPE1,
>>      NFIT_DEV_DIMM_N_HPE2 = NVDIMM_FAMILY_HPE2,
>> +    NFIT_DEV_DIMM_N_MSFT = NVDIMM_FAMILY_MSFT,
>>      NFIT_SPA_VOLATILE,
>>      NFIT_SPA_PM,
>>      NFIT_SPA_DCR,
>> diff --git a/include/uapi/linux/ndctl.h b/include/uapi/linux/ndctl.h
>> index 309915f..ba5a8c7 100644
>> --- a/include/uapi/linux/ndctl.h
>> +++ b/include/uapi/linux/ndctl.h
>> @@ -298,6 +298,7 @@ struct nd_cmd_pkg {
>>  #define NVDIMM_FAMILY_INTEL 0
>>  #define NVDIMM_FAMILY_HPE1 1
>>  #define NVDIMM_FAMILY_HPE2 2
>> +#define NVDIMM_FAMILY_MSFT 3
>>
>>  #define ND_IOCTL_CALL            _IOWR(ND_IOCTL, ND_CMD_CALL,\
>>                      struct nd_cmd_pkg)
>
>
> Is there a problem with this patch?  I never saw any responses, and wasn't
> sure if maybe I goofed.  Thanks!

Nope, looks ok.  I'll put it through unit testing and get it applied.
