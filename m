From: Borislav Petkov <bp@alien8.de>
Subject: Re: Extended H/W error log driver
Date: Mon, 14 Oct 2013 12:55:33 +0200
Message-ID: <20131014105533.GF4009@pd.tnic>
References: <1381473166-29303-1-git-send-email-gong.chen@linux.intel.com>
 <20131011080427.GC18719@pd.tnic>
 <20131014064940.GD12189@gchen.bj.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:58129 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756019Ab3JNKzp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 14 Oct 2013 06:55:45 -0400
Content-Disposition: inline
In-Reply-To: <20131014064940.GD12189@gchen.bj.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Chen Gong <gong.chen@linux.intel.com>
Cc: tony.luck@intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Mon, Oct 14, 2013 at 02:49:40AM -0400, Chen Gong wrote:
> On Fri, Oct 11, 2013 at 10:04:27AM +0200, Borislav Petkov wrote:
> > > [56005.786154] {4}Hardware error detected on CPU0
> > > [56005.786159] {4}event severity: corrected
> > > [56005.786162] {4}sub_event[0], severity: corrected
> > 
> > This sub_event[0] could use better decoding though.
> > 
> What's your suggestion?

Well, if this only enumerates the sections in CPER, then we can simply
drop it.

Btw, I was wondering, why are we dropping
cper_estatus_section_flag_strs? This is again the same issue with
changing output which people might already rely upon.

Thanks.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
