From: Frank <frank@61924.nl>
Subject: Re: Toshiba Satellite L650D-10J only boots with acpi=off
Date: Tue, 31 Aug 2010 12:44:03 +0200
Message-ID: <20100831124403.79be2f2f.frank@61924.nl>
References: <20100828192538.666c34c4.frank@61924.nl>
	<1283127802.3707.163.camel@rui>
	<20100830142618.ef9876aa.frank@61924.nl>
	<1283216239.3707.170.camel@rui>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail6.webfaction.com ([74.55.86.74]:51818 "EHLO
	smtp.webfaction.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757147Ab0HaKum (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 31 Aug 2010 06:50:42 -0400
In-Reply-To: <1283216239.3707.170.camel@rui>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi@vger.kernel.org

> > It works, it sees the two cores of my CPU and I the acpi command gives
> > me info about the CPU, temperature, battery and cooling. The laptop
> > also shutsdown by itself when I execute the shutdown command.
> > 
> > Here's the output from 'dmesg | grep -i ACPI':
> > http://codepad.org/KcqZMvCa
> > 
> so it seems like we need to add another dmi entry for this laptop.
> please attach the dmidecode output.

Here is the dmidecode output:
http://codepad.org/RBiPnsxf

> > The only problem left is that X starts slowly and doesn't shutdown when
> > I exit Openbox, but that's has probably to do with the video driver.
> 
> please attach the dmesg output after boot.

Sorry, it was a typo in .xserverrc. It's solved now.

Regards,
Frank
