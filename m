From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: What is the plan for S3 state support on acpi?
Date: Tue, 26 Nov 2002 16:20:16 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021126152016.GF1989@poup.poupinou.org>
References: <20021126104416.GE1989@poup.poupinou.org> <200211261223.gAQCNu111035@p2.parker.boston.ma.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200211261223.gAQCNu111035-paYRYfI9b/YMuHHiPFXXZ1fOaUvyCJUZ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Brad Parker <brad-2nKKSigPee+ibv+y4V69FXNtEUiqdi9I@public.gmane.org>
Cc: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Nov 26, 2002 at 07:23:56AM -0500, Brad Parker wrote:
> 
> Ducrot Bruno wrote:
> >
> >AFAIK, nobody here plan to incorporate S3 in 2.4 kernel series.
> 
> I've heard this over and over, so I've come to accept it, but I don't
> know or understand why.
> 
> Could someone offer a *detailed* explanation as to why this is so?
> 
> (something more than "it's hard" or "it's not worth doing" or "it
> can't be done")
> 
> It would be a great thing for the FAQ, since it's regularly asked...

Supporting S3 suppose that the kernel have a good understanding
on how to suspend/resume all the devices, and also what is the
correct path from the device tree for suspending, etc. the whole
system.  This is done at this stage only with the 2.5 series.


Well, there is the swsusp patch (and it should be possible, and
even straightforward to have S3 with the help of swsusp), but the
main issue (the devices management) is not well done too under swsusp.

-- 
Ducrot Bruno
http://www.poupinou.org        Page profaissionelle
http://toto.tu-me-saoules.com  Haume page


-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
