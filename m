From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: AER/hotplug _OSC wierdness?
Date: Mon, 7 Dec 2009 20:57:47 -0600
Message-ID: <51f3faa70912071857k2635f4b2h480b8459f1bffd2f@mail.gmail.com>
References: <4B1C7CC5.5070709@gmail.com> <4B1CDF16.8050201@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-iw0-f197.google.com ([209.85.223.197]:36256 "EHLO
	mail-iw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965444AbZLHC5l convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Dec 2009 21:57:41 -0500
Received: by iwn35 with SMTP id 35so3572049iwn.4
        for <linux-acpi@vger.kernel.org>; Mon, 07 Dec 2009 18:57:47 -0800 (PST)
In-Reply-To: <4B1CDF16.8050201@jp.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: linux-acpi@vger.kernel.org

On Mon, Dec 7, 2009 at 4:55 AM, Kenji Kaneshige
<kaneshige.kenji@jp.fujitsu.com> wrote:
> Robert Hancock wrote:
>>
>> I've been looking into why I get these messages on bootup on an Asus
>> P7P55D PRO motherboard:
>>
>> Firmware did not grant requested _OSC control
>> aer 0000:00:03.0:pcie02: AER service couldn't init device: no _OSC s=
upport
>> pci_hotplug: PCI Hot Plug PCI Core version: 0.5
>> Firmware did not grant requested _OSC control
>> Firmware did not grant requested _OSC control
>> Firmware did not grant requested _OSC control
>> Firmware did not grant requested _OSC control
>>
>> The AML code for _OSC in the DSDT (below) is almost identical to the
>> example code in the ACPI spec. From looking at the _OSC method, I do=
n't see
>> why it should reject any requests for PCI Express hotplug or AER con=
trol.
>>
>> I can't quite make sense of the ACPI code that is supposed to handle=
 this.
>> When the AER driver calls acpi_pci_osc_control_set, it first does th=
is:
>>
>> =A0 =A0/* Need to query controls first before requesting them */
>> =A0 =A0if (!root->osc_queried) {
>> =A0 =A0 =A0 =A0status =3D acpi_pci_query_osc(root, root->osc_support=
_set);
>> =A0 =A0 =A0 =A0if (ACPI_FAILURE(status))
>> =A0 =A0 =A0 =A0 =A0 =A0goto out;
>> =A0 =A0}
>> =A0 =A0if ((root->osc_control_qry & control_req) !=3D control_req) {
>> =A0 =A0 =A0 =A0printk(KERN_DEBUG
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Firmware did not grant requested _OSC c=
ontrol\n");
>> =A0 =A0 =A0 =A0status =3D AE_SUPPORT;
>> =A0 =A0 =A0 =A0goto out;
>> =A0 =A0}
>>
>> Inside acpi_pci_query_osc:
>>
>> =A0 =A0/* do _OSC query for all possible controls */
>> =A0 =A0support_set =3D root->osc_support_set | (flags & OSC_SUPPORT_=
MASKS);
>> =A0 =A0capbuf[OSC_QUERY_TYPE] =3D OSC_QUERY_ENABLE;
>> =A0 =A0capbuf[OSC_SUPPORT_TYPE] =3D support_set;
>> =A0 =A0capbuf[OSC_CONTROL_TYPE] =3D OSC_CONTROL_MASKS;
>>
>> =A0 =A0status =3D acpi_pci_run_osc(root->device->handle, capbuf, &re=
sult);
>> =A0 =A0if (ACPI_SUCCESS(status)) {
>> =A0 =A0 =A0 =A0root->osc_support_set =3D support_set;
>> =A0 =A0 =A0 =A0root->osc_control_qry =3D result;
>> =A0 =A0 =A0 =A0root->osc_queried =3D 1;
>> =A0 =A0}
>>
>> The comment says "do _OSC query for all possible controls", but it d=
oesn't
>> look like that's what the code is actually doing. The first time thi=
s gets
>> called, assuming osc_support_set is 0, it looks like support_set pas=
sed into
>> _OSC will also be 0. Then osc_queried would be set to 1, _OSC would =
never
>> get called again and the cached query result is based on 0 support f=
lags
>> being passed into _OSC, which is wrong. Or am I missing something?
>>
>> =A0 =A0Name (PEHP, One)
>> =A0 =A0Name (SHPC, Zero)
>> =A0 =A0Name (PEPM, One)
>> =A0 =A0Name (PEER, One)
>> =A0 =A0Name (PECS, One)
>>
>> ...
>>
>> =A0 =A0 =A0 =A0Method (_OSC, 4, NotSerialized)
>> =A0 =A0 =A0 =A0{
>> =A0 =A0 =A0 =A0 =A0 =A0Name (SUPP, Zero)
>> =A0 =A0 =A0 =A0 =A0 =A0Name (CTRL, Zero)
>> =A0 =A0 =A0 =A0 =A0 =A0CreateDWordField (Arg3, Zero, CDW1)
>> =A0 =A0 =A0 =A0 =A0 =A0CreateDWordField (Arg3, 0x04, CDW2)
>> =A0 =A0 =A0 =A0 =A0 =A0CreateDWordField (Arg3, 0x08, CDW3)
>> =A0 =A0 =A0 =A0 =A0 =A0If (LEqual (Arg0, Buffer (0x10)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0{
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* 0000 */ =A0 =A00x5=
B, 0x4D, 0xDB, 0x33, 0xF7, 0x1F,
>> 0x1C, 0x40,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* 0008 */ =A0 =A00x9=
6, 0x57, 0x74, 0x41, 0xC0, 0x3D,
>> 0xD7, 0x66
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}))
>> =A0 =A0 =A0 =A0 =A0 =A0{
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Store (CDW2, SUPP)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Store (CDW3, CTRL)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0If (LNotEqual (And (SUPP, 0x16), 0x16=
))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0{
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0And (CTRL, 0x1E, CTRL)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0If (LNot (PEHP))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0{
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0And (CTRL, 0x1E, CTRL)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0If (LNot (SHPC))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0{
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0And (CTRL, 0x1D, CTRL)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0If (LNot (PEPM))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0{
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0And (CTRL, 0x1B, CTRL)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0If (LNot (PEER))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0{
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0And (CTRL, 0x15, CTRL)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0If (LNot (PECS))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0{
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0And (CTRL, 0x0F, CTRL)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0If (Not (And (CDW1, One)))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0{
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0If (And (CTRL, One)) {}
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0If (And (CTRL, 0x04)) {}
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0If (And (CTRL, 0x10)) {}
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0If (LNotEqual (Arg1, One))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0{
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Or (CDW1, 0x08, CDW1)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0If (LNotEqual (CDW3, CTRL))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0{
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Or (CDW1, 0x10, CDW1)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0And (CTRL, 0xEF, CTRL)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Store (CTRL, CDW3)
>
> Your ACPI DSDT seems to clear "PCI Express Capability Structure
> control" bit in returned value. Both AER and hotplug driver
> requests this control. I think this is the reason why you
> encountered "Firmware did not grant requested _OSC control".
>
> Please double check.

You're right here as well, I missed which bit that And statement was cl=
earing.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
