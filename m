From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: acpi_power_meter IPMI region errors
Date: Thu, 30 Apr 2015 16:17:33 -0700
Message-ID: <CALCETrXJRmDsgiw+YQ3CXZ8Y030jVSL2NtJkv3-X1MR0akRyQw@mail.gmail.com>
References: <CALCETrXGnb=48PZEggM3Zj2XgcN-S=VFSnuQTb-KVGEA7aOwmQ@mail.gmail.com>
 <4487292.Nn4liAbynN@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lb0-f171.google.com ([209.85.217.171]:35731 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750831AbbD3XRz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 30 Apr 2015 19:17:55 -0400
Received: by lbbuc2 with SMTP id uc2so55778978lbb.2
        for <linux-acpi@vger.kernel.org>; Thu, 30 Apr 2015 16:17:54 -0700 (PDT)
In-Reply-To: <4487292.Nn4liAbynN@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Corey Minyard <cminyard@mvista.com>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, Lv Zheng <lv.zheng@intel.com>

On Thu, Apr 30, 2015 at 4:33 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Thursday, April 30, 2015 03:30:23 PM Andy Lutomirski wrote:
>> Hi-
>>
>> On a Dell server, I'm seeting:
>
> Hi,
>
>> [At 11.582715] [info] IPMI SSIF Interface driver
>> [At 11.583038] [warning] ACPI Error: No handler for Region [SYSI]
>> (ffff88041f89b1b0) [IPMI] (20141107/evregion-163)
>> [At 11.583043] [warning] ACPI Error: Region IPMI (ID=7) has no handler
>> (20141107/exfldio-299)
>> [At 11.583047] [warning] ACPI Error: Method parse/execution failed
>> [\x5c_SB_.PMI0._GHL] (Node ffff88041f89adc0), AE_NOT_EXIST
>> (20141107/psparse-536)
>> [At 11.583055] [warning] ACPI Error: Method parse/execution failed
>> [\x5c_SB_.PMI0._PMC] (Node ffff88041f89ad20), AE_NOT_EXIST
>> (20141107/psparse-536)
>> [At 11.583061] [warning] ACPI Exception: AE_NOT_EXIST, Evaluating _PMC
>> (20141107/power_meter-755)
>>
>> If I build ipmi_si and acpi_ipmi, it's a little better:
>>
>> [At 12.333895] [info] IPMI SSIF Interface driver
>> [At 12.367570] [warning] ACPI Exception: AE_NOT_EXIST, Returned by
>> Handler for [IPMI] (20141107/evregion-297)
>> [At 12.367575] [warning] ACPI Error: Region IPMI (ID=7) has no handler
>> (20141107/exfldio-299)
>> [At 12.367579] [warning] ACPI Error: Method parse/execution failed
>> [\x5c_SB_.PMI0._GHL] (Node ffff88041f89adc0), AE_NOT_EXIST
>> (20141107/psparse-536)
>> [At 12.367586] [warning] ACPI Error: Method parse/execution failed
>> [\x5c_SB_.PMI0._PMC] (Node ffff88041f89ad20), AE_NOT_EXIST
>> (20141107/psparse-536)
>> [At 12.367592] [warning] ACPI Exception: AE_NOT_EXIST, Evaluating _PMC
>> (20141107/power_meter-755)
>>
>> reloading acpi_power_meter causes the errors, but not the "IPMI SSIF"
>> message, to repeat.
>>
>> Is this a problem?  Why is it happening?
>
> It looks like a missing operation region handler, meaning that AML wants
> to send/receive things via IPMI but it can't do that.  That may be bad or
> good, depending.
>
> I'm not sure why it's missing (Lv is more familiar with the code in question).
>
>> My DSDT is here:
>>
>> https://bugzilla.kernel.org/attachment.cgi?id=175391
>
> What BZ entry is that?

https://bugzilla.kernel.org/show_bug.cgi?id=46741

I traced this a bit.  The acpi_ipmi failure happens because my ipmi_si
device is being probed through SMBIOS, not ACPI.  I do have
/sys/bus/acpi/devices/IPI0001:00, which has physical_node
/sys/devices/pnp0/00:05 and firmware node
/sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:15/IPI0001:00.

My DSDT has:

                Device (NIPM)
                {
                    Name (_HID, EisaId ("IPI0001"))  // _HID: Hardware ID
                    Name (_CID, EisaId ("PNP0C01"))  // _CID: Compatible ID
                    Name (_UID, 0x05)  // _UID: Unique ID

so I assume it should be probing via ACPI.  I haven't figured out why
it's probing via SMBIOS instead yet.

--Andy
