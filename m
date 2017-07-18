From: Linda Knippers <linda.knippers@hpe.com>
Subject: Re: [PATCH] acpi/apei/erst: Remove "Error" from initialization and
 disable output
Date: Tue, 18 Jul 2017 11:46:11 -0400
Message-ID: <0eb11ba0-4923-5c08-d7a5-1c7a29dbfb20@hpe.com>
References: <1500337283-25734-1-git-send-email-prarit@redhat.com>
 <20170718052627.GA8741@nazgul.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g9t1613g.houston.hpe.com ([15.241.32.99]:50181 "EHLO
        g9t1613g.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751348AbdGRPrM (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 18 Jul 2017 11:47:12 -0400
Received: from g2t2353.austin.hpe.com (g2t2353.austin.hpe.com [15.233.44.26])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by g9t1613g.houston.hpe.com (Postfix) with ESMTPS id 5739A60D01
        for <linux-acpi@vger.kernel.org>; Tue, 18 Jul 2017 15:47:11 +0000 (UTC)
In-Reply-To: <20170718052627.GA8741@nazgul.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@suse.de>, Prarit Bhargava <prarit@redhat.com>
Cc: linux-acpi@vger.kernel.org, Kees Cook <keescook@chromium.org>, Anton Vorontsov <anton@enomsg.org>, Colin Cross <ccross@android.com>, Tony Luck <tony.luck@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, ying.huang@intel.com



On 7/18/2017 1:26 AM, Borislav Petkov wrote:
> On Mon, Jul 17, 2017 at 08:21:23PM -0400, Prarit Bhargava wrote:
>> The word "Error" is used by many QA groups and users as a keyword to
>> indicate that there is a critical failure during system bootup. The ESRT
>> code would interact better with these scripts
>
> ... which is a thinly veiled way of saying: my scripts can't
> differentiate between an error being reported and the word "error" so
> let's "fix" the kernel.
>
> Jeez. Fix your scripts instead.

I'll risk exposing myself to ridicule by agreeing with Prarit.

Most ACPI tables are referenced by their 4 letter abbreviations
anyway so this seems like a simple and helpful change, consistent
with other ACPI table references.

-- ljk
