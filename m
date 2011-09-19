From: Lin Ming <ming.m.lin@intel.com>
Subject: Re: bug report: ACPI Error: [RAMB] Namespace lookup failure,
 AE_NOT_FOUND (20110112/psargs-359)
Date: Mon, 19 Sep 2011 08:23:34 +0800
Message-ID: <CAF1ivSa45AFa5bVWx32qCVNUCfAoEk4ZNSjmy3B1E47kE9VvWQ@mail.gmail.com>
References: <CACAe89zvHM7Dz4X1_aTjFt6JpLSJOTWn6HdhyUHCM81+=0Uv=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qw0-f42.google.com ([209.85.216.42]:36785 "EHLO
	mail-qw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751209Ab1ISAXe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 18 Sep 2011 20:23:34 -0400
Received: by qwi4 with SMTP id 4so13421125qwi.1
        for <linux-acpi@vger.kernel.org>; Sun, 18 Sep 2011 17:23:34 -0700 (PDT)
In-Reply-To: <CACAe89zvHM7Dz4X1_aTjFt6JpLSJOTWn6HdhyUHCM81+=0Uv=w@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jim Green <student.northwestern@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Mon, Sep 19, 2011 at 1:18 AM, Jim Green
<student.northwestern@gmail.com> wrote:
> Hello:
>
> I am running 2.6.38.8-4 kernel on p8p67 deluxe motherboard(bios
> version 1702, latest stable)
>
> 2357 Sep 18 13:05:07 localhost kernel: [ =A0 =A01.045727] ACPI: EC: L=
ook
> up EC in DSDT
> 2358 Sep 18 13:05:07 localhost kernel: [ =A0 =A01.046535] ACPI: Execu=
ted 1
> blocks of module-level executable AML code
> 2359 Sep 18 13:05:07 localhost kernel: [ =A0 =A01.049876] ACPI Error:
> [RAMB] Namespace lookup failure, AE_NOT_FOUND (20110112/psargs-359)
> 2360 Sep 18 13:05:07 localhost kernel: [ =A0 =A01.049880] ACPI Except=
ion:
> AE_NOT_FOUND, Could not execute arguments for [RAMW] (Region)
> (20110112/ =A0 =A0 =A0 =A0 nsinit-349)
> 2361 Sep 18 13:05:07 localhost kernel: [ =A0 =A01.050347] ACPI: SSDT
> 00000000df5d4818 0079C (v01 =A0 =A0AMI =A0 =A0 =A0IST 00000001 MSFT 0=
3000001)
> 2362 Sep 18 13:05:07 localhost kernel: [ =A0 =A01.050805] ACPI: Dynam=
ic
> OEM Table Load:
> 2363 Sep 18 13:05:07 localhost kernel: [ =A0 =A01.050807] ACPI: SSDT
> =A0 =A0(null) 0079C (v01 =A0 =A0AMI =A0 =A0 =A0IST 00000001 MSFT 0300=
0001)
> 2364 Sep 18 13:05:07 localhost kernel: [ =A0 =A01.050883] ACPI: SSDT
> 00000000df5dba18 0021C (v01 =A0 =A0AMI =A0 =A0 =A0CST 00000001 MSFT 0=
3000001)
> 2365 Sep 18 13:05:07 localhost kernel: [ =A0 =A01.051168] ACPI: Dynam=
ic
> OEM Table Load:
> 2366 Sep 18 13:05:07 localhost kernel: [ =A0 =A01.051169] ACPI: SSDT
> =A0 =A0(null) 0021C (v01 =A0 =A0AMI =A0 =A0 =A0CST 00000001 MSFT 0300=
0001)
> 2367 Sep 18 13:05:07 localhost kernel: [ =A0 =A01.052510] ACPI: Inter=
preter enabled
> 2368 Sep 18 13:05:07 localhost kernel: [ =A0 =A01.052512] ACPI: (supp=
orts
> S0 S1 S3 S4 S5)
> 2369 Sep 18 13:05:07 localhost kernel: [ =A0 =A01.052530] ACPI: Using
> IOAPIC for interrupt routing
>
> Could anyone help how to fix this error?.. is this bug fixed in some
> later kernel versions?

Could you attach the acpidump output?

Regards,
Lin Ming
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
