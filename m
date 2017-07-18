From: Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH] acpi/apei/erst: Remove "Error" from initialization and
 disable output
Date: Tue, 18 Jul 2017 07:26:27 +0200
Message-ID: <20170718052627.GA8741@nazgul.tnic>
References: <1500337283-25734-1-git-send-email-prarit@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:51285 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751189AbdGRF0m (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 18 Jul 2017 01:26:42 -0400
Content-Disposition: inline
In-Reply-To: <1500337283-25734-1-git-send-email-prarit@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>
Cc: linux-acpi@vger.kernel.org, Kees Cook <keescook@chromium.org>, Anton Vorontsov <anton@enomsg.org>, Colin Cross <ccross@android.com>, Tony Luck <tony.luck@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, ying.huang@intel.com

On Mon, Jul 17, 2017 at 08:21:23PM -0400, Prarit Bhargava wrote:
> The word "Error" is used by many QA groups and users as a keyword to
> indicate that there is a critical failure during system bootup. The ESRT
> code would interact better with these scripts

... which is a thinly veiled way of saying: my scripts can't
differentiate between an error being reported and the word "error" so
let's "fix" the kernel.

Jeez. Fix your scripts instead.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
