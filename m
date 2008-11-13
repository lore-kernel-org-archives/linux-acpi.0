From: Greg KH <greg@kroah.com>
Subject: Re: [stable] [patch 20/23] ACPI: dock: avoid check _STA method
Date: Thu, 13 Nov 2008 13:23:05 -0800
Message-ID: <20081113212305.GA5697@kroah.com>
References: <20081107224818.593212310@mini.kroah.org> <20081107231606.GU1108@kroah.com> <20081111121607.GA32066@homac.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:53683 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751420AbYKMVYO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 13 Nov 2008 16:24:14 -0500
Content-Disposition: inline
In-Reply-To: <20081111121607.GA32066@homac.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org, stable@kernel.org, Justin Forbes <jmforbes@linuxtx.org>, Zwane Mwaikambo <zwane@arm.linux.org.uk>, Theodore Ts'o <tytso@mit.edu>

On Tue, Nov 11, 2008 at 01:16:07PM +0100, Holger Macht wrote:
> On Fri 07. Nov - 15:16:06, Greg KH wrote:
> > 2.6.26-stable review patch.  If anyone has any objections, please let us know.
> 
> Objecting. This will only work in conjunction with
> 
>   commit 39a0ad871000d2a016a4fa113a6e53d22aabf25d
>   Author: Zhao Yakui <yakui.zhao@intel.com>
>   Date:   Mon Aug 11 13:40:22 2008 +0800
> 
>       ACPI : Load device driver according to the status of acpi device
> 
> Otherwise a device struct already exists although the device is not
> present.

So do you feel we should also add this patch to the 2.6.27-stable tree
to solve this issue?

thanks,

greg k-h
