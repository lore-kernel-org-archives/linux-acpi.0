From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: APEI: Can not request iomem region for GARs
Date: Mon, 29 Aug 2011 08:48:28 -0600
Message-ID: <CAErSpo7=SZ1XKBY0dDUg-c+_d-GoZF7uNypQc3Ecm+iofkXTMA@mail.gmail.com>
References: <CAG1a4rs4Cr1z50gGuK9SLE6aOvibE1sdV_GSLPv+gqYC8g+ORQ@mail.gmail.com>
 <CAErSpo4FfBoGDUquoLNsJ9=z-M-x6NQgP8xJL_VqEXpsL2H5PA@mail.gmail.com>
 <4E520149.3010802@intel.com> <CAG1a4rtMnDXSGLkmwE+6N9smoghWp0W4b5-X_gogzJ9fDLTeBg@mail.gmail.com>
 <4E571D66.1070302@intel.com> <CAErSpo5L1X49hfeJ69o_hwfuzMT6R+7TKhGbYCkyqtqVpf4tEw@mail.gmail.com>
 <4E5AEAF4.3000800@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:19440 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753883Ab1H2Osw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 29 Aug 2011 10:48:52 -0400
Received: from wpaz29.hot.corp.google.com (wpaz29.hot.corp.google.com [172.24.198.93])
	by smtp-out.google.com with ESMTP id p7TEmovf001478
	for <linux-acpi@vger.kernel.org>; Mon, 29 Aug 2011 07:48:50 -0700
Received: from gwb1 (gwb1.prod.google.com [10.200.2.1])
	by wpaz29.hot.corp.google.com with ESMTP id p7TElYgd024059
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Mon, 29 Aug 2011 07:48:49 -0700
Received: by gwb1 with SMTP id 1so2231569gwb.8
        for <linux-acpi@vger.kernel.org>; Mon, 29 Aug 2011 07:48:49 -0700 (PDT)
In-Reply-To: <4E5AEAF4.3000800@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Huang Ying <ying.huang@intel.com>
Cc: Pavel Ivanov <paivanof@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>

On Sun, Aug 28, 2011 at 7:27 PM, Huang Ying <ying.huang@intel.com> wrot=
e:
> On 08/26/2011 09:43 PM, Bjorn Helgaas wrote:
>> On Thu, Aug 25, 2011 at 10:13 PM, Huang Ying <ying.huang@intel.com> =
wrote:
>>> Hi, Pavel,
>>>
>>> Sorry, =A0there is a minor issue in the patch. =A0Do you have time =
to try
>>> the updated version attached.
>>
>> I think Yinghai's patch is a better approach (though it needs a chan=
gelog).
>>
>> The ACPI NVS space should not be marked as "busy" by the e820 code i=
n
>> the iomem_resource tree.
>>
>> It's way too complicated to mess around with registering NVS space a=
nd
>> trying to deal with it specially in APEI.
>
> ACPI NVS is different, it can be used only by firmware, and its
> interpreter, such as ACPI AML interpreter and APEI interpreter. =A0It=
 can
> not be used by ordinary driver. =A0If my understanding is correct, th=
is is
> why ACPI NVS is marked as busy.

I don't understand why ACPI NVS is different.  If we reserve it in
iomem_resource (without marking it busy), it's already unavailable to
anything else unless you know something connected to the NVS region.

The only way to allocate space inside NVS is to first discover the
ACPI NVS resource, so you could pass it to request_resource() or
allocate_resource() as the "root" to allocate from.  There's no
mechanism for locating that resource, so it's already protected in
that sense.

To use request_mem_region() (which marks the region busy), you all you
need is an address.  The only way for a driver to learn an address
inside NVS is from the ACPI tables.  So I think it's effectively
limited to APEI there, too.

Bjorn
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
