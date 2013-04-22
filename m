From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [PATCH] ACPI: Disable Windows 8 compatibility for some Lenovo
 ThinkPads
Date: Mon, 22 Apr 2013 18:08:17 +0800
Message-ID: <51750C11.7060600@intel.com>
References: <1360599681-24781-1-git-send-email-seth.forshee@canonical.com>  <5158E8A0.3050904@intel.com> <20130401130340.GA3269@thinkpad-t410>  <515AA007.1050305@intel.com> <20130402130000.GA12381@thinkpad-t410>  <515BD48B.7000901@bjencks.net>  <5170B6ED.2040408@intel.com> <1366597102.23707.92.camel@linux-s257.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:41329 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753070Ab3DVKGv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 22 Apr 2013 06:06:51 -0400
In-Reply-To: <1366597102.23707.92.camel@linux-s257.site>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: joeyli <jlee@suse.com>
Cc: Ben Jencks <ben@bjencks.net>, Seth Forshee <seth.forshee@canonical.com>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>

On 04/22/2013 10:18 AM, joeyli wrote:
> =E6=96=BC =E4=BA=94=EF=BC=8C2013-04-19 =E6=96=BC 11:15 +0800=EF=BC=8C=
Aaron Lu =E6=8F=90=E5=88=B0=EF=BC=9A
>> On 04/03/2013 03:04 PM, Ben Jencks wrote:
>>> On 04/02/2013 09:00 AM, Seth Forshee wrote:
>>>> On Tue, Apr 02, 2013 at 05:08:23PM +0800, Aaron Lu wrote:
>>>>>
>>>>> I really wondered, how Windows handled this, it should have the s=
ame
>>>>> problem, unless they are not using the acpi video interface?
>>>>
>>>> I can only guess.
>>>>
>>>> I think I remember reading that Windows 8 does smooth backlight
>>>> transitions, so it may well hit every intermediate brightness valu=
e.
>>>> Lenovo could also be supplying a driver which rounds values to the
>>>> nearest working value or uses some other interface or something el=
se.
>>>
>>> Just checked; Windows 8 doesn't use the ACPI interface. It seems to=
 have
>>> access to at least 100 distinct brightness levels.
>>
>> I just came across a document on win8 backlight control, it has word=
s
>> like this:
>> "
>> In Windows 8, the primary mechanism by which a platform should expos=
e
>> its display brightness control functionality is the Windows Display
>> Driver Model (WDDM) miniport Device Driver Interfaces (DDI).
>> "
>> So looks like, on win8, ACPI interface is not used for these systems=
=2E
>>
>> The link for the document is here:
>> http://msdn.microsoft.com/en-US/library/windows/hardware/jj159305
>>
>> -Aaron
>>
>=20
> Per WDDM document, OEM/ODM should keep the ACPI methods (_BQL, _BCM,
> _BQC) available for compliant to the OS that doesn't support WDDM, e.=
g.
> XP, Vista.

Thanks for the information, so this suggests that acpi interface is
mostly used for pre-win8 OSes?(does win7 support WDDM?)

One interesting thing is, if they do not support acpi interface, why
they even bother to expose this interface in acpi table?

-Aaron
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
