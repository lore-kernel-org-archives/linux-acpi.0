From: Frans Pop <elendil@planet.nl>
Subject: Re: Syntax errors in SSDT1 table of HP 2510p laptop
Date: Fri, 26 Sep 2008 06:52:20 +0200
Message-ID: <200809260652.21929.elendil@planet.nl>
References: <200809251119.48907.elendil@planet.nl> <1222400642.4023.187.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hpsmtp-eml18.kpnxchange.com ([213.75.38.118]:43612 "EHLO
	hpsmtp-eml18.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753987AbYIZEwZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 26 Sep 2008 00:52:25 -0400
In-Reply-To: <1222400642.4023.187.camel@yakui_zhao.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: linux-acpi@vger.kernel.org

On Friday 26 September 2008, Zhao Yakui wrote:
> Will you please try the latest kernel (2.6.27-rc6) and see whether the
> problem still exists?

Sorry that I did not make that clear, but I am already running with 
current git (v2.6.27-rc7-94-gc0f4d6d).

>    It seems that the problem is fixed by the following commit:
>    commit 48feb3c419508487becfb9ea3afcc54c3eac6d80

The kernel errors listed in that commit log are rather different from what 
I'm seeing.

Also, how could a commit in the kernel fix a broken ACPI table? No change 
in the kernel can repair syntax errors that show up when you disassemble 
and recompile the ACPI table itself, can it?
I thought using iasl as I did was the accepted way to uncover errors in a 
system's ACPI tables.

I really think the problem is in the ACPI table in this case, not in the 
kernel.

Cheers,
FJP
