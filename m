From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: ACPI in kernel 2.5.68 works better (for me) than 2.5.69
Date: Tue, 6 May 2003 13:20:53 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030506112053.GO2954@poup.poupinou.org>
References: <1052180986.1005.3.camel@chevrolet.hybel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1052180986.1005.3.camel-rd0e0RNjLLRX8BKYUJ5quQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Stian Jordet <liste-NI9zH3lwcMKHXe+LvDLADg@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, May 06, 2003 at 02:29:46AM +0200, Stian Jordet wrote:
> Hi,
> 
> Since kernel 2.5.69, usb no longer work with acpi on my computer. With
> 2.5.68 it did. Do you know what changes you have done might cause this?
> 
> I get this error, but this one is with both .68 and .69.
> 
> ACPI-0109: *** Error: No object was returned from
> [\_SB_.PCI0.PX40.IRDA._STA] (Node dff5cc80), AE_NOT_EXIST

A pointer to your DSDT will be appreciate...

> This is a Asus CUV266-DLS smp motherboard, and thus I need acpi to power
> it off, and it would have been very, very much apprpeciated if this
> somehow could be fixed before 2.6, atleast. I don't want to be running
> 2.5.68 for ever :)
> 


Stupid question: does USB work without ACPI?

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
