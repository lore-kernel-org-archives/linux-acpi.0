From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 02/28] ACPICA: Linuxize: Replace __FUNCTION__ with
 __func__.
Date: Wed, 24 Jun 2015 05:55:59 -0700
Message-ID: <20150624125559.GA8144@infradead.org>
References: <cover.1434684719.git.lv.zheng@intel.com>
 <cover.1435114811.git.lv.zheng@intel.com>
 <9572a1ad1d35f3c68979610a389063813fd2d2c5.1435114811.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:56946 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751973AbbFXM4A (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 24 Jun 2015 08:56:00 -0400
Content-Disposition: inline
In-Reply-To: <9572a1ad1d35f3c68979610a389063813fd2d2c5.1435114811.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Wed, Jun 24, 2015 at 11:02:03AM +0800, Lv Zheng wrote:
> ACPICA commit cb3d1c79f862cd368d749c9b8d9dced40111b0d0
> 
> __FUNCTION__ is MSVC only, in Linux, it is __func__. Lv Zheng.
> 
> In ACPICA, this is achieved by string replacement in release script and
> this patch contains the source code difference between the Linux upstream
> and ACPICA that is caused by the back porting.

__func__ is in C99 and never.  __FUNCTION__ is an old extension supported
by various compilers.
