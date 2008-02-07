From: Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH][drivers/misc/thinkpad_acpi.c]
	duplicate test if (level & TP_EC_FAN_FULLSPEED)
Date: Thu, 7 Feb 2008 01:17:44 -0500
Message-ID: <200802070117.45119.lenb@kernel.org>
References: <47A78CBB.2090401@tiscali.nl> <ada8x20gykq.fsf@cisco.com>
	<47A79EC8.6060700@tiscali.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <47A79EC8.6060700-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Roel Kluin <12o3l-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>
Cc: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Roland Dreier <rdreier-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>, ibm-acpi-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Applied.

thanks,
-Len

On Monday 04 February 2008 18:24, Roel Kluin wrote:
> Roland Dreier wrote:
> >  >                 /* safety net should the EC not support AUTO
> >  >                  * or FULLSPEED mode bits and just ignore them */
> >  >                 if (level & TP_EC_FAN_FULLSPEED)
> >  >                         level |= 7;     /* safety min speed 7 */
> >  >                 else if (level & TP_EC_FAN_FULLSPEED)
> >  >                         level |= 4;     /* safety min speed 4 */
> >  > 
> >  > Note the duplicate test 'if (level & TP_EC_FAN_FULLSPEED)'. should
> >  > this be replaced by
> > 
> > Actually I suspect one of the two tests should be against TP_EC_FAN_AUTO
> > (based on the comment).
> > 
> 
> Thanks Roland, for your info
> 
> based on the comments in commit eaa7571b2d1a08873e4bdd8e6db3431df61cd9ad,
> I think this should be modified like below:
> 
> ACPI: thinkpad-acpi: add a safety net for TPEC fan control mode
> The Linux ThinkPad community is not positive that all ThinkPads that do
> HFSP EC fan control do implement full-speed and auto modes, some of the
> earlier ones supporting HFSP might not.
> 
> If the EC ignores the AUTO or FULL-SPEED bits, it will pay attention to the
> lower three bits that set the fan level. And as thinkpad-acpi was leaving
> these set to zero, it would stop(!) the fan, which is Not A Good Thing.
> So, as a safety net, we now make sure to also set the fan level part of the
> HFSP register to speed 7 for full-speed, and a minimum of speed 4 for auto
> mode.
> --
> second TP_EC_FAN_FULLSPEED should be P_EC_FAN_AUTO
> 
> 
> Signed-off-by: Roel Kluin <12o3l-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>
> ---
> diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
> index cf56647..3c323fe 100644
> --- a/drivers/misc/thinkpad_acpi.c
> +++ b/drivers/misc/thinkpad_acpi.c
> @@ -4138,7 +4138,7 @@ static int fan_set_level(int level)
>  		 * or FULLSPEED mode bits and just ignore them */
>  		if (level & TP_EC_FAN_FULLSPEED)
>  			level |= 7;	/* safety min speed 7 */
> -		else if (level & TP_EC_FAN_FULLSPEED)
> +		else if (level & TP_EC_FAN_AUTO)
>  			level |= 4;	/* safety min speed 4 */
>  
>  		if (!acpi_ec_write(fan_status_offset, level))
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
