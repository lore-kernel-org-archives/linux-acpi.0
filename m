From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: RE: [PATCHv2] Thermal: Fix synchronization issues in thermal_sys.c
Date: Tue, 23 Oct 2012 10:30:16 +0000
Message-ID: <744357E9AAD1214791ACBA4B0B90926324B177@SHSMSX101.ccr.corp.intel.com>
References: <1348727888-11196-1-git-send-email-durgadoss.r@intel.com>
 <CA+icZUXV21BqzAHwPy5gY_VHEws8hXZ8B=vESuPazpmOSQVHvA@mail.gmail.com>
 <CA+icZUWd0s4bo4ASnfryUvSNSk82d5f3-so1RghbOhqHH5UOaw@mail.gmail.com>
 <CA+icZUXo+w8G1ugG+m3YBE-LT7Qb6_Mbo2ijRqRXP1HXLTohGQ@mail.gmail.com>
 <alpine.LSU.2.00.1209271626460.1314@eggly.anvils>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <alpine.LSU.2.00.1209271626460.1314@eggly.anvils>
Content-Language: en-US
Sender: linux-next-owner@vger.kernel.org
To: Hugh Dickins <hughd@google.com>, "lenb@kernel.org" <lenb@kernel.org>
Cc: "R, Durgadoss" <durgadoss.r@intel.com>, Sedat Dilek <sedat.dilek@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>, "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org



> -----Original Message-----
> From: Hugh Dickins [mailto:hughd@google.com]
> Sent: Friday, September 28, 2012 7:48 AM
> To: lenb@kernel.org; Zhang, Rui
> Cc: R, Durgadoss; Sedat Dilek; linux-acpi@vger.kernel.org;
> dan.carpenter@oracle.com; linux-next@vger.kernel.org
> Subject: Re: [PATCHv2] Thermal: Fix synchronization issues in
> thermal_sys.c
> Importance: High
> 
> On Thu, 27 Sep 2012, Sedat Dilek wrote:
> > >>
> > >> The v2 patch does *not* fix the issue here!
> > >>
> > >> [1] https://patchwork.kernel.org/patch/1511961/
> > >>
> > >
> > > I have re-tested with Linux-Next (next-20120927) plus thermal-next
> > > [1] pulled in and see still the same call-trace!
> 
> Same here on mmotm, yes.
> 
> > >
> > > Hugh or Dan can you confirm this works for you or not?
> > > Thanks in advance.
> > >
> > > [1]
> > >
> http://git.kernel.org/?p=linux/kernel/git/rzhang/linux.git;a=shortlo
> > > g;h=refs/heads/next [2]
> > >
> http://git.kernel.org/?p=linux/kernel/git/rzhang/linux.git;a=commitd
> > > iff;h=404b134156bd9d9bc506c0974a1254806e13db2c
> > >
> >
> > With the attached fixup/followup patch, I can boot into my system!
> > But, as said yesterday... working within X, Firefox is a pain in the
> a**.
> 
> Indeed, this works for me too, thanks.
> Let's get your addition out of the attachment and fold it into a v3.
> Mind if we change "synchronization issues" to "oops and unlocking"?
> 
> 
> [PATCHv3] Thermal: Fix oops and unlocking in thermal_sys.c
> 
> This patch fixes the following mutex and NULL pointer problems in
> thermal_sys.c:
> 
>  * mutex_unlock fix in update_temperature function
>  * mutex_unlock fix in bind_cdev function
>  * Correct early return to continue in bind_cdev function
>  * NULL check fix in bind_cdev function
>  * NULL check fix in bind_tz function
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
> Reported-by: Hugh Dickins <hughd@google.com>
> Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
> Signed-off-by: Sedat Dilek <sedat.dilek@gmail.com>
> Signed-off-by: Hugh Dickins <hughd@google.com>

Applied to thermal -next.

Thanks,
Rui

> ---
> v3:
>  * Sedat restored necessary NULL check in bind_cdev and his signoff.
>  * Hugh added two more comments above, his signoff, and Dan's
> 'Reported-by'.
> 
>  drivers/thermal/thermal_sys.c |    9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> --- mmotm/drivers/thermal/thermal_sys.c	2012-09-26 10:15:28.652071362
> -0700
> +++ linux/drivers/thermal/thermal_sys.c	2012-09-27 16:19:14.427515890
> -0700
> @@ -252,8 +252,8 @@ static void bind_cdev(struct thermal_coo
>  		}
> 
>  		tzp = pos->tzp;
> -		if (!tzp->tbp)
> -			return;
> +		if (!tzp || !tzp->tbp)
> +			continue;
> 
>  		for (i = 0; i < tzp->num_tbps; i++) {
>  			if (tzp->tbp[i].cdev || !tzp->tbp[i].match) @@ -289,7
> +289,7 @@ static void bind_tz(struct thermal_zone_
>  		goto exit;
>  	}
> 
> -	if (!tzp->tbp)
> +	if (!tzp || !tzp->tbp)
>  		goto exit;
> 
>  	list_for_each_entry(pos, &thermal_cdev_list, node) { @@ -387,12
> +387,13 @@ static void update_temperature(struct th
>  	ret = tz->ops->get_temp(tz, &temp);
>  	if (ret) {
>  		pr_warn("failed to read out thermal zone %d\n", tz->id);
> -		return;
> +		goto exit;
>  	}
> 
>  	tz->last_temperature = tz->temperature;
>  	tz->temperature = temp;
> 
> +exit:
>  	mutex_unlock(&tz->lock);
>  }
> 
