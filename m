From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: S3 (sort of) success report on desktop
Date: Wed, 21 Sep 2005 12:12:10 +0200
Message-ID: <20050921101208.GB25297@atrey.karlin.mff.cuni.cz>
References: <20050920230511.3cade509@commensaal.drs.p>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20050920230511.3cade509-7SZEXzPdWeU90gtriz95AQ@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Tim Dijkstra <newsuser-TpnWJeB+oO0hKRfeEwdQzg@public.gmane.org>
Cc: ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

> Recently for the first time I succeeded in getting S3 to work on my
> desktop. The specs:
> 
> Motherboard: Asus A7V8X
> Videocard: nVidia RIVA TNT2 model 64
> 
> I need s3_bios,s3_mode. The only problem (so far) is that when
> suspending from the console the monitor stays blank. Suspending from X
> works OK.
> 
> 
> Something different, I have a change for Documentation/power/video.txt
> @@ -69,2 +69,2 @@
> -Acer TM 636Lci			s3_bios vga=normal (2)
> +Acer TM 636Lci			s3_bios,s3_mode (4)
> 
> I think this line came originally from me, I found out (somebody on the 
> list told me, I think) that if I also use s3_mode, I don't have to use 
> vga=normal, but can also use higher resolutions.

Thanks, applied.
							Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
