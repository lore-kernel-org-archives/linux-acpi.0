From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 111/112] Revert "cpuidle: build fix for non-x86"
Date: Thu, 7 Feb 2008 13:47:46 -0500
Message-ID: <200802071347.47101.lenb@kernel.org>
References: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com> <9b7131542178f5f948e4bb6bea6e1c545e697b06.1202376825.git.len.brown@intel.com> <20080207102728.GC16735@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:58640 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751154AbYBGSsK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 7 Feb 2008 13:48:10 -0500
In-Reply-To: <20080207102728.GC16735@elte.hu>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-acpi@vger.kernel.org

On Thursday 07 February 2008 05:27, Ingo Molnar wrote:
> 
> * Len Brown <lenb@kernel.org> wrote:
> 
> > From: Len Brown <len.brown@intel.com>
> > 
> > This reverts commit f757397097d0713c949af76dccabb65a2785782e.
> > which ironically broke the ia64 build
> 
> hm, this seems to be an internal ACPI commit - why not eliminate both 
> commits (the broken one and the revert one) and thus fix that window of 
> non-bisectability, before pushing this upstream?

i agree, and this bothered me too.
Dunno if I have time to undo and re-merge my tree
before Linus pulls and/or declares rc1...

-Len
