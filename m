From: Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH V3] acpi:apei:handle GSIV and GPIO notification types
Date: Thu, 20 Apr 2017 00:00:28 +0200
Message-ID: <20170419220027.ug3fkwbthvkkkohf@pd.tnic>
References: <86258A5CC0A3704780874CF6004BA8A62E695201@FRAEML521-MBX.china.huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:48508 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1764848AbdDSWAs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 19 Apr 2017 18:00:48 -0400
Content-Disposition: inline
In-Reply-To: <86258A5CC0A3704780874CF6004BA8A62E695201@FRAEML521-MBX.china.huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shiju Jose <shiju.jose@huawei.com>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "lenb@kernel.org" <lenb@kernel.org>, "mingo@kernel.org" <mingo@kernel.org>, "prarit@redhat.com" <prarit@redhat.com>, "tbaicar@codeaurora.org" <tbaicar@codeaurora.org>, "punit.agrawal@arm.com" <punit.agrawal@arm.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "james.morse@arm.com" <james.morse@arm.com>, "fu.wei@linaro.org" <fu.wei@linaro.org>, "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>, Gabriele Paoloni <gabriele.paoloni@huawei.com>, John Garry <john.garry@huawei.com>, "xuwei (O)" <xuwei5@hisilicon.com>, "Zhengqiang (turing)" <zhengqiang10@huawei.com>

On Wed, Apr 19, 2017 at 12:03:51PM +0000, Shiju Jose wrote:
> System Controller Interrupts are received by ACPI's error device,
> which in turn notifies the GHES code. The same is true of
> APEI's GSIV and GPIO notification types.
> Add support for GSIV and GPIO sharing the SCI
> register/unregister/notifier code.Rename the list and notifier
> to show this is no longer just SCI, but anything from the
> Hardware Error Device.
> 
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> [james.morse@arm.com: rewrote commit log]
> Signed-off-by: James Morse <james.morse@arm.com>
> CC: James Morse <james.morse@arm.com>
> CC: Hanjun Guo <guohanjun@huawei.com>
> Reviewed-by: James Morse <james.morse@arm.com>
> ---
>  drivers/acpi/apei/ghes.c | 40 ++++++++++++++++++++++++++--------------
>  1 file changed, 26 insertions(+), 14 deletions(-)

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
