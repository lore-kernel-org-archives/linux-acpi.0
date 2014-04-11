From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [PATCH] Default to using the native backlight control
 on Windows 8 systems
Date: Fri, 11 Apr 2014 10:56:13 +0800
Message-ID: <534759CD.20405@intel.com>
References: <1397160803-24297-1-git-send-email-matthew.garrett@nebula.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:36436 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754362AbaDKC4I (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 10 Apr 2014 22:56:08 -0400
In-Reply-To: <1397160803-24297-1-git-send-email-matthew.garrett@nebula.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <matthew.garrett@nebula.com>, dri-devel@lists.freedesktop.org
Cc: linux-acpi@vger.kernel.org

On 04/11/2014 04:13 AM, Matthew Garrett wrote:
> The list of machines in the "Use native backlight" table is getting longer
> and longer, which is a solid indication that we're doing something wrong.
> Disable the ACPI backlight interface if the system claims to be Windows 8
> or later.

And has a native backlight control interface.

> 
> Signed-off-by: Matthew Garrett <matthew.garrett@nebula.com>
> ---
> 
> Let's at least get this into -next for 3.16 and figure out whether the
> drivers actually work now.

I agree.
