From: "Yu, Ke" <ke.yu@intel.com>
Subject: RE: [Xen-devel] [PATCH][pvops_dom0][2/4] Introduce the external
 control operation interface for domain0 ACPI parser
Date: Thu, 30 Jul 2009 16:59:20 +0800
Message-ID: <4D05DB80B95B23498C72C700BD6C2E0B315D6A4F@pdsmsx502.ccr.corp.intel.com>
References: <4D05DB80B95B23498C72C700BD6C2E0B315D64CC@pdsmsx502.ccr.corp.intel.com>
 <E87738D94A6AD54789B5B8D1BAEB06CC5C744C68C2@azsmsx503.amr.corp.intel.com>
 <4A707C46.2060405@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:15495 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751565AbZG3JBD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 30 Jul 2009 05:01:03 -0400
In-Reply-To: <4A707C46.2060405@goop.org>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>, "Brown, Len" <len.brown@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Tian, Kevin" <kevin.tian@intel.com>

>> s/extcntl/xen/ to make it clear why this code exists --
>> or is there an expected "external control" other than Xen?
>>
>
>I dislike making Xen-specific changes.  Ideally we can find a way to fit
>these changes into some other abstraction which already exists, or if
>added would be useful to more than one user.
>
>    J

The "external logic" is the way we trying to make it a generic abstraction, but right now I cannot told who would be the external entity except xen. Maybe in the future if other software want to leverage linux acpica, they would also use it.

If people has other idea on the abstraction, I would be happy to hear that.

BTW, Len, do you think the hook this patch adds to the acpi subsystem is OK, regardless its name being "xen" or "extcntl"?

Best Regards
Ke
