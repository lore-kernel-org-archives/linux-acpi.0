From: Al Stone <al.stone@linaro.org>
Subject: Re: [PATCH v2 4/6] ACPI: ARM: exclude DMI calls
Date: Mon, 25 Nov 2013 11:01:08 -0700
Message-ID: <52939064.6090803@linaro.org>
References: <1385080915-23430-1-git-send-email-al.stone@linaro.org> <528F9C65.7010302@linaro.org> <CAOesGMgFBRjO++JSP0ddKKQ2RfG8V4fb97Hd+Oqwixi_Tt7Qwg@mail.gmail.com> <4285284.l8TssFvumi@vostro.rjw.lan> <528FF15C.4060300@linaro.org> <20131123163854.GA1817@srcf.ucam.org> <1AE640813FDE7649BE1B193DEA596E880248D1A8@SHSMSX101.ccr.corp.intel.com> <20131125153016.GA3243@srcf.ucam.org> <52938C3F.20905@linaro.org> <20131125174552.GA7417@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:57485 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754949Ab3KYSBK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Nov 2013 13:01:10 -0500
Received: by mail-ie0-f181.google.com with SMTP id e14so7344374iej.40
        for <linux-acpi@vger.kernel.org>; Mon, 25 Nov 2013 10:01:09 -0800 (PST)
In-Reply-To: <20131125174552.GA7417@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: "Zheng, Lv" <lv.zheng@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Olof Johansson <olof@lixom.net>, Rob Herring <robherring2@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Linaro Patches <patches@linaro.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>

On 11/25/2013 10:45 AM, Matthew Garrett wrote:
> On Mon, Nov 25, 2013 at 10:43:27AM -0700, Al Stone wrote:
>> On 11/25/2013 08:30 AM, Matthew Garrett wrote:
>>> Is ACPI_REDUCED_HARDWARE supposed to indicate support for the reduced
>>> hardware profile, or that the platform *only* implements the reduced
>>> hardware profile?
>>
>>  From what I can see in ACPICA, ACPI_REDUCED_HARDWARE indicates the
>> platform *only* implements the reduced hardware profile.  This *seems*
>> to be consistent with the specification -- see 3.11.1, second bullet,
>> for example:
>
> Ok, so a kernel built without ACPI_REDUCED_HARDWARE would still support
> the reduced hardware profile?

Let me check on that.  The reduced hardware profile is a pretty
strict subset, and I think I can see a way where I could force
selecting the reduced HW profile on boot if the kernel has been
built *without* ACPI_REDUCED_HARDWARE.  What I am not convinced
of is that all of the proper guards are in place in ACPICA -- I
trust that they have been, but I would like to double check.

If I can get that to work properly, I'll add it to this patch set.

>> ...if by "not supported" one takes that to mean "does not exist when
>> compiled."  I can look at the ACPICA code again, just the same; perhaps
>> there is some reasonable way to at least select one or the other at boot
>> as the first step, and then allow switching between modes as a later
>> step.
>
> I don't think you'd ever want to switch after init time. There's a flag
> in the FADT that indicates whether a system is implementing the reduced
> hardware profile or not.
>

Agreed.  I could see it as something to use when experimenting perhaps,
but I think just allowing the switch at boot would cover the majority
of the use cases.

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Linaro Enterprise Group
al.stone@linaro.org
-----------------------------------
