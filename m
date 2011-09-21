From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 4/8] ACPI, APEI, Resolve false conflict between ACPI NVS
 and APEI
Date: Tue, 20 Sep 2011 22:23:29 -0600
Message-ID: <CAErSpo6-5P0Be1jA6rpu_OYbBkJRsCoAxSjyZ5bygYyDikKQ5g@mail.gmail.com>
References: <1316482741-21799-1-git-send-email-ying.huang@intel.com>
 <1316482741-21799-5-git-send-email-ying.huang@intel.com> <CAErSpo4_syhxOi8jGo5oyrWBimsO7PdsXEky1vwPY_130OuPMA@mail.gmail.com>
 <4E77FBA4.3080907@intel.com> <CAErSpo5pUY8g7U0NeUe+Yf+R8kraExZN3Sheo6h+fb9B+RO7rw@mail.gmail.com>
 <4E794154.6000605@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:33950 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751083Ab1IUEXx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 21 Sep 2011 00:23:53 -0400
Received: from hpaq14.eem.corp.google.com (hpaq14.eem.corp.google.com [172.25.149.14])
	by smtp-out.google.com with ESMTP id p8L4NqrB028093
	for <linux-acpi@vger.kernel.org>; Tue, 20 Sep 2011 21:23:52 -0700
Received: from gyg8 (gyg8.prod.google.com [10.243.50.136])
	by hpaq14.eem.corp.google.com with ESMTP id p8L4NnPQ032493
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Tue, 20 Sep 2011 21:23:50 -0700
Received: by gyg8 with SMTP id 8so1966322gyg.6
        for <linux-acpi@vger.kernel.org>; Tue, 20 Sep 2011 21:23:49 -0700 (PDT)
In-Reply-To: <4E794154.6000605@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Huang Ying <ying.huang@intel.com>
Cc: Len Brown <lenb@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Luck, Tony" <tony.luck@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Yinghai Lu <yinghai@kernel.org>

On Tue, Sep 20, 2011 at 7:43 PM, Huang Ying <ying.huang@intel.com> wrot=
e:
> On 09/21/2011 12:26 AM, Bjorn Helgaas wrote:
>> On Mon, Sep 19, 2011 at 8:34 PM, Huang Ying <ying.huang@intel.com> w=
rote:
>>> On 09/20/2011 10:09 AM, Bjorn Helgaas wrote:
>>>> On Mon, Sep 19, 2011 at 7:38 PM, Huang Ying <ying.huang@intel.com>=
 wrote:
>>>>> Some firmware will access memory in ACPI NVS region via APEI. =A0=
That
>>>>> is, instructions in APEI ERST/EINJ table will read/write ACPI NVS
>>>>> region. =A0The original resource conflict checking in APEI code w=
ill
>>>>> check memory/ioport accessed by APEI via general resource managem=
ent
>>>>> mech. =A0But ACPI NVS region is marked as busy already, so that t=
he
>>>>> false resource conflict will prevent APEI ERST/EINJ to work.
>>>>>
>>>>> To fix this, this patch excludes ACPI NVS regions when APEI compo=
nents
>>>>> request resources. =A0So that they will not conflict with ACPI NV=
S
>>>>> regions.
>>>>
>>>> I think this is much, much too complicated.
>>>>
>>>> Yinghai's three-line e820.c patch to leave ACPI NVS regions in the
>>>> iomem_resource tree, but as not busy, is far better.
>>>
>>> ACPI NVS should only be used by firmware or firmware interpreter in=
stead
>>> of the ordinary drivers. =A0So I think that is reasonable to make i=
t busy
>>> in iomem resource tree.
>>
>> "My driver is not like ordinary drivers" is a common excuse for addi=
ng
>> special cases. I don't buy it.
>>
>> These patches (3 and 4) add a lot of complexity but I don't believe
>> they add any real protection.
>>
>> Regions are marked busy by their owners, i.e., by drivers that claim
>> devices and know how to operate them. =A0The e820 code is not an own=
er
>> of ACPI NVS regions, so it should not mark them busy.
>>
>> I don't really think we have a problem here that needs to be solved.
>> Ordinary drivers have no way of learning an address in ACPI NVS, so
>> they aren't even going to try to use it.
>
> So what resource conflict checking is for? =A0If something wrong with
> driver configuration, resource description in ACPI table etc, the dri=
ver
> may request iomem inside ACPI NVS regions.
>
> ACPI NVS regions already have a user, that is the ACPI AML interprete=
r,
> so it is always busy.

If the AML interpreter is the user, *it* should mark the regions busy, =
not e820.

Bjorn
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
