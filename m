From: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH] ACPI/Battery: Retry to get Battery information if failed
 during probing
Date: Thu, 12 Jun 2014 14:17:02 -0700 (PDT)
Message-ID: <alpine.DEB.2.02.1406121415150.8305@chino.kir.corp.google.com>
References: <1402552946-14704-1-git-send-email-tianyu.lan@intel.com> <alpine.DEB.2.02.1406112354070.23724@chino.kir.corp.google.com> <53995488.20308@intel.com> <alpine.DEB.2.02.1406120025050.23724@chino.kir.corp.google.com> <53996152.2000407@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ig0-f175.google.com ([209.85.213.175]:53531 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752290AbaFLVRF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Jun 2014 17:17:05 -0400
Received: by mail-ig0-f175.google.com with SMTP id uq10so8178166igb.14
        for <linux-acpi@vger.kernel.org>; Thu, 12 Jun 2014 14:17:04 -0700 (PDT)
In-Reply-To: <53996152.2000407@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: rjw@rjwysocki.net, lenb@kernel.org, naszar@ya.ru, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

On Thu, 12 Jun 2014, Lan Tianyu wrote:

> The retry time is set by randomly and not accurate because don't know
> when EC will work normally. Set the retry time to 5 just in order to
> make sure battery driver probing sucessfully every time,
> 

Ok, I was hoping to avoid the excessive wait if it will never actually 
succeed but I assume there's some evidence that it can succeed after 40ms, 
60ms, etc.  Please consider the following instead:

	for (i = 0; i < 5; i++) {
		/* Comment on why we need a delay in between retries */
		if (i)
			msleep(20);
		result = acpi_battery_update(battery, false);
		if (!result)
			break;
	}
