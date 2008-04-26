From: Greg KH <greg@kroah.com>
Subject: Re: [stable] [2.6.25-stable PATCH] regression: powertop says 120K
	wakeups/sec
Date: Fri, 25 Apr 2008 18:51:54 -0700
Message-ID: <20080426015154.GA25196@kroah.com>
References: <200804242015.19462.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:47339 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754621AbYDZCIN (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Fri, 25 Apr 2008 22:08:13 -0400
Content-Disposition: inline
In-Reply-To: <200804242015.19462.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: stable@kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Linux-acpi@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

On Thu, Apr 24, 2008 at 08:15:19PM -0400, Len Brown wrote:
> From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
> Date:   Wed Apr 9 21:31:46 2008 -0400
> 
> commit 0fda6b403f0eca66ad8a7c946b3996e359100443

I don't see this commit in Linus's tree, is it not needed in it and only
in the 2.6.25-stable tree as it was fixed some other way?

confused,

greg k-h
