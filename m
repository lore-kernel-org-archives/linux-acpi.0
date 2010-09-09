From: Anisse Astier <anisse@astier.eu>
Subject: Re: Toshiba Satellite L650D-10J only boots with acpi=off
Date: Thu, 9 Sep 2010 11:37:01 +0200
Message-ID: <20100909113701.50ad47b2@destiny.ordissimo>
References: <20100828192538.666c34c4.frank@61924.nl>
	<1283127802.3707.163.camel@rui>
	<20100830142618.ef9876aa.frank@61924.nl>
	<1283216239.3707.170.camel@rui>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:47010 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751348Ab0IIJhH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 9 Sep 2010 05:37:07 -0400
Received: by ewy23 with SMTP id 23so672741ewy.19
        for <linux-acpi@vger.kernel.org>; Thu, 09 Sep 2010 02:37:05 -0700 (PDT)
In-Reply-To: <1283216239.3707.170.camel@rui>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Frank <frank@61924.nl>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Len Brown <len.brown@intel.com>, Lin Ming <ming.m.lin@intel.com>

On Tue, 31 Aug 2010 08:57:19 +0800, Zhang Rui <rui.zhang@intel.com> wrote :

> On Mon, 2010-08-30 at 20:26 +0800, Frank wrote:
> > It works, it sees the two cores of my CPU and I the acpi command gives
> > me info about the CPU, temperature, battery and cooling. The laptop
> > also shutsdown by itself when I execute the shutdown command.
> > 
> > Here's the output from 'dmesg | grep -i ACPI':
> > http://codepad.org/KcqZMvCa
> > 
> so it seems like we need to add another dmi entry for this laptop.
> please attach the dmidecode output.

I sent a patch for a similar model recently:
http://www.spinics.net/lists/linux-acpi/msg29761.html
Except it's a C650D instead of the L650D here.
It appears this patch hasn't been merged yet.

Regards,
Anisse
