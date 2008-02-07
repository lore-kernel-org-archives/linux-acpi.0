From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 111/112] Revert "cpuidle: build fix for non-x86"
Date: Thu, 7 Feb 2008 11:27:28 +0100
Message-ID: <20080207102728.GC16735@elte.hu>
References: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com> <9b7131542178f5f948e4bb6bea6e1c545e697b06.1202376825.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:47568 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754482AbYBGK1m (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 7 Feb 2008 05:27:42 -0500
Content-Disposition: inline
In-Reply-To: <9b7131542178f5f948e4bb6bea6e1c545e697b06.1202376825.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>


* Len Brown <lenb@kernel.org> wrote:

> From: Len Brown <len.brown@intel.com>
> 
> This reverts commit f757397097d0713c949af76dccabb65a2785782e.
> which ironically broke the ia64 build

hm, this seems to be an internal ACPI commit - why not eliminate both 
commits (the broken one and the revert one) and thus fix that window of 
non-bisectability, before pushing this upstream?

	Ingo
