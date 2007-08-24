From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: ACPI patches for Linux-2.6.23-rc3
Date: Fri, 24 Aug 2007 16:07:13 +0800
Message-ID: <1187942833.3159.2.camel@acpi-hp.sh.intel.com>
References: <11879400723077-git-send-email-len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:37290 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750815AbXHXIDF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Aug 2007 04:03:05 -0400
In-Reply-To: <11879400723077-git-send-email-len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org

On Fri, 2007-08-24 at 03:20 -0400, Len Brown wrote:
> please speak up if you see any problem with these patches.
> Also, please let me know if I've missed something you
> think needs to make 2.6.23.
> 
What about the latest patch in bug 8798?
It can fix the duplicate name problem without changing the
procfs generic code.

Thanks,
Rui
