From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [PATCH v4 00/14] x86: remove paravirt_enabled
Date: Fri, 8 Apr 2016 03:14:43 +0200
Message-ID: <20160408011443.GO1990@wotan.suse.de>
References: <1459987594-5434-1-git-send-email-mcgrof@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:46702 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752530AbcDHBOr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 7 Apr 2016 21:14:47 -0400
Content-Disposition: inline
In-Reply-To: <1459987594-5434-1-git-send-email-mcgrof@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: bp@alien8.de
Cc: hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, rusty@rustcorp.com.au, x86@kernel.org, linux-kernel@vger.kernel.org, luto@amacapital.net, boris.ostrovsky@oracle.com, david.vrabel@citrix.com, konrad.wilk@oracle.com, xen-devel@lists.xensource.com, lguest@lists.ozlabs.org, andriy.shevchenko@linux.intel.com, jlee@suse.com, glin@suse.com, matt@codeblueprint.co.uk, andrew.cooper3@citrix.com, rjw@rjwysocki.net, lenb@kernel.org, robert.moore@intel.com, lv.zheng@intel.com, toshi.kani@hp.com, linux-acpi@vger.kernel.org, kozerkov@parallels.com, josh@joshtriplett.org

On Wed, Apr 06, 2016 at 05:06:20PM -0700, Luis R. Rodriguez wrote:
> Now that Andy's ASM paravirt_enabled() use is merged 

Sorry I should have provided more context, I meant that now
that Andy's ASM paravirt_enabled() removal is merged:

This is the ASM hack that Andy removed:
https://git.kernel.org/cgit/linux/kernel/git/luto/linux.git/commit/?h=x86/fsgsbase&id=58a5aac5331388a175a42b6ed2154f0559cefb21

This puts a nail on coffin for the ASM hack:
https://git.kernel.org/cgit/linux/kernel/git/luto/linux.git/commit/?h=x86/fsgsbase&id=0dd0036f6e07f741a1356b424b84a3164b6e59cf

  Luis
