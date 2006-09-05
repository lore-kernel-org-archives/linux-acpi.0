From: Yu Luming <luming.yu@intel.com>
Subject: Re: Fw: PROBLEM: HP dv6000z Laptop ACPI/nVidia/bcm43xx issues
Date: Tue, 5 Sep 2006 13:50:34 +0800
Message-ID: <200609051350.35296.luming.yu@intel.com>
References: <20060902111324.102387ea.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:50795 "EHLO
	orsmga102-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S965163AbWIEFof (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 5 Sep 2006 01:44:35 -0400
In-Reply-To: <20060902111324.102387ea.akpm@osdl.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: M W <wumarkus@hotmail.com>
Cc: linux-acpi@vger.kernel.org, Andrew Morton <akpm@osdl.org>

On Sunday 03 September 2006 02:13, Andrew Morton wrote:
> Begin forwarded message:
>
>  Date: Sat, 2 Sep 2006 14:04:51 -0400
>  From: "M W" <wumarkus@hotmail.com>
>  To: <linux-kernel@vger.kernel.org>
>  Subject: PROBLEM: HP dv6000z Laptop ACPI/nVidia/bcm43xx issues
>

Please file a bug on bugziila.kernel.org in acpi Category.
>
>  Upon boot-up, I am seeing the following error message on both 2.16 and
> 2.17 kernels (32 or 64 bit):
Please try 2.6.18-rc6.

>
>  PCI: Failed to allocate mem resource #6:20000@e0000000 for 0000:05:00.0
Please cat /proc/iomem.

>
>  I am also unable to boot the system properly unless I boot with "acpi=off"
>  This may be related to my bcm43xx wireless card that I have been unable to
>  get working properly both with the native driver or ndiswrapper.
Please cat /proc/interrupts, and post acpidump output on bugzilla.


-- 
Thanks,
Luming
