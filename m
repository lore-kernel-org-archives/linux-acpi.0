From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [PATCH v1 1/2] x86/init: disable pnpbios for
 X86_SUBARCH_INTEL_MID
Date: Thu, 14 Apr 2016 01:33:45 +0200
Message-ID: <20160413233345.GJ1990@wotan.suse.de>
References: <1460161361-13635-1-git-send-email-mcgrof@kernel.org>
 <1460161361-13635-2-git-send-email-mcgrof@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:55114 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751909AbcDMXds (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 13 Apr 2016 19:33:48 -0400
Content-Disposition: inline
In-Reply-To: <1460161361-13635-2-git-send-email-mcgrof@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: bp@alien8.de, hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, rusty@rustcorp.com.au, x86@kernel.org, linux-kernel@vger.kernel.org, luto@amacapital.net, boris.ostrovsky@oracle.com, david.vrabel@citrix.com, konrad.wilk@oracle.com, xen-devel@lists.xensource.com, lguest@lists.ozlabs.org, andriy.shevchenko@linux.intel.com, jlee@suse.com, glin@suse.com, matt@codeblueprint.co.uk, andrew.cooper3@citrix.com, rjw@rjwysocki.net, lenb@kernel.org, robert.moore@intel.com, lv.zheng@intel.com, toshi.kani@hp.com, linux-acpi@vger.kernel.org, kozerkov@parallels.com, josh@joshtriplett.org, joro@8bytes.org, tiwai@suse.de, sathyanarayanan.kuppuswamy@linux.intel.com, alan@linux.intel.com, rui.zhang@intel.com, mbizon@freebox.fr, bigeasy@linutronix.de, ffainelli@freebox.fr

On Fri, Apr 08, 2016 at 05:22:40PM -0700, Luis R. Rodriguez wrote:
> As per hpa Intel MID platforms can also disable pnpbios [0].
> 
> [0] http://lkml.kernel.org/r/5702B5C2.7070101@zytor.com
> 
> Suggested-by: H. Peter Anvin <hpa@zytor.com>
> Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>

As per 0-day this saves us 8 bytes on tinyconfig. Will amend
and resubmit with updated commit log.

  Luis
