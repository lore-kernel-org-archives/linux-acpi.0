From: Byron Hillis <the.metric@gmail.com>
Subject: RE: acpi_power_off doesn't
Date: Wed, 17 May 2006 10:04:07 +1000
Message-ID: <e4dp97$lpa$1@sea.gmane.org>
References: <CFF307C98FEABE47A452B27C06B85BB675ABCD@hdsmsx411.amr.corp.intel.com>
Reply-To: the.metric@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:46276 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932454AbWEQHFD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 17 May 2006 03:05:03 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1FgG5e-0001vS-FT
	for linux-acpi@vger.kernel.org; Wed, 17 May 2006 09:05:02 +0200
Received: from r220-101-78-70.cpe.unwired.net.au ([220.101.78.70])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Wed, 17 May 2006 09:05:02 +0200
Received: from the.metric by r220-101-78-70.cpe.unwired.net.au with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Wed, 17 May 2006 09:05:02 +0200
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Brown, Len wrote:

>>>> Sometimes when I run 'halt' my PC does not go off. Last
>>>> words are
>>>>
>>>> acpi_power_off called
>>>>
>>>> But the PC stays on.
>>>>
>>>> What is the story here? I've seen this problem come up
>>>> several times, but without solution, as it seems. Any
>>>> hint would be very helpfull.
>>> 

I can second that this happens here as well. I've tried removing all
modules that I can think of and for some reason, it sometimes won't
shutdown. Strangely though, when I use suspend2 patches and hibernate
the machine, it successfully powers down when I hibernate, but still 
won't shutdown regularly using shutdown -h now.

This is with a 2.6.16 kernel on a laptop with an Intel ICH6 board.

Byron


