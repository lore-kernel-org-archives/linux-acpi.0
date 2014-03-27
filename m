From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Subject: Re: RFC: APEI hardware reduced profile
Date: Thu, 27 Mar 2014 10:17:56 +0100
Message-ID: <5333ECC4.5080208@linaro.org>
References: <5332C32A.5070301@linaro.org> <6220935.TPfvPdvLIs@vostro.rjw.lan> <20140326121047.65176d7e@samsung.com> <20140326203650.GA3933@nazgul.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ee0-f53.google.com ([74.125.83.53]:59454 "EHLO
	mail-ee0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753406AbaC0JR5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 27 Mar 2014 05:17:57 -0400
Received: by mail-ee0-f53.google.com with SMTP id b57so2593850eek.12
        for <linux-acpi@vger.kernel.org>; Thu, 27 Mar 2014 02:17:55 -0700 (PDT)
In-Reply-To: <20140326203650.GA3933@nazgul.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>, Mauro Carvalho Chehab <m.chehab@samsung.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linaro-acpi <linaro-acpi@lists.linaro.org>, Tony <tony.luck@intel.com>, Borislav Petkov <bp@suse.de>, linux-edac@vger.kernel.org, x86@kernel.org

On 03/26/14 21:36, Borislav Petkov wrote:
> On Wed, Mar 26, 2014 at 12:10:47PM -0300, Mauro Carvalho Chehab wrote:
>> Yet, it would be better if you could be a little more specific about
>> what are your plans and what are the common/not-common features that
>> you're mapping.
>
> Well, I don't see anything x86-specific in ghes.c on a quick scan - just
> the GHES gunk itself, which is the spec. Which begs the question, how
> much of the APEI spec is ARM going to implement and if it is a subset,
> this definitely needs to be handled cleanly. Judging by your text, it
> seems like you want to ignore the correctable errors part...?
>
> So yes, Tomasz, you want to be much more specific here :-)

Thanks for your comment. Please refer to my email to Mauro. I have put 
more explanation there.

Correctable errors are fine for ARM. But ARM is not going to have NMI 
ever. So as responded to Mauro, I am focusing on making NMI as the 
feature for ghes.c.

Thanks,
Tomasz
