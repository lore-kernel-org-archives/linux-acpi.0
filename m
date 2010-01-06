From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 4/5] ACPI, APEI, EINJ support
Date: Wed, 6 Jan 2010 08:08:07 +0100
Message-ID: <20100106070807.GA1494@ucw.cz>
References: <1261980744-4450-1-git-send-email-ying.huang@intel.com> <1261980744-4450-2-git-send-email-ying.huang@intel.com> <1261980744-4450-3-git-send-email-ying.huang@intel.com> <1261980744-4450-4-git-send-email-ying.huang@intel.com> <1261980744-4450-5-git-send-email-ying.huang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:34297 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751998Ab0AFHI3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Jan 2010 02:08:29 -0500
Content-Disposition: inline
In-Reply-To: <1261980744-4450-5-git-send-email-ying.huang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Huang Ying <ying.huang@intel.com>
Cc: lenb@kernel.org, ak@linux.intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Mon 2009-12-28 14:12:23, Huang Ying wrote:
> EINJ provides a hardware error injection mechanism, this is useful for
> debugging and testing of other APEI and RAS features.
> 
> Signed-off-by: Huang Ying <ying.huang@intel.com>
> ---
>  drivers/acpi/apei/Kconfig  |    7 +
>  drivers/acpi/apei/Makefile |    1 +
>  drivers/acpi/apei/einj.c   |  471 ++++++++++++++++++++++++++++++++++++++++++++


Can we get more meaningfull name? err_inject.c?
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
