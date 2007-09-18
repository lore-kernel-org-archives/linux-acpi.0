From: Len Brown <lenb@kernel.org>
Subject: Re: git-acpi breaks resume-from-ram on the Vaio
Date: Tue, 18 Sep 2007 14:04:56 -0400
Message-ID: <200709181404.56592.lenb@kernel.org>
References: <20070917211213.8e0372d6.akpm@linux-foundation.org> <200709181121.41368.lenb@kernel.org> <20070918100718.3d510356.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:46397 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753809AbXIRSFu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 18 Sep 2007 14:05:50 -0400
In-Reply-To: <20070918100718.3d510356.akpm@linux-foundation.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-acpi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, venkatesh.pallipadi@intel.com, Adam Belay <abelay@novell.com>, shaohua.li@intel.com


> I think what needs to happen is that the commits in the cpuidle code need
> to be folded together.  iirc the first couple of commits don't compile, and
> the third one fixes them.  Or something like that.

yes, i think the older history has probably outlived its utility
and can be folded entirely if it is okay with adam/venki/shaohua.

cheers,
-Len
