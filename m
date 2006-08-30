From: Jiri Kosina <jikos@jikos.cz>
Subject: Re: [patch 11/14] ACPI: change GFP_ATOMIC to GFP_KERNEL for non-atomic
 allocation
Date: Thu, 31 Aug 2006 00:28:36 +0200 (CEST)
Message-ID: <Pine.LNX.4.58.0608310027100.31711@twin.jikos.cz>
References: <EB12A50964762B4D8111D55B764A845480122D@scsmsx413.amr.corp.intel.com>
 <Pine.LNX.4.58.0608301228100.31711@twin.jikos.cz> <20060830110156.A30823@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from twin.jikos.cz ([213.151.79.26]:54205 "EHLO twin.jikos.cz")
	by vger.kernel.org with ESMTP id S932208AbWH3W3S (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 30 Aug 2006 18:29:18 -0400
In-Reply-To: <20060830110156.A30823@unix-os.sc.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

On Wed, 30 Aug 2006, Venkatesh Pallipadi wrote:

> Below is the refreshed patch. Please try it on your system whenever you
> get a chance. C-states on your platform should work in the same way
> with/without this patch. It should not hang as with the earlier patch.

Hi,

I have been runing kernel with this patch for a few hours already 
(including a few suspend/resume cycles), and everything seems fine so far. 

Thanks,

-- 
JiKos.
