From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Bios Override
Date: Sat, 16 Nov 2002 14:55:10 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021116135510.GC691@poup.poupinou.org>
References: <20021115161550.64132.qmail@web41108.mail.yahoo.com> <20021115174003.GA27427@poup.poupinou.org> <1037389077.7281.56.camel@carwash.duncangibb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1037389077.7281.56.camel-h9eRTumTmmZjMu4AB9qoK9F8XQ1HzYRO@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Duncan Gibb <duncan-h9eRTumTmmZjMu4AB9qoK9F8XQ1HzYRO@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Nov 15, 2002 at 07:37:57PM +0000, Duncan Gibb wrote:
> On Fri, 2002-11-15 at 17:40, Ducrot Bruno wrote:
> 
> KH> Does anyone have instructions on DSDT override
> KH> for the new 20021111 acpi?
> 
> I've not been here very long, and maybe I'm being naive, but if
> overriding the BIOS DSDT is something that quite a few people will have
> to do quite often, wouldn't it be worth maintaining the means to do so
> in the main codebase?

Yes.  But it require really more work to do.

> Certainly it seems easy for people to get confused by having half a
> dozen patches and a variety of contributers providing home-baked DSDTs
> for whatever hardware they happen to have.
> 
> I know the Right Answer is for the hardware manufacturers to provide
> non-broken DSDTs in the first place, but given how long that'll take,
> shouldn't there be a library of fixes?
> 
> I'm guessing there would be a problem mingling stuff produced by
> unauthorised reverse-engineering with the kernel code proper.

I am not a lawyer, but I guess that we have the right to replace
a dsdt by another one, no?

-- 
Ducrot Bruno
http://www.poupinou.org        Page profaissionelle
http://toto.tu-me-saoules.com  Haume page


-------------------------------------------------------
This sf.net email is sponsored by: To learn the basics of securing 
your web site with SSL, click here to get a FREE TRIAL of a Thawte 
Server Certificate: http://www.gothawte.com/rd524.html
