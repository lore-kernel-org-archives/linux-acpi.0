From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 2/2] trace, RAS: Add eMCA trace event interface
Date: Mon, 10 Mar 2014 11:31:29 +0100
Message-ID: <20140310103129.GC14808@pd.tnic>
References: <1393924997-8992-1-git-send-email-gong.chen@linux.intel.com>
 <1393924997-8992-3-git-send-email-gong.chen@linux.intel.com>
 <20140307114416.GA5255@pd.tnic>
 <20140310082241.GA873@gchen.bj.intel.com>
 <20140310070435.1981ddd5@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:51629 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752349AbaCJKbc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 10 Mar 2014 06:31:32 -0400
Content-Disposition: inline
In-Reply-To: <20140310070435.1981ddd5@samsung.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mauro Carvalho Chehab <m.chehab@samsung.com>, "Chen, Gong" <gong.chen@linux.intel.com>
Cc: tony.luck@intel.com, arozansk@redhat.com, linux-acpi@vger.kernel.org

On Mon, Mar 10, 2014 at 07:04:35AM -0300, Mauro Carvalho Chehab wrote:
> Changing the format breaks any userspace application that relies on
> parsing them. That's an API breakage. Adding more data could be
> fine, if we take enough care when doing it, and properly document
> how userspace is supposed to parse it.

Yes, we don't want code duplication if it can be helped. Besides, having
one function doing the error format issual keeps us from the case when
having two or more diverge from one another.

> Well, actually, EDAC drivers use 0 to indicate an unknown physical address.
> The better is to use the same standard used there.

However, physical address 0 is a valid address... all FFF...Fs is hardly valid.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
