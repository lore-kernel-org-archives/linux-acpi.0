From: Chris Mason <chris.mason@oracle.com>
Subject: Re: [PATCH] set dock_station->flags to zero during dock_add
Date: Mon, 1 Feb 2010 12:45:57 -0500
Message-ID: <20100201174557.GB3240@think>
References: <20100201163043.GA3240@think>
 <20100201173518.GA28002@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from acsinet11.oracle.com ([141.146.126.233]:61445 "EHLO
	acsinet11.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752602Ab0BARr1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Feb 2010 12:47:27 -0500
Content-Disposition: inline
In-Reply-To: <20100201173518.GA28002@ldl.fc.hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alex Chiang <achiang@hp.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, stable@kernel.org

On Mon, Feb 01, 2010 at 10:35:18AM -0700, Alex Chiang wrote:
> Hi Chris,
> 
> Thanks for catching this. Seems better to just memset the stack
> variable before we kmemdup it in platform_deivce_register_data().
> 
> How about this instead?

[ memset instead of explicitly setting flags to zero ]

I didn't do the memset because lower down we init every other field, but
zeros are zeros really.

Looking at platform_device_register_data, you could even make ds
static...now that is sure to break in small and subtle ways later on ;)

-chris
