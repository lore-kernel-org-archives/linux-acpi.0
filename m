From: Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH 4/8] ACPI, APEI, Resolve false conflict between ACPI NVS
 and APEI
Date: Tue, 20 Sep 2011 10:34:12 +0800
Message-ID: <4E77FBA4.3080907@intel.com>
References: <1316482741-21799-1-git-send-email-ying.huang@intel.com> <1316482741-21799-5-git-send-email-ying.huang@intel.com> <CAErSpo4_syhxOi8jGo5oyrWBimsO7PdsXEky1vwPY_130OuPMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:28866 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752190Ab1ITCeO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 19 Sep 2011 22:34:14 -0400
In-Reply-To: <CAErSpo4_syhxOi8jGo5oyrWBimsO7PdsXEky1vwPY_130OuPMA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Len Brown <lenb@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Luck, Tony" <tony.luck@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Yinghai Lu <yinghai@kernel.org>

On 09/20/2011 10:09 AM, Bjorn Helgaas wrote:
> On Mon, Sep 19, 2011 at 7:38 PM, Huang Ying <ying.huang@intel.com> wrote:
>> Some firmware will access memory in ACPI NVS region via APEI.  That
>> is, instructions in APEI ERST/EINJ table will read/write ACPI NVS
>> region.  The original resource conflict checking in APEI code will
>> check memory/ioport accessed by APEI via general resource management
>> mech.  But ACPI NVS region is marked as busy already, so that the
>> false resource conflict will prevent APEI ERST/EINJ to work.
>>
>> To fix this, this patch excludes ACPI NVS regions when APEI components
>> request resources.  So that they will not conflict with ACPI NVS
>> regions.
> 
> I think this is much, much too complicated.
> 
> Yinghai's three-line e820.c patch to leave ACPI NVS regions in the
> iomem_resource tree, but as not busy, is far better.

ACPI NVS should only be used by firmware or firmware interpreter instead
of the ordinary drivers.  So I think that is reasonable to make it busy
in iomem resource tree.

Best Regards,
Huang Ying
