From: Angelo Arrifano <miknix@gmail.com>
Subject: Re: *NEW* ACPI driver to support App Hot Startup AKA PNP0C32 - please
 apply
Date: Mon, 22 Jun 2009 18:03:23 +0100
Message-ID: <4A3FB95B.6030208@gmail.com>
References: <20071110014448.471e384b.miknix@gmail.com><200711100321.22500.carlos@strangeworlds.co.uk><20071112000534.e0489eca.miknix@gmail.com><200711120002.24474.carlos@strangeworlds.co.uk><20071123152446.144ac193.miknix@gmail.com><20080119151929.1674103b.miknix@gmail.com><823A93EED437D048963A3697DB0E35DE0129BE5A@pdsmsx414.ccr.corp.intel.com><20080307112505.7281ef4b.miknix@gmail.com><1205119416.10256.218.camel@acpi-hp-zz.sh.intel.com> <20080310123625.a3c96d0a.miknix@gmail.com> <823A93EED437D048963A3697DB0E35DE012DE3C1@pdsmsx414.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f210.google.com ([209.85.219.210]:46583 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755546AbZFVRDD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 22 Jun 2009 13:03:03 -0400
Received: by ewy6 with SMTP id 6so4861695ewy.37
        for <linux-acpi@vger.kernel.org>; Mon, 22 Jun 2009 10:03:05 -0700 (PDT)
In-Reply-To: <823A93EED437D048963A3697DB0E35DE012DE3C1@pdsmsx414.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: linux-acpi@vger.kernel.org

Zhang, Rui wrote:
> Hah, I nearly missed this email.
>=20
> Angelo,
> Can you please re-send the refreshed patch so that I can add the comm=
ents in-line?
> Better kick off a new thread with the title like "[PATCH] ACPI: ..."
>=20
> BTW: please don't send it as an attachment. :)
>=20
> Thanks
> rui
>=20
>> -----Original Message-----
>> From: =C2ngelo Miguel Arrifano [mailto:miknix@gmail.com]
>> Sent: Monday, March 10, 2008 8:36 PM
>> To: Zhang, Rui
>> Cc: linux-acpi
>> Subject: Re: *NEW* ACPI driver to support App Hot Startup AKA PNP0C3=
2 - please
>> apply
>>
>> On Mon, 10 Mar 2008 11:23:36 +0800
>> "Zhang, Rui" <rui.zhang@intel.com> wrote:
>>
>>> As there is nothing private, add linux-acpi in the discussion. :)
>> Ah, sorry. I was distracted.
>>> On Fri, 2008-03-07 at 19:25 +0800, =C2ngelo Miguel Arrifano wrote:
>>>> On Fri, 7 Mar 2008 14:27:13 +0800
>>>> "Zhang, Rui" <rui.zhang@intel.com> wrote:
>>>>
>>>>> Hi, Angelo,
>>>>>
>>>>> For a typical ACPI device driver, it usually works like this:
>>>>> 1. Register the ACPI device driver is the module_init
>>>>> 2. Enable the device, create the sys I/F in the drivers .add meth=
od.
>>>>> 3. Remove the device I/F in .remove method.
>>>>> 4. unregister the ACPI device driver in module_exit.
>>>>>
>>>>> With your patch applied, the sys I/F will be created even if no
>>>> PNP0C32 device exists in the ACPI namespace. IMO, moving this piec=
e of
>>>> code to the .add method will be much better.
>>>>
>>>> That's right, but the sys I/F being created are not in a per-devic=
e
>>>> basis. I mean:
>>>>
>>>> Suppose PNP0C32 has three devices:
>>>> ABTN
>>>> BBTN
>>>> CBTN
>>> You mean three devices with _HID(PNP0C32), or three devices enumera=
ted
>>> under a PNP0C32 device? could you please attach the acpidump output=
?
>> (...)
>>
>> Device (QBTN)
>> {
>>    Name (_HID, EisaId ("PNP0C32"))
>>    Name (_UID, 0x01)
>>    Method (_STA, 0, NotSerialized)
>>    {
>> 	If (LEqual (OSYS, 0x07D6))
>> 	{
>> 	    Return (0x0F)
>> 	}
>> 	Else
>> 	{
>> 	    Return (0x00)
>> 	}
>>    }
>>
>>    Method (GHID, 0, NotSerialized)
>>    {
>> 	If (LEqual (HOTB, 0x04))
>> 	{
>> 	    Notify (QBTN, 0x02)
>> 	    Store (0x00, HOTB)
>> 	}
>>
>> 	Return (Buffer (0x01)
>> 	{
>> 	    /* 0000 */    0x01
>> 	})
>>    }
>> }
>>
>>
>>
>> Device (DBTN)
>> {
>>    Name (_HID, EisaId ("PNP0C32"))
>>    Name (_UID, 0x02)
>>    Method (_STA, 0, NotSerialized)
>>    {
>> 	If (LEqual (OSYS, 0x07D6))
>> 	{
>> 	    Return (0x0F)
>> 	}
>> 	Else
>> 	{
>> 	    Return (0x00)
>> 	}
>>    }
>>
>>    Method (GHID, 0, NotSerialized)
>>    {
>> 	If (LEqual (HOTB, 0x05))
>> 	{
>> 	    Notify (DBTN, 0x02)
>> 	    Store (0x00, HOTB)
>> 	}
>>
>> 	Return (Buffer (0x01)
>> 	{
>> 	    /* 0000 */    0x02
>> 	})
>>    }
>> }
>>
>> (...)
>>
>> So the devices above are those whose I was referring as buttons.
>> The first one is the QuickPlay button the second DVD Button, etc..
>>
>>>> The sys files are created for PNP0C32 and not for every [ABC]BTN
>>>> device.
>>>>  So, moving the
>>>> sys I/F code into .add, AFAIK, will get the sys files created seve=
ral
>>>> times which is not
>>>> the purpose.
>>> .add method is called for each PNP0C32 device,not for each button.
>>> so in this case, I think it will only create two sys files...
>> Yeah, but PNP0C32 devices are the buttons.
>>
>>>> The sys files created are "buttons" and "pressed_button".
>>>> "buttons" displays all devices (buttons) under PNP0C32 for, IMHO,
>>>> easier enumeration by
>>>> userspace; instead of having a file for each device.
>>>> "pressed_buttons" displays the button used to turn on/resume the
>>>> computer.
>>>>
>>>> But you are still right, the driver loads successfully (although
>>>> displaying "none" on "buttons" sys file) when no PNP0C32 is presen=
t as
>>>> we can see on this user post which doesn't have PNP0C32 at all:
>>>> http://sourceforge.net/forum/forum.php?thread_id=3D1959640&forum_i=
d=3D754264
>>>>
>>>> On the code below, shouldn't (status < 0) be true when no PNP0C32 =
is
>>>> present?
>>>>
>>>>         /* ACPI driver register */
>>>>         status =3D acpi_bus_register_driver(&quickstart_acpi_drive=
r);
>>>>         if (status < 0)
>>>>                 return -ENODEV;
>>>>
>>>> This was supposed to exit with -ENODEV before creating sys I/F.
>>> No, acpi_bus_register_driver returns 0 if no matched device is foun=
d, in
>>> order to support device hotplug.
>> Hum.. Then this patch should prevent the module to load if no device=
s are present.
>>
>> --- quickstart/quickstart.c     2008-03-06 00:23:20.000000000 +0000
>> +++ quickstart-101/quickstart.c 2008-03-10 12:27:15.223132836 +0000
>> @@ -362,7 +362,7 @@ static int __init quickstart_init(void)
>>
>>        /* ACPI driver register */
>>        status =3D acpi_bus_register_driver(&quickstart_acpi_driver);
>> -       if (status < 0)
>> +       if (!quickstart_data.btn_lst || status < 0)
>>                return -ENODEV;
>>
>>        /* Platform driver register */
>>
>>> thanks,
>>> rui
>>>
>> Best regards,
>> --
>> Angelo Arrifano AKA MiKNiX
>> CSE Student at UBI, Portugal
>> Gentoo Linux AMD64 Arch Tester
>> Linwizard Developer
>> http://miknix.homelinux.com
>> PGP Pubkey 0x3D92BB0B

Hello all,

I've been maintaining this driver, the latest tested tag is 2.6.28.
However, I lost track of what is happening in the Linux ACPI tree. It
seems it is moving towards ACPICA?

Is there any interest on including this small piece of code in the tree=
?

Best regards,

- Angelo Arrifano
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
