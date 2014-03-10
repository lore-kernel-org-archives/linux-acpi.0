From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 2/2] trace, RAS: Add eMCA trace event interface
Date: Mon, 10 Mar 2014 11:33:06 +0100
Message-ID: <20140310103306.GD14808@pd.tnic>
References: <1393924997-8992-1-git-send-email-gong.chen@linux.intel.com>
 <1393924997-8992-3-git-send-email-gong.chen@linux.intel.com>
 <20140307114416.GA5255@pd.tnic>
 <20140310082241.GA873@gchen.bj.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:51666 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752191AbaCJKdJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 10 Mar 2014 06:33:09 -0400
Content-Disposition: inline
In-Reply-To: <20140310082241.GA873@gchen.bj.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Chen, Gong" <gong.chen@linux.intel.com>
Cc: tony.luck@intel.com, m.chehab@samsung.com, arozansk@redhat.com, linux-acpi@vger.kernel.org

On Mon, Mar 10, 2014 at 04:22:42AM -0400, Chen, Gong wrote:
> Do we really need to do that? IMHO, I think they are used for two
> different usages, just like dmesg & mcelog.

Yes, we do. We want to be able to disable issuing errors into dmesg so
that people don't have to parse it. This is the main reason why we're
adding tracepoints - so that we have structured error format going out
of the kernel.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
