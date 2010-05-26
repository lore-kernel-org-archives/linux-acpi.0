From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH] ACPICA: Handle large field apertures.
Date: Wed, 26 May 2010 10:51:37 -0700
Message-ID: <4911F71203A09E4D9981D27F9D83085870A58F11@orsmsx503.amr.corp.intel.com>
References: <4911F71203A09E4D9981D27F9D830858709F2D04@orsmsx503.amr.corp.intel.com>
	 <20100525105910.2629.76253.stgit@thinkpad>
	 <1274841567.28455.16.camel@minggr.sh.intel.com>
	 <1274842158.28455.18.camel@minggr.sh.intel.com>  <4BFCCE01.1070100@suse.de>
 <1274859099.3429.25.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:9799 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753830Ab0EZRvk convert rfc822-to-8bit (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Wed, 26 May 2010 13:51:40 -0400
In-Reply-To: <1274859099.3429.25.camel@minggr.sh.intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Lin, Ming M" <ming.m.lin@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Len Brown <lenb@kernel.org>, "Linux-acpi@vger.kernel.org" <Linux-acpi@vger.kernel.org>

Shouldn't this be:

if (AccessByteWidth < 256)
{
    ObjDesc->CommonField.AccessByteWidth =3D (UINT8) AccessByteWidth;
}


>-----Original Message-----
>From: Lin, Ming M
>Sent: Wednesday, May 26, 2010 12:32 AM
>To: Alexey Starikovskiy
>Cc: Moore, Robert; Len Brown; Linux-acpi@vger.kernel.org
>Subject: Re: [PATCH] ACPICA: Handle large field apertures.
>
>On Wed, 2010-05-26 at 15:30 +0800, Alexey Starikovskiy wrote:
>> Hi Ming,
>>
>> 26.05.2010 06:49, Lin Ming =D0=C9=DB=C5=D4:
>> > Better to test AccessByteWidth as below,
>> Why not just 'if (AccessByteWidth > 255)' ?
>
>OK, that's more clear.
>
>> >
>> > +                if (!(AccessByteWidth & ~0xFF)) {
>> >
>>

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
