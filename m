From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: Toshiba Satellite L650D-10J only boots with acpi=off
Date: Tue, 31 Aug 2010 08:57:19 +0800
Message-ID: <1283216239.3707.170.camel@rui>
References: <20100828192538.666c34c4.frank@61924.nl>
	 <1283127802.3707.163.camel@rui>  <20100830142618.ef9876aa.frank@61924.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:62280 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755901Ab0HaAyA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 30 Aug 2010 20:54:00 -0400
In-Reply-To: <20100830142618.ef9876aa.frank@61924.nl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Frank <frank@61924.nl>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Mon, 2010-08-30 at 20:26 +0800, Frank wrote:
> It works, it sees the two cores of my CPU and I the acpi command gives
> me info about the CPU, temperature, battery and cooling. The laptop
> also shutsdown by itself when I execute the shutdown command.
> 
> Here's the output from 'dmesg | grep -i ACPI':
> http://codepad.org/KcqZMvCa
> 
so it seems like we need to add another dmi entry for this laptop.
please attach the dmidecode output.

> The only problem left is that X starts slowly and doesn't shutdown when
> I exit Openbox, but that's has probably to do with the video driver.

please attach the dmesg output after boot.

thanks,
rui

> Regards,
> Frank
> 
> > Hi, Frank,
> > 
> > could you please check if boot option acpi=copy_dsdt helps?
> > Note, please do this test in the latest kernel.


