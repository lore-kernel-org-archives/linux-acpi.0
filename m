From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: [2/2] ACPI: report "Module Device" support via _OSI
Date: Thu, 20 Apr 2006 17:33:28 +0900
Message-ID: <44474758.6000208@jp.fujitsu.com>
References: <200604181558.55296.bjorn.helgaas@hp.com> <4445D9FB.100@jp.fujitsu.com> <200604191022.05016.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:6311 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750706AbWDTIf5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 20 Apr 2006 04:35:57 -0400
Received: from m3.gw.fujitsu.co.jp ([10.0.50.73])
        by fgwmail7.fujitsu.co.jp (Fujitsu Gateway)
        with ESMTP id k3K8Zqwx026392 for <linux-acpi@vger.kernel.org>; Thu, 20 Apr 2006 17:35:52 +0900
        (envelope-from kaneshige.kenji@jp.fujitsu.com)
Received: from s6.gw.fujitsu.co.jp by m3.gw.fujitsu.co.jp (8.12.10/Fujitsu Domain Master)
	id k3K8ZpYn029344 for <linux-acpi@vger.kernel.org>; Thu, 20 Apr 2006 17:35:51 +0900
	(envelope-from kaneshige.kenji@jp.fujitsu.com)
Received: from s6.gw.fujitsu.co.jp (s6 [127.0.0.1])
	by s6.gw.fujitsu.co.jp (Postfix) with ESMTP id C8D6F2A296E
	for <linux-acpi@vger.kernel.org>; Thu, 20 Apr 2006 17:35:50 +0900 (JST)
Received: from fjm506.ms.jp.fujitsu.com (fjm506.ms.jp.fujitsu.com [10.56.99.86])
	by s6.gw.fujitsu.co.jp (Postfix) with ESMTP id E27462A292D
	for <linux-acpi@vger.kernel.org>; Thu, 20 Apr 2006 17:35:49 +0900 (JST)
Received: from fjmscan503.ms.jp.fujitsu.com (fjmscan503.ms.jp.fujitsu.com [10.56.99.143])by fjm506.ms.jp.fujitsu.com with ESMTP id k3K8ZOxi019591
	for <linux-acpi@vger.kernel.org>; Thu, 20 Apr 2006 17:35:25 +0900
In-Reply-To: <200604191022.05016.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org, Andrew Morton <akpm@osdl.org>, "Moore, Robert" <robert.moore@intel.com>, Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>, Motoyuki Ito <motoyuki@soft.fujitsu.com>

Bjorn Helgaas wrote:
> On Wednesday 19 April 2006 00:34, Kenji Kaneshige wrote:
> 
>>I have a question. The ACPI container driver can be build as a
>>kernel module. Should _OSI("Module Device") returns TRUE even
>>when container driver module is not loaded? (Typically, _OSI is
>>evaluated at _INI time, I think. So container driver module is
>>not loaded at _OSI("Module Device") time anyway.)
> 
> 
> Good question.  I think _OSI("Module Device") should return
> true even if the container driver isn't loaded.
> 
> Do you think that's a bad idea?
> 
> I think it's OK if the namespace contains container devices
> that we ignore until the driver is loaded.  Someday, the
> presence of those devices should be enough to cause udev
> to load the driver automatically.  But for now, I think we
> have to do it manually.
>

I see. I think you are right.

But now, I'm wondering why ACPI firmware needs _OSI("Module
Device") because I think module devices in the namespace will
be ignored by the OS if it doesn't support "Module Device"...

Anyway, thank you for your answer.

Thanks,
Kenji Kaneshige

 
> 
>>Bjorn Helgaas wrote:
>>
>>>Update _OSI strings to report that "Module Device" is supported.
>>>
>>>This is Linux-specific, so it should be one of the Linux divergences
>>>from the Intel ACPI CA.
>>>
>>>Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
>>>
>>>Index: work-mm5/drivers/acpi/utilities/uteval.c
>>>===================================================================
>>>--- work-mm5.orig/drivers/acpi/utilities/uteval.c	2006-04-18 15:31:22.000000000 -0600
>>>+++ work-mm5/drivers/acpi/utilities/uteval.c	2006-04-18 15:32:38.000000000 -0600
>>>@@ -69,6 +69,9 @@
>>> 	/* Feature Group Strings */
>>> 
>>> 	"Extended Address Space Descriptor",
>>>+#ifdef CONFIG_ACPI_CONTAINER
>>>+	"Module Device",
>>>+#endif
>>> };
>>> 
>>> /* Local prototypes */
>>>-
>>>To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
>>>the body of a message to majordomo@vger.kernel.org
>>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>>-
>>To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> 
> 

