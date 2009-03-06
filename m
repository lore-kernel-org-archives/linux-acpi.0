From: Richard Hughes <hughsient@gmail.com>
Subject: Re: [PATCH] toshiba_acpi: Add full hotkey support
Date: Fri, 06 Mar 2009 09:08:56 +0000
Message-ID: <1236330536.12838.2.camel@hughsie-work.lan>
References: <20090306003941.GA32403@srcf.ucam.org>
	 <20090306005234.GA32539@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.154]:6070 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751625AbZCFJJu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 6 Mar 2009 04:09:50 -0500
In-Reply-To: <20090306005234.GA32539@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org, dsilvers@simtec.co.uk, toshiba_acpi@memebeam.org, linux-kernel@vger.kernel.org, len.brown@intel.com

On Fri, 2009-03-06 at 00:52 +0000, Matthew Garrett wrote:
> Calling the ENAB method on Toshiba laptops results in notifications 
> being sent when laptop hotkeys are pressed. This patch simply calls that 
> method and sets up an input device if it's successful.

Great news - no polling!

Definitely +1 from me.

Richard.




