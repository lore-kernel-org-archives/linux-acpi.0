From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 01/14] x86, ACPI, mm: Kill max_low_pfn_mapped
Date: Thu, 7 Mar 2013 21:10:59 -0800
Message-ID: <20130308051059.GC14556@mtj.dyndns.org>
References: <1362718720-27048-1-git-send-email-yinghai@kernel.org>
	<1362718720-27048-2-git-send-email-yinghai@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <1362718720-27048-2-git-send-email-yinghai@kernel.org>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org
Errors-To: dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, Ingo Molnar <mingo@elte.hu>, Jacob Shin <jacob.shin@amd.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Tang Chen <tangchen@cn.fujitsu.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Thomas Renninger <trenn@suse.de>
List-Id: linux-acpi@vger.kernel.org

On Thu, Mar 07, 2013 at 08:58:27PM -0800, Yinghai Lu wrote:
> diff --git a/drivers/gpu/drm/i915/i915_gem_stolen.c b/drivers/gpu/drm/i915/i915_gem_stolen.c
> index 69d97cb..7f9380b 100644
> --- a/drivers/gpu/drm/i915/i915_gem_stolen.c
> +++ b/drivers/gpu/drm/i915/i915_gem_stolen.c
> @@ -81,7 +81,7 @@ static unsigned long i915_stolen_to_physical(struct drm_device *dev)
>  		base -= dev_priv->mm.gtt->stolen_size;
>  	} else {
>  		/* Stolen is immediately above Top of Memory */
> -		base = max_low_pfn_mapped << PAGE_SHIFT;
> +		base = __REMOVED_CRAZY__ << PAGE_SHIFT;

Huh?

-- 
tejun
