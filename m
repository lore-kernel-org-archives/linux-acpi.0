From: Borislav Petkov <bp@alien8.de>
Subject: Re: RFC: APEI hardware reduced profile
Date: Wed, 26 Mar 2014 21:36:50 +0100
Message-ID: <20140326203650.GA3933@nazgul.tnic>
References: <5332C32A.5070301@linaro.org>
 <6220935.TPfvPdvLIs@vostro.rjw.lan>
 <20140326121047.65176d7e@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:45872 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755195AbaCZUhD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 26 Mar 2014 16:37:03 -0400
Content-Disposition: inline
In-Reply-To: <20140326121047.65176d7e@samsung.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mauro Carvalho Chehab <m.chehab@samsung.com>, Tomasz Nowicki <tomasz.nowicki@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linaro-acpi <linaro-acpi@lists.linaro.org>, Tony <tony.luck@intel.com>, Borislav Petkov <bp@suse.de>, linux-edac@vger.kernel.org, x86@kernel.org

On Wed, Mar 26, 2014 at 12:10:47PM -0300, Mauro Carvalho Chehab wrote:
> Yet, it would be better if you could be a little more specific about
> what are your plans and what are the common/not-common features that
> you're mapping.

Well, I don't see anything x86-specific in ghes.c on a quick scan - just
the GHES gunk itself, which is the spec. Which begs the question, how
much of the APEI spec is ARM going to implement and if it is a subset,
this definitely needs to be handled cleanly. Judging by your text, it
seems like you want to ignore the correctable errors part...?

So yes, Tomasz, you want to be much more specific here :-)

Thanks.
