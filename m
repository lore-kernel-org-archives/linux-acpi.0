From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 4/5][RFC] cpuidle : use per cpuidle device cpu states
Date: Thu, 26 Jul 2012 17:41:52 +0200
Message-ID: <CAMQu2gxPmjf1k3wj+JNxkEuFavgtd9nG+eWAgiWMUZZkGV25kA@mail.gmail.com>
References: <1343213162-8064-1-git-send-email-daniel.lezcano@linaro.org> <1343213162-8064-5-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from na3sys009aog138.obsmtp.com ([74.125.149.19]:50784 "EHLO
	na3sys009aog138.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751104Ab2GZPmV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 26 Jul 2012 11:42:21 -0400
Received: by yhr47 with SMTP id 47so2576771yhr.14
        for <linux-acpi@vger.kernel.org>; Thu, 26 Jul 2012 08:42:12 -0700 (PDT)
In-Reply-To: <1343213162-8064-5-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, linaro-dev@lists.linaro.org

On Wed, Jul 25, 2012 at 12:46 PM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
> We have the cpuidle states pointer stored in the cpuidle device
> structure. This patch use this pointer instead of the driver's one.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
Sorry for another comment on change log. Would be give a reference
about the commit which removed the feature(was present before), and
also some examples like say big.LITTLE, Tegra arch which needs the
per CPU latency tables.

Regards
Santosh
