From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Problem with Compaq Evo N110
Date: Thu, 22 Aug 2002 16:23:51 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020822142351.GC24939@poup.poupinou.org>
References: <5.1.0.14.2.20020822145413.00aa39f0@mail.olografix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5.1.0.14.2.20020822145413.00aa39f0-bEMAEpuhR655giDkELQJ8R2eb7JE58TQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: SLIVER <sliver-qqXEv8jiLWqhPH1hqNUYSQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi, Lucas.

On Thu, Aug 22, 2002 at 03:28:24PM +0200, SLIVER wrote:
> Hello.
> I have a problem to work ACPI on my laptop because the pc doesn't find the 
> battery and other device
> You can download my stuffs at http://nirvana.cuore.org/acpi/ (the dump 
> obtained with pmtools and other information)
> My laptop is Compaq Evo N110 with Slackware Linux 2.4.18 + latest kernel 
> patch (pentium Celeron)
> you can help me? :D
> 
> Thanks for the support :)
>

It seems that, at the read of your dmesg, your DSDT has the (in)famous
bug 'Scope(_SB)' somewhere instead of 'Scope(\_SB)'.

Could you please put in your web site the content of:

./acpidump DSDT > the_dstdt (or any name you choose)

It could help me in order to fix at least this bug.

Cheers,

-- 
Ducrot Bruno
http://www.poupinou.org        Page profaissionelle
http://toto.tu-me-saoules.com  Haume page


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
