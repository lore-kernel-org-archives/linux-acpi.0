From: Duncan Gibb <duncan-h9eRTumTmmZjMu4AB9qoK9F8XQ1HzYRO@public.gmane.org>
Subject: Bios Override
Date: 15 Nov 2002 19:37:57 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1037389077.7281.56.camel@carwash.duncangibb.com>
References: <20021115161550.64132.qmail@web41108.mail.yahoo.com>
	<20021115174003.GA27427@poup.poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20021115174003.GA27427-j6u/t2rXLliUoIHC/UFpr9i2O/JbrIOy@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, 2002-11-15 at 17:40, Ducrot Bruno wrote:

KH> Does anyone have instructions on DSDT override
KH> for the new 20021111 acpi?

I've not been here very long, and maybe I'm being naive, but if
overriding the BIOS DSDT is something that quite a few people will have
to do quite often, wouldn't it be worth maintaining the means to do so
in the main codebase?

Certainly it seems easy for people to get confused by having half a
dozen patches and a variety of contributers providing home-baked DSDTs
for whatever hardware they happen to have.

I know the Right Answer is for the hardware manufacturers to provide
non-broken DSDTs in the first place, but given how long that'll take,
shouldn't there be a library of fixes?

I'm guessing there would be a problem mingling stuff produced by
unauthorised reverse-engineering with the kernel code proper.


Duncan




-------------------------------------------------------
This sf.net email is sponsored by: To learn the basics of securing 
your web site with SSL, click here to get a FREE TRIAL of a Thawte 
Server Certificate: http://www.gothawte.com/rd524.html
