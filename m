From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: ACPI and APM
Date: Mon, 26 Aug 2002 11:20:01 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020826092001.GF27762@poup.poupinou.org>
References: <20020824192026.0e4811bf.valvoline@tiscalinet.it> <Pine.LNX.4.44.0208241801180.18729-100000@corsa.pop-pr.rnp.br> <20020825120034.4f3ce5b4.valvoline@tiscalinet.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20020825120034.4f3ce5b4.valvoline-KGm45+8e4WzOeuqD6ShaSA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: valvoline <valvoline-KGm45+8e4WzOeuqD6ShaSA@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sun, Aug 25, 2002 at 12:00:34PM +0200, valvoline wrote:
> On Sat, 24 Aug 2002 18:12:58 -0300 (BRT)
> Christian Lyra <lyra-kkgK+NGu78pV51zT55DYLA@public.gmane.org> wrote:
> 
> 
> 
> > 	I would sugest that you didnt disable button flags in ACPI, and
> > just create a script that on a button event generated from ACPI to just
> > call apm -s (I think APM doesnt understand the Lid Button).
> 
> It's a great idea! :)...i'll try as soon as possible, and i'll send you
> my feedback.
> 
> > to test your hack/patch. May you sent me a patch or the guidelines so I
> > can test it too?
> 
> you can download the patch from this url:
> 
> http://www.vrlteam.org/patch-apm_acpi_010.tgz
> 

Some day, I will resend the S4BIOS patch, but for now I am a little busy :)

It add the suspend to disk via a similar method as for APM, but with more
ACPI compatible way, I think.

-- 
Ducrot Bruno
http://www.poupinou.org        Page profaissionelle
http://toto.tu-me-saoules.com  Haume page


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
