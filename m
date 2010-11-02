From: ykzhao <yakui.zhao@intel.com>
Subject: Re: [Intel-gfx] [PATCH 4/4] cpuidle: Hack iowait weighting to
	avoid C-state reduction for graphics.
Date: Tue, 02 Nov 2010 20:20:14 +0800
Message-ID: <1288700414.26046.18.camel@localhost.localdomain>
References: <1288643024-5706-1-git-send-email-eric@anholt.net>
	 <1288643024-5706-5-git-send-email-eric@anholt.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:37908 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750872Ab0KBMZ0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 2 Nov 2010 08:25:26 -0400
In-Reply-To: <1288643024-5706-5-git-send-email-eric@anholt.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Eric Anholt <eric@anholt.net>
Cc: "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, arjan@linxu.intel.com, linux-acpi@vger.kernel.org

On Tue, 2010-11-02 at 04:23 +0800, Eric Anholt wrote:
> Improves nexuiz performance by about 1% on my system.

CC: Arjan and linux-acpi mailing list.

It seems that the selection of C-state will become very sensitive to IO
wait after the multi factor is changed from 10 to 1000.
Maybe only one IO/wait will bring that the system can't enter the deep
C-state.
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
>  drivers/cpuidle/governors/menu.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
> index f508690..9bb5654 100644
> --- a/drivers/cpuidle/governors/menu.c
> +++ b/drivers/cpuidle/governors/menu.c
> @@ -175,7 +175,7 @@ static inline int performance_multiplier(void)
>  	mult += 2 * get_loadavg();
>  
>  	/* for IO wait tasks (per cpu!) we add 5x each */
> -	mult += 10 * nr_iowait_cpu(smp_processor_id());
> +	mult += 1000 * nr_iowait_cpu(smp_processor_id());
>  
>  	return mult;
>  }

