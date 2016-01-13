From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: ACPICA serialized objects?
Date: Wed, 13 Jan 2016 14:57:16 -0800
Message-ID: <CALCETrUBVD-wjj2+-m-+yFk4WQB=hjWHJRWADG46_2L_AkXxVw@mail.gmail.com>
References: <CALCETrWFSs0Ornr9airzqL=9ph06WDghOUaKmA_8cAorrw1Kpw@mail.gmail.com>
 <CAJZ5v0gxE2kN75K4F9TxNAhz1Xb0zoi1CMn_R36OPeBHuQ9-Qw@mail.gmail.com>
 <CALCETrXnbVCnisYrq_+GrT0PPqi6tG51TBtcx1rnQTdbLetK0A@mail.gmail.com>
 <CAJZ5v0jygkagyqwvEmtXPKXkhEFnspTj9XPgjeRowfsV5_Kjvw@mail.gmail.com>
 <CALCETrVE9De-o29seijHRUwTMYGx4As_zOin=xQkTjbGviCUJA@mail.gmail.com>
 <1AE640813FDE7649BE1B193DEA596E883BAFAE98@SHSMSX101.ccr.corp.intel.com>
 <CALCETrVXE5CiqHbQoO72-xwYSahrSfvJi_khzP8gQRfMwpk+1Q@mail.gmail.com> <94F2FBAB4432B54E8AACC7DFDE6C92E37DA84A4B@ORSMSX112.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f53.google.com ([209.85.218.53]:35141 "EHLO
	mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750943AbcAMW5h (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 13 Jan 2016 17:57:37 -0500
Received: by mail-oi0-f53.google.com with SMTP id p187so86172925oia.2
        for <linux-acpi@vger.kernel.org>; Wed, 13 Jan 2016 14:57:36 -0800 (PST)
In-Reply-To: <94F2FBAB4432B54E8AACC7DFDE6C92E37DA84A4B@ORSMSX112.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: "Zheng, Lv" <lv.zheng@intel.com>, Andy Lutomirski <luto@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>

On Wed, Jan 13, 2016 at 2:49 PM, Moore, Robert <robert.moore@intel.com> wrote:
>
>
>> -----Original Message-----
>> From: Andy Lutomirski [mailto:luto@amacapital.net]
>> Sent: Wednesday, January 13, 2016 2:32 PM
>> To: Zheng, Lv
>> Cc: Andy Lutomirski; Rafael J. Wysocki; Linux ACPI; Moore, Robert
>> Subject: Re: ACPICA serialized objects?
>>
>>
>> I finally had some time to play with the ACPI debugger, and it's
>> fantastic.  Thanks!
>>
>> One minor feature request: have you considered adding readline or libedit
>> support?
>
> We actually have "readline" style support in at least acpiexec (which uses
> The AML debugger):
>
> /******************************************************************************
>  *
>  * FUNCTION:    OsEnterLineEditMode, OsExitLineEditMode
>  *
>  * PARAMETERS:  None
>  *
>  * RETURN:      None
>  *
>  * DESCRIPTION: Enter/Exit the raw character input mode for the terminal.
>  *
>  * Interactive line-editing support for the AML debugger. Used with the
>  * common/acgetline module.
>  *
>  * readline() is not used because of non-portability. It is not available
>  * on all systems, and if it is, often the package must be manually installed.
>  *
>  * Therefore, we use the POSIX tcgetattr/tcsetattr and do the minimal line
>  * editing that we need in AcpiOsGetLine.
>  *
>  * If the POSIX tcgetattr/tcsetattr interfaces are unavailable, these
>  * calls will also work:
>  *     For OsEnterLineEditMode: system ("stty cbreak -echo")
>  *     For OsExitLineEditMode:  system ("stty cooked echo")
>  *
>  *****************************************************************************/
>

acpiexec can't see into NVS though, I assume, which I imagine prevents
it from being very useful to debug my laptop, which seems to stick all
kinds of interesting things in NVS.

Anyway, could acpidbg do the same thing?

--Andy
