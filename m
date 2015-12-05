From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 1/9] device core: add BUS_NOTIFY_DRIVER_NOT_BOUND
 notification
Date: Sat, 5 Dec 2015 08:14:16 -0800
Message-ID: <20151205161416.GA1215@kroah.com>
References: <1449265765-9393-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1449265765-9393-2-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:54927 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753621AbbLEQOR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 5 Dec 2015 11:14:17 -0500
Content-Disposition: inline
In-Reply-To: <1449265765-9393-2-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, dmaengine@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>

On Fri, Dec 04, 2015 at 11:49:17PM +0200, Andy Shevchenko wrote:
> The users of BUS_NOTIFY_BIND_DRIVER have no chance to do any cleanup in case of
> a probe failure. In the result there might be problems, such as some resources
> that had been allocated will continue to be allocated and therefore lead to a
> resource leak.
> 
> Introduce a new notification to inform the subscriber that ->probe() failed. Do
> the same in case of failed device_bind_driver() call.

Ugh, I hate all these notifiers, but this one does make sense...

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
