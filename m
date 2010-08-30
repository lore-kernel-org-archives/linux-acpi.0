From: Frank <frank@61924.nl>
Subject: Re: Toshiba Satellite L650D-10J only boots with acpi=off
Date: Mon, 30 Aug 2010 14:26:18 +0200
Message-ID: <20100830142618.ef9876aa.frank@61924.nl>
References: <20100828192538.666c34c4.frank@61924.nl>
	<1283127802.3707.163.camel@rui>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail6.webfaction.com ([74.55.86.74]:42857 "EHLO
	smtp.webfaction.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752091Ab0H3Mcy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 30 Aug 2010 08:32:54 -0400
In-Reply-To: <1283127802.3707.163.camel@rui>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi@vger.kernel.org

It works, it sees the two cores of my CPU and I the acpi command gives
me info about the CPU, temperature, battery and cooling. The laptop
also shutsdown by itself when I execute the shutdown command.

Here's the output from 'dmesg | grep -i ACPI':
http://codepad.org/KcqZMvCa

The only problem left is that X starts slowly and doesn't shutdown when
I exit Openbox, but that's has probably to do with the video driver.

Regards,
Frank

> Hi, Frank,
> 
> could you please check if boot option acpi=copy_dsdt helps?
> Note, please do this test in the latest kernel.
