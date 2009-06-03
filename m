From: Justin Mattock <justinmattock@gmail.com>
Subject: Re: ACPI Exception (evregion-0422): AE_ERROR, Returned by Handler for
	[PCI_Config] [20090320]
Date: Tue, 2 Jun 2009 19:11:41 -0700
Message-ID: <dd18b0c30906021911u4c2359daje01b0477a6bd23ff@mail.gmail.com>
References: <dd18b0c30906021102h43b8ecc4u9e67687de129bca1@mail.gmail.com>
	 <1243992286.9076.5.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.29]:55957 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752228AbZFCCLk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Jun 2009 22:11:40 -0400
In-Reply-To: <1243992286.9076.5.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Tue, Jun 2, 2009 at 6:24 PM, Zhang Rui <rui.zhang@intel.com> wrote:
> On Wed, 2009-06-03 at 02:02 +0800, Justin Mattock wrote:
>> I posted this error a few weeks ago, but had no response.
>> So after a few weeks of looking at this, I wanted to find out if
>> this is safe to see this, or should I be concerned:
>>
>> [ =A0 =A05.868418] ACPI: Power Button [PWRB]
>> [ =A0 =A05.868547] input: Sleep Button as
>> /devices/LNXSYSTM:00/device:00/PNP0C0E:00/input/input4
>> [ =A0 =A05.868621] ACPI: Sleep Button [SLPB]
>> [ =A0 =A06.093547] ACPI Exception (evregion-0422): AE_ERROR, Returne=
d by
>> Handler for [PCI_Config] [20090320]
>> [ =A0 =A06.093555] ACPI Error (psparse-0537): Method parse/execution
>> failed [\_SB_.PCI0.RP01.GFX0._PS0] (Node f703dcc0), AE_ERROR
>> [ =A0 =A06.093614] ACPI: Transitioning device [GFX0] to D0
>>
>> I did do a dsdt dump, and looked for any errors
>> but none had shown up.
>> kernels that I have seen this are 2.6.29 -
>> 2.6.30-rc5
>>
> please file a new bug report at
> http://bugzilla.kernel.org/enter_bug.cgi?product=3DACPI
> and attach the full dmesg output and acpidump there.
>
> thanks,
> rui
>
>

alright(Ill have to do that when I get a chance)
As for the error message after looking into it more today
I notice this message fired off as soon as I compiled
and loaded the nvidia module.


--=20
Justin P. Mattock
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
