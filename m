From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: VGA patch by Bruno Ducrot -- no success yet
Date: Fri, 13 Feb 2004 00:22:30 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040212232230.GC13262@poupinou.org>
References: <m3u11wnflb.fsf@reason.gnu-hamburg> <20040212223706.GA13262@poupinou.org> <m3r7wzx5kb.fsf@reason.gnu-hamburg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <m3r7wzx5kb.fsf-glUV91rXKAHWIjgkaejU9x2eb7JE58TQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Georg C. F. Greve" <greve-mXXj517/zsQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Feb 13, 2004 at 12:04:52AM +0100, Georg C. F. Greve wrote:
>  || On Thu, 12 Feb 2004 23:37:06 +0100
>  || Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org> wrote: 
> 
>  >> cat ./LCDD/brightness
>  >> <not supported>
> 
>  bd> For an LCD device, that not very fun unfortunately :(
> 
> I'm not sure how these relate to each other, but we're talking ASUS
> M2N here, which uses the acpi4asus code, in which
> 
>  /proc/acpi/asus/
>  |-- brn
>  |-- disp
>  |-- info
>  |-- lcd
>  `-- mled
> 
> exist. And therefore
> 
>  /proc/acpi/asus/brn
> 
> normally regulates background display brightness for the LCD, while
> lcd toggles the backlight on/off. Unfortunately both have no effect on
> the dead screen after S3.
> 
> Don't know whether/how this interacts with your code.

Well, then I really need to make one marked 'medium' of the TODO list
which read:
- implement an interface so that external modules can be made, like the
  asus, toshiba specifics.

At least for the asus case.

>  >> cat ./ROM
>  >> <TODO>
> 
>  bd> Well, that need to be done as said, even though in fact that is
>  bd> really uncommon though.
> 
> I know -- just wanted to give you the complete picture. .)

At least it don't oops :)

Thanks,

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
