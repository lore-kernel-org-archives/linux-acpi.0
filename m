From: Markus Gaugusch <markus-z+rTbpWsRgbk7+2FdBfRIA@public.gmane.org>
Subject: Re: performance problems?
Date: Tue, 19 Nov 2002 15:54:01 +0100 (CET)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.44.0211191552030.31104-100000@dynast.gaugusch.at>
References: <3DDA42A3.35F6BFE1@gatwick.westerngeco.slb.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3DDA42A3.35F6BFE1-BNG0eM9rGRi0IRkH3yUr9EW4647UYGdYQQ4Iyu8u01E@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI-Devel <Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Nov 19, Loic Jaquemet <ljaquemet-BNG0eM9rGRi0IRkH3yUr9EW4647UYGdYQQ4Iyu8u01E@public.gmane.org> wrote:
> i'am using 2.4.19 + around october patch ( I'll check that this evening )
> on sony vaio fx502
> [...]
> when I fetch the /proc/acpi/<batteriesxxx>/state|info files, I get a 1-2
> second freeze| lag ..
> [...]
> I'm not sure, but i think i didn't have this problem on pre-september
> patches ..
No, it has been present before. I have an FX405 and can't use any battery
monitor applet that reads the info file. Even a 'cat
/proc/acpi/battery/BAT1/info' causes a noticable peak in my cpu monitor
(kernel time). At least, it doesn't freeze keyboard anymore, thanks to the
ACPI people!

Markus
-- 
__________________    /"\
Markus Gaugusch       \ /    ASCII Ribbon Campaign
markus-z+rTbpWsRgbk7+2FdBfRIA@public.gmane.org     X     Against HTML Mail
                      / \



-------------------------------------------------------
This sf.net email is sponsored by: To learn the basics of securing 
your web site with SSL, click here to get a FREE TRIAL of a Thawte 
Server Certificate: http://www.gothawte.com/rd524.html
