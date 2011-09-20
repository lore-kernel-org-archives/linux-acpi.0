From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 4/8] ACPI, APEI, Resolve false conflict between ACPI NVS
 and APEI
Date: Tue, 20 Sep 2011 10:26:49 -0600
Message-ID: <CAErSpo5pUY8g7U0NeUe+Yf+R8kraExZN3Sheo6h+fb9B+RO7rw@mail.gmail.com>
References: <1316482741-21799-1-git-send-email-ying.huang@intel.com>
 <1316482741-21799-5-git-send-email-ying.huang@intel.com> <CAErSpo4_syhxOi8jGo5oyrWBimsO7PdsXEky1vwPY_130OuPMA@mail.gmail.com>
 <4E77FBA4.3080907@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:45537 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750967Ab1ITQ1L convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 20 Sep 2011 12:27:11 -0400
Received: from wpaz5.hot.corp.google.com (wpaz5.hot.corp.google.com [172.24.198.69])
	by smtp-out.google.com with ESMTP id p8KGRASH016272
	for <linux-acpi@vger.kernel.org>; Tue, 20 Sep 2011 09:27:10 -0700
Received: from gxk4 (gxk4.prod.google.com [10.202.11.4])
	by wpaz5.hot.corp.google.com with ESMTP id p8KGQHHY019190
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Tue, 20 Sep 2011 09:27:09 -0700
Received: by gxk4 with SMTP id 4so1282034gxk.6
        for <linux-acpi@vger.kernel.org>; Tue, 20 Sep 2011 09:27:09 -0700 (PDT)
In-Reply-To: <4E77FBA4.3080907@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Huang Ying <ying.huang@intel.com>
Cc: Len Brown <lenb@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Luck, Tony" <tony.luck@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Yinghai Lu <yinghai@kernel.org>

On Mon, Sep 19, 2011 at 8:34 PM, Huang Ying <ying.huang@intel.com> wrot=
e:
> On 09/20/2011 10:09 AM, Bjorn Helgaas wrote:
>> On Mon, Sep 19, 2011 at 7:38 PM, Huang Ying <ying.huang@intel.com> w=
rote:
>>> Some firmware will access memory in ACPI NVS region via APEI. =A0Th=
at
>>> is, instructions in APEI ERST/EINJ table will read/write ACPI NVS
>>> region. =A0The original resource conflict checking in APEI code wil=
l
>>> check memory/ioport accessed by APEI via general resource managemen=
t
>>> mech. =A0But ACPI NVS region is marked as busy already, so that the
>>> false resource conflict will prevent APEI ERST/EINJ to work.
>>>
>>> To fix this, this patch excludes ACPI NVS regions when APEI compone=
nts
>>> request resources. =A0So that they will not conflict with ACPI NVS
>>> regions.
>>
>> I think this is much, much too complicated.
>>
>> Yinghai's three-line e820.c patch to leave ACPI NVS regions in the
>> iomem_resource tree, but as not busy, is far better.
>
> ACPI NVS should only be used by firmware or firmware interpreter inst=
ead
> of the ordinary drivers. =A0So I think that is reasonable to make it =
busy
> in iomem resource tree.

"My driver is not like ordinary drivers" is a common excuse for adding
special cases. I don't buy it.

These patches (3 and 4) add a lot of complexity but I don't believe
they add any real protection.

Regions are marked busy by their owners, i.e., by drivers that claim
devices and know how to operate them.  The e820 code is not an owner
of ACPI NVS regions, so it should not mark them busy.

I don't really think we have a problem here that needs to be solved.
Ordinary drivers have no way of learning an address in ACPI NVS, so
they aren't even going to try to use it.

Bjorn
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
