From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [PATCH v4 08/14] apm32: remove paravirt_enabled() use
Date: Fri, 8 Apr 2016 00:31:23 +0200
Message-ID: <20160407223123.GI1990@wotan.suse.de>
References: <1459987594-5434-1-git-send-email-mcgrof@kernel.org>
 <1459987594-5434-9-git-send-email-mcgrof@kernel.org>
 <57065BD4.3040209@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:39496 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753551AbcDGWb1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 7 Apr 2016 18:31:27 -0400
Content-Disposition: inline
In-Reply-To: <57065BD4.3040209@oracle.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, bp@alien8.de, hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, rusty@rustcorp.com.au, x86@kernel.org, linux-kernel@vger.kernel.org, luto@amacapital.net, david.vrabel@citrix.com, konrad.wilk@oracle.com, xen-devel@lists.xensource.com, lguest@lists.ozlabs.org, andriy.shevchenko@linux.intel.com, jlee@suse.com, glin@suse.com, matt@codeblueprint.co.uk, andrew.cooper3@citrix.com, rjw@rjwysocki.net, lenb@kernel.org, robert.moore@intel.com, lv.zheng@intel.com, toshi.kani@hp.com, linux-acpi@vger.kernel.org, Takashi Iwai <tiwai@suse.de>

On Thu, Apr 07, 2016 at 09:08:36AM -0400, Boris Ostrovsky wrote:
> On 04/06/2016 08:06 PM, Luis R. Rodriguez wrote:
> >There is already a check for apm_info.bios == 0, the
> >apm_info.bios is set from the boot_params.apm_bios_info.
> >Both Xen and lguest, which are also the only ones that set
> >paravirt_enabled to true, never set the apm_bios.info. The
> >
> >Xen folks are sure force disable to 0 is not needed,
> 
> Because apm_info lives in .bss (which we recently made sure is
> cleared on Xen PV). May be worth mentioning in the commit message so
> that we don't forget why this is not needed.

Thanks, I'll change that last paragraph with:

Xen folks are sure force disable to 0 is not needed because
apm_info lives in .bss, we recently forced disabled this on
lguest, and on the Xen side just to be sure Boris zeroed out
the .bss for PV guests through commit 04b6b4a56884327c1648
("xen/x86: Zero out .bss for PV guests"). With this care taken
into consideration the paravirt_enabled() check is simply not
needed anymore.

> I think you also have this statement in other patches.

Indeed, I'll highlight this on the tboot commit log as well.

  Luis
