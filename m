From: Jens Axboe <axboe-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [ACPI Debug] String: Length 0x0F, "Entering RTMP()"
Date: Wed, 15 Sep 2004 08:06:15 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040915060615.GB2304@suse.de>
References: <20040914061641.GD2336@suse.de> <1095197368.5430.8.camel@d845pe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1095197368.5430.8.camel@d845pe>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Sep 14 2004, Len Brown wrote:
> On Tue, 2004-09-14 at 02:16, Jens Axboe wrote:
> > Hi,
> > 
> > 2.6.9-rc2 is throwing a lot of these errors on my system:
> > 
> > [ACPI Debug] String: Length 0x0F, "Entering RTMP()"
> > [ACPI Debug] String: Length 0x0F, "Entering TIN2()"
> > [ACPI Debug] String: Length 0x0F, "Existing RTMP()"
> > 
> > About 450 of these three lines repeated so far, seem to get one every
> > 5
> > seconds or so. Box is an Athlon64 solo, let me know if you want more
> > info (and what).
> > 
> > --
> > Jens Axboe
> 
> These are due to debug statements in your BIOS AML code.
> The Linux AML interpreter recognizes them and sends
> them to the console.
> 
> Start by checking that you're running a production BIOS.

I'm not

> echo 0 >/proc/acpi/debug_level should make them go away.

Ah thanks, yes that works!

-- 
Jens Axboe



-------------------------------------------------------
This SF.Net email is sponsored by: thawte's Crypto Challenge Vl
Crack the code and win a Sony DCRHC40 MiniDV Digital Handycam
Camcorder. More prizes in the weekly Lunch Hour Challenge.
Sign up NOW http://ad.doubleclick.net/clk;10740251;10262165;m
