From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH 15/16] platform/x86: wmi-mof: New driver to expose
 embedded WMI MOF metadata
Date: Mon, 5 Jun 2017 15:39:44 -0700
Message-ID: <CALCETrXTejMgbQZaHOKuEM_rF4bMduEzwWZ6+7R2M+gbFo5LMg@mail.gmail.com>
References: <cover.1495862272.git.dvhart@infradead.org> <201705271314.16241@pali>
 <20170605221456.GA27270@fury> <201706060019.26462@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vk0-f43.google.com ([209.85.213.43]:35986 "EHLO
        mail-vk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751180AbdFEWkG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Jun 2017 18:40:06 -0400
Received: by mail-vk0-f43.google.com with SMTP id p85so73762677vkd.3
        for <linux-acpi@vger.kernel.org>; Mon, 05 Jun 2017 15:40:05 -0700 (PDT)
In-Reply-To: <201706060019.26462@pali>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc: Darren Hart <dvhart@infradead.org>, platform-driver-x86@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Mario Limonciello <mario_limonciello@dell.com>, Rafael Wysocki <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>

On Mon, Jun 5, 2017 at 3:19 PM, Pali Roh=C3=A1r <pali.rohar@gmail.com> wrot=
e:
> On Tuesday 06 June 2017 00:14:56 Darren Hart wrote:
>> On Sat, May 27, 2017 at 01:14:15PM +0200, Pali Roh=C3=A1r wrote:
>> > > metadata. I think that Samba has tools to interpret it, but there
>> > > is currently no interface to get the data in the first place.
>> >
>> > No, there is no non-ms-windows tool for interpreting those binary
>> > MOF (BMF) data yet.
>>
>> Good point. Updated.
>
> You are too late :-) Now there is my at https://github.com/pali/bmfdec
> See my email "Binary MOF buffer in WMI is finally decoded!".
>

It comes out like this on my laptop.  I don't know enough about MOF to
know what we're supposed to do with this, but I suspect it at least
gives us the sizes of buffers that we should be passing to the various
methods.

class WMIEvent : __ExtrinsicEvent {
};

[WMI, Locale("MS\0x409"), Description("QDATA"),
guid("{ABBC0F60-8EA1-11d1-00A0-C90629100000}")]
class QDat {
  [WmiDataId(1), read, write, Description("qdata")] uint8 Bytes[128];
};

[WMI, Dynamic, Provider("WmiProv"), Locale("MS\0x409"),
Description("BIOS WMI Query"),
guid("{8D9DDCBC-A997-11DA-B012-B622A1EF5492}")]
class WMI_Query {
  [key, read] String InstanceName;
  [read] Boolean Active;
  [WmiDataId(1), read, write, Description("BIOS WMI info")] QDat QDATA;
};

[WMI, Locale("MS\0x409"), Description("Data"),
guid("{a3776ce0-1e88-11db-a98b-0800200c9a66}")]
class BDat {
  [WmiDataId(1), read, write, Description("data")] uint8 Bytes[4096];
};

[WMI, Dynamic, Provider("WmiProv"), Locale("MS\0x409"),
Description("Interface"),
guid("{A80593CE-A997-11DA-B012-B622A1EF5492}")]
class BFn {
  [key, read] String InstanceName;
  [read] Boolean Active;

  [WmiMethodId(1), Implemented, read, write, Description("Do BFn")]
void DoBFn([in, Description("Fn buf"), ID(0)] BDat Data, [out,
Description("Fn buf"), ID(0)] BDat Data);
};

[WMI, Dynamic, Provider("WmiProv"), Locale("MS\0x409"),
Description("Event"), guid("{9DBB5994-A997-11DA-B012-B622A1EF5492}")]
class BIOSEvent : WmiEvent {
  [key, read] String InstanceName;
  [read] Boolean Active;
  [WmiDataId(1), read, write, Description("Ev buf")] QDat Data;
};
