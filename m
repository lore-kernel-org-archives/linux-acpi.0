From: Len Brown <len.brown@intel.com>
Subject: Re: [patch 10/10] Fix incorrect handling PCI-Express Root Bridge _HID
Date: Tue, 26 Sep 2006 03:15:18 -0400
Message-ID: <200609260315.19186.len.brown@intel.com>
References: <200609252328.k8PNSGca002194@shell0.pdx.osdl.net> <XNM1$9$0$4$$3$3$7$A$9002679U4518af61@hitachi.com>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:22948 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1751727AbWIZHNY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 26 Sep 2006 03:13:24 -0400
In-Reply-To: <XNM1$9$0$4$$3$3$7$A$9002679U4518af61@hitachi.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: eiichiro.oiwa.nm@hitachi.com
Cc: akpm@osdl.org, linux-acpi@vger.kernel.org

On Tuesday 26 September 2006 00:41, eiichiro.oiwa.nm@hitachi.com wrote:
> Hi Andrew,
> 
> We need this patch for APCI hotplug because APCI parser gets bus number from acpi_object_extra. I already tested this patch by ACPI hotplug, and confirmed there is no problem on our box has described PCI topology.
> I don't have git rights.
> Could you merge this patch into Linus's tree?

Eiichiro,
Thank you for finding and fixing this bug.
This patch is checked into the upstream ACPICA source tree.
While I don't expect to pull that whole tree into 2.6.18,
I do plan to cherry pick this patch with some others for 2.6.19,
as well as 2.6.18.stable.

thanks,
-Len
