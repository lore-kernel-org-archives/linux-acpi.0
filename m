From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 5/7] acpi: fix a bunch of style issues on 'actypes.h'
Date: Mon, 19 Oct 2009 17:57:20 +0300
Message-ID: <94a0d4530910190757y139c7e20xe6a58f0cbf13a79d@mail.gmail.com>
References: <1255906474-25091-1-git-send-email-felipe.contreras@gmail.com>
	 <1255906474-25091-6-git-send-email-felipe.contreras@gmail.com>
	 <alpine.LSU.2.00.0910191616290.8582@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.154]:41885 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756514AbZJSO5Q (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 19 Oct 2009 10:57:16 -0400
In-Reply-To: <alpine.LSU.2.00.0910191616290.8582@wotan.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>, Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, linux-acpi@vger.kernel.org

On Mon, Oct 19, 2009 at 5:20 PM, Jiri Kosina <jkosina@suse.cz> wrote:
> On Mon, 19 Oct 2009, Felipe Contreras wrote:
>
>> Many still remain.
>>
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>
> I have never been in favor of merging whitespace-only patches (in a sense
> that the sole purpose of them being to change whitespaces, but no else
> value added).

If somebody tries to send a patch for that file that doesn't fix the
white-space, checkpatch will complain, and people will complain that
checkpatch complains, which is precisely what happened, and I was
requested to write this patch by Daniel Walker (final mail wasn't on
the ml):

http://lkml.org/lkml/2009/9/14/183

> And after today's discussion on kernel summit on this topic, I wouldn't
> expect any maintainer to merge it, sorry :)

What are you talking about?

-- 
Felipe Contreras
