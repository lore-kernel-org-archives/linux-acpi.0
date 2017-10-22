From: Borislav Petkov <bp@suse.de>
Subject: Re: [RESEND PATCH v7] acpi: apei: remove the unused dead-code for
 SEA/NMI notification type
Date: Sun, 22 Oct 2017 12:39:51 +0200
Message-ID: <20171022103951.52oqakwztrhim6nu@pd.tnic>
References: <1508655253-20785-1-git-send-email-gengdongjiu@huawei.com>
 <CAJZ5v0gAGv2XSfvqx7Dyu1w8csUmoJ96wR667WZp4Dq_beyKHw@mail.gmail.com>
 <6438df4f-4b4a-8d83-d76f-9f9cbca84a75@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:48581 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751422AbdJVKkD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 22 Oct 2017 06:40:03 -0400
Content-Disposition: inline
In-Reply-To: <6438df4f-4b4a-8d83-d76f-9f9cbca84a75@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: gengdongjiu <gengdongjiu@huawei.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Tyler Baicar <tbaicar@codeaurora.org>, Will Deacon <will.deacon@arm.com>, Prarit Bhargava <prarit@redhat.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Sun, Oct 22, 2017 at 06:06:10PM +0800, gengdongjiu wrote:
> Thanks a lot Rafael's applying.
> Both for me is OK.

You should never agree if a patch has the SOB chain wrong. It might
sound trivial and not important for your current purposes but proving
the origin of a patch and how it found its way upstream can be critical
sometimes, in legal context.

So please pay more attention to the SOB chain in the future and don't
slap/change tags. They're not there for fun.

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
