From: "Satyam Sharma" <satyam.sharma@gmail.com>
Subject: Re: [PATCH][BUTTON] remove procfs-interface
Date: Mon, 16 Jul 2007 13:17:27 +0530
Message-ID: <a781481a0707160047i59b45797y491e9b303d2d8909@mail.gmail.com>
References: <4695F726.7030203@nachtwindheim.de>
	 <823A93EED437D048963A3697DB0E35DE7314AB@pdsmsx414.ccr.corp.intel.com>
	 <a781481a0707121207o3497edbye9f89c9f2589f3e5@mail.gmail.com>
	 <20070716073533.GA23083@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.224]:64204 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753795AbXGPHr2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Jul 2007 03:47:28 -0400
Received: by wr-out-0506.google.com with SMTP id i30so472836wra
        for <linux-acpi@vger.kernel.org>; Mon, 16 Jul 2007 00:47:27 -0700 (PDT)
In-Reply-To: <20070716073533.GA23083@suse.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Stefan Seyfried <seife@suse.de>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, Henne <henne@nachtwindheim.de>, Arjan van de Ven <arjan@infradead.org>, "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org

On 7/16/07, Stefan Seyfried <seife@suse.de> wrote:

> Holy sh*t. There is not even a functional replacement ready, but still
> everybody wants to remove /proc/acpi. (Maybe the replacement started
> to work recently, i have not looked into this area for the last months.
> This does not change my pint, though).
> This is not going to work.
> IMNSHO, we need the new interface available and usable for quite some time
> (i'd say for over one year), and then we can start to phase out the old
> interface.
> Starting with removing /proc/acpi is not the correct ordering of actions.

Heh, you're 3 days late to the party, but yeah, Zhang's corrected me/
pointed this out (the functionality in /proc/acpi not yet in the sysfs I/F
being used by said userspace tools) already. I guess I had originally
misunderstood the "some user space tools still use the ACPI procfs" bit.

Satyam
