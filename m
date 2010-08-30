From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: Toshiba Satellite L650D-10J only boots with acpi=off
Date: Mon, 30 Aug 2010 08:23:22 +0800
Message-ID: <1283127802.3707.163.camel@rui>
References: <20100828192538.666c34c4.frank@61924.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:5651 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753816Ab0H3AUE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 29 Aug 2010 20:20:04 -0400
In-Reply-To: <20100828192538.666c34c4.frank@61924.nl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Frank <frank@61924.nl>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Hi, Frank,

could you please check if boot option acpi=copy_dsdt helps?
Note, please do this test in the latest kernel.

thanks,
rui

On Sun, 2010-08-29 at 01:25 +0800, Frank wrote:
> Hello,
> 
> I purchased a Toshiba Satellite L650D-10J a few days ago and when I
> wanted to install Archlinux I was only able to boot the installer with
> acpi=off. The same goes for the installed OS.
> 
> I asked on ##kernel on freenode and one guy said I should mail this
> issue to this mailing list. And include all the information I have.
> 
> This is what I get when I boot without acpi=off:
> http://i.imagehost.org/view/0872/DSC00071
> http://a.imagehost.org/view/0172/DSC00069
> 
> The system boots normally when I use acpi=off, but the dual-core CPU is
> seen as a CPU with one core. And X is slow with starting up and doesn't
> shutdown when I close Openbox, but I'm not sure if that's even related.
> 
> Here's the dmesg:
> http://codepad.org/W7EzULKf
> 
> And the lspci:
> http://codepad.org/ce1boP3r
> 
> I'm using the stock Archlinux x86_64 kernel (the latest is 2.6.35.3-1
> at this moment) and the config files can be found here:
> http://repos.archlinux.org/wsvn/packages/kernel26/repos/core-x86_64/
> 
> If more information is needed, I'll glady provide it.
> 
> Regards,
> Frank
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


