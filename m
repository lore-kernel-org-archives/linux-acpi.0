From: Adam Belay <abelay@novell.com>
Subject: Re: [-mm patch] make "struct menu_governor" static (again)
Date: Mon, 27 Aug 2007 18:32:56 -0400
Message-ID: <1188253976.3929.5.camel@callisto.site>
References: <20070822020648.5ea3a612.akpm@linux-foundation.org>
	 <20070827212703.GI4121@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S965051AbXH0WkG@vger.kernel.org>
In-Reply-To: <20070827212703.GI4121@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Bunk <bunk@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>, Shaohua Li <shaohua.li@intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Brown@vger.kernel.org, Len <len.brown@intel.com>
List-Id: linux-acpi@vger.kernel.org

This is already fixed in the most recent ACPI CPUIDLE tree.

Thanks,
Adam

On Mon, 2007-08-27 at 23:27 +0200, Adrian Bunk wrote:
> On Wed, Aug 22, 2007 at 02:06:48AM -0700, Andrew Morton wrote:
> >...
> > Changes since 2.6.23-rc2-mm2:
> >...
> >  git-acpi.patch
> >...
> >  git trees
> >...
> 
> "struct menu_governor" needlessly again became global.
> 
> Signed-off-by: Adrian Bunk <bunk@kernel.org>
> 
> ---
> cb33b296204127cf50df54b84b2d79e152fb924b 
> diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
> index f5a8865..8d3fdc5 100644
> --- a/drivers/cpuidle/governors/menu.c
> +++ b/drivers/cpuidle/governors/menu.c
> @@ -117,7 +117,7 @@ static int menu_enable_device(struct cpuidle_device *dev)
>  	return 0;
>  }
>  
> -struct cpuidle_governor menu_governor = {
> +static struct cpuidle_governor menu_governor = {
>  	.name =		"menu",
>  	.rating =	20,
>  	.enable =	menu_enable_device,
> 
