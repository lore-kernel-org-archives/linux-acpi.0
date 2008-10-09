From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/3] acer-wmi: Add rfkill support for wireless and
	bluetooth
Date: Thu, 9 Oct 2008 01:17:15 -0400
Message-ID: <20081009051715.GD11477@anvil.corenet.prv>
References: <20081008204015.1815.15275.stgit@localhost> <20081008204021.1815.69879.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.228]:28266 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751295AbYJIFRT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 9 Oct 2008 01:17:19 -0400
Received: by wx-out-0506.google.com with SMTP id h27so989073wxd.4
        for <linux-acpi@vger.kernel.org>; Wed, 08 Oct 2008 22:17:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20081008204021.1815.69879.stgit@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Carlos Corbacho <carlos@strangeworlds.co.uk>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org

Hi Carlos,

On Wed, Oct 08, 2008 at 09:40:21PM +0100, Carlos Corbacho wrote:
> +
> +	rfkill_workqueue = create_singlethread_workqueue("rfkill_workqueue");
> +	if (!rfkill_workqueue) {
> +		if (has_cap(ACER_CAP_BLUETOOTH)) {
> +			kfree(bluetooth_rfkill->data);
> +			rfkill_unregister(bluetooth_rfkill);
> +		}
> +		kfree(wireless_rfkill->data);
> +		rfkill_unregister(wireless_rfkill);
> +		return -ENOMEM;
> +	}
> +	queue_delayed_work(rfkill_workqueue, &acer_rfkill_work, HZ);
> +

Do we really need a private workqueue here? acer_rfkill_work seems to
be a 'quickie' and so keventd should work pretty well here, shouldn't
it?

Thanks!

-- 
Dmitry
