From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 16/16] platform/x86: dell-wmi: Convert to the WMI bus infrastructure
Date: Sat, 27 May 2017 09:17:21 -0700
Message-ID: <3669DF37-7D17-40AD-852A-F8EDBE15A785@gmail.com>
References: <cover.1495862272.git.dvhart@infradead.org> <4a4da770c8d0af7e3f31e79261b43573d70a6ea6.1495862272.git.dvhart@infradead.org> <201705271250.20338@pali> <CALCETrWic6ZWrjdmXTRX92U058B1SZ+xMd+5TBW+YL51ZrgeCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <CALCETrWic6ZWrjdmXTRX92U058B1SZ+xMd+5TBW+YL51ZrgeCA@mail.gmail.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Andy Lutomirski <luto@kernel.org>, =?ISO-8859-1?Q?Pali_Roh=E1r?= <pali.rohar@gmail.com>, Jiri Kosina <jikos@kernel.org>
Cc: Darren Hart <dvhart@infradead.org>, platform-driver-x86@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mario Limonciello <mario_limonciello@dell.com>, Rafael Wysocki <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On May 27, 2017 9:04:38 AM PDT, Andy Lutomirski <luto@kernel=2Eorg> wrote:
>On Sat, May 27, 2017 at 3:50 AM, Pali Roh=C3=A1r <pali=2Erohar@gmail=2Eco=
m>
>wrote:
>> On Saturday 27 May 2017 07:31:30 Darren Hart wrote:
>>> -     dell_wmi_input_dev->name =3D "Dell WMI hotkeys";
>>> -     dell_wmi_input_dev->phys =3D "wmi/input0";
>>> -     dell_wmi_input_dev->id=2Ebustype =3D BUS_HOST;
>>> +     priv->input_dev->name =3D "Dell WMI hotkeys";
>>> +     priv->input_dev->id=2Ebustype =3D BUS_HOST;
>>
>> Is not there BUS_WMI, or something like that? (Just asking)
>>
>
>Jiri and/or Dmitry, what is bustype for, anyway?=20

The bus type could be used to help further  identifying device if it used =
same vendor/product for spi and i2c, for example, but there are not many if=
 them=2E I'm not sure if anyone actually makes decisions based on it, but i=
t is part of abi now=2E

>I suppose we could add BUS_PLATFORM=2E

What would be the difference from BUS_HOST?


Thanks=2E

--=20
Dmitry
