From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Question about FADT length
Date: Wed, 07 May 2014 16:14:18 +0800
Message-ID: <5369EB5A.6070906@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:48300 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755217AbaEGIO3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 May 2014 04:14:29 -0400
Received: by mail-pd0-f182.google.com with SMTP id v10so745712pde.13
        for <linux-acpi@vger.kernel.org>; Wed, 07 May 2014 01:14:28 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>

Hi,

I ran into some compile errors when I was prototyping the code
for the proposals in ASWG, it turns out that some field in FADT is
changed and "reserved4[0]" used in ACPI_FADT_V2_SIZE will
cause the error.

So my question is that the length of very version of FADT is
fixed, why not use a constant value for this puspose?

Here is the code:

/*
  * Sizes of the various flavors of FADT. We need to look closely
  * at the FADT length because the version number essentially tells
  * us nothing because of many BIOS bugs where the version does not
  * match the expected length. In other words, the length of the
  * FADT is the bottom line as to what the version really is.
  *
  * For reference, the values below are as follows:
  *     FADT V1  size: 0x074
  *     FADT V2  size: 0x084
  *     FADT V3  size: 0x0F4
  *     FADT V4  size: 0x0F4
  *     FADT V5  size: 0x10C
  */
#define ACPI_FADT_V1_SIZE       (u32) (ACPI_FADT_OFFSET (flags) + 4)
#define ACPI_FADT_V2_SIZE       (u32) (ACPI_FADT_OFFSET (reserved4[0]) + 3)
#define ACPI_FADT_V3_SIZE       (u32) (ACPI_FADT_OFFSET (sleep_control))
#define ACPI_FADT_V5_SIZE       (u32) (sizeof (struct acpi_table_fadt))

Why not  #define ACPI_FADT_V1_SIZE 0x074 ?
Did I miss something? any clarify will be appreciated :)

Thanks
Hanjun
