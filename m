From: Huang Ying <ying.huang@intel.com>
Subject: Re: [RFC] ACPI, APEI: Fix incorrect bit width + offset check
 condition
Date: Thu, 19 Jul 2012 08:37:54 +0800
Message-ID: <1342658274.9635.68.camel@yhuang-dev>
References: <1339573184-3122-1-git-send-email-hui.xiao@linux.intel.com>
	 <20120613104651.52ce8840@endymion.delvare>
	 <20120613174517.GA2141@us.ibm.com> <4FD98146.9060209@linux.intel.com>
	 <20120614100907.3241376d@endymion.delvare> <500672A0.10808@linux.intel.com>
	 <20120718162846.25a64bf0@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:25658 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751477Ab2GSAh5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 18 Jul 2012 20:37:57 -0400
In-Reply-To: <20120718162846.25a64bf0@endymion.delvare>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: Chen Gong <gong.chen@linux.intel.com>, "Xiao, Hui" <hui.xiao@linux.intel.com>, Gary Hade <garyhade@us.ibm.com>, tony.luck@intel.com, lenb@kernel.org, pluto@agmk.net, linux-acpi@vger.kernel.org

On Wed, 2012-07-18 at 16:28 +0200, Jean Delvare wrote:
> On Wed, 18 Jul 2012 16:24:00 +0800, Chen Gong wrote:
> > > On Thu, 14 Jun 2012 14:14:30 +0800, Xiao, Hui wrote:
> > Now we have a final decision for this issue? Anyway, we need a patch to
> > fix our BIOS issue.
> > 
> > Jean or Gary, if OK, would you please cook one patch to fix this issue?
> 
> Ying's patch adding resource allocation time checks is already in:
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=commit;h=34ddeb035d704eafdcdb3cbc781894300136c3c4
> This addresses the log message flood issue.
> 
> My own patch with one BIOS bug fixup was accepted by Len Brown and
> should go into kernel 3.6:
> https://bugzilla.kernel.org/show_bug.cgi?id=43282#c25
> (Not sure which tree this is.)
> 
> So, as far as I am concerned, the functional issue is solved. From a
> performance perspective I think we could drop the run-time checks as
> they are now redundant.

Performance is not so important for these code.  I keep the run-time
checks as the safe guard for future potential issues.  If you don't like
it, we can add some comments to mark that it is redundant, just safe
guard and should be removed in the future.

Best Regards,
Huang Ying


