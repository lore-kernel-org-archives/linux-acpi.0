From: Eric Cooper <ecc@cmu.edu>
Subject: Re: boot hangs with SMP, USB storage, and ACPI
Date: Sat, 15 Sep 2007 10:20:55 -0400
Message-ID: <20070915142055.GA3983@stratocaster.home>
References: <9b9c8e900709120600n3ffa9b6fn1bd514672d2e9bc1@mail.gmail.com> <20070915025208.acb03ad3.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from CHOKECHERRY.SRV.CS.CMU.EDU ([128.2.185.41]:62200 "EHLO
	chokecherry.srv.cs.cmu.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751312AbXIOPNy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 15 Sep 2007 11:13:54 -0400
Content-Disposition: inline
In-Reply-To: <20070915025208.acb03ad3.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: tx tox <t0mc4t1@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Sat, Sep 15, 2007 at 02:52:08AM -0700, Andrew Morton wrote:
> Could you both please test 2.6.22 (or 2.6.23, soon) and if the bug is still
> present, raise a report against acpi at bugzilla.kernel.org?
> 
> We'd be particularly internested in knowing if any earlier 2.6 kernel
> worked OK and if so, which version(s).

I tried this with prebuilt Debian package linux-image-2.6.21-2-686
from "testing" and linux-image-2.6.22-2-686 from "unstable".

The problem is still present in both versions.  Will file a bugzilla
report as requested.

-- 
Eric Cooper             e c c @ c m u . e d u
