From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: acpi.sf.net: place pmtools in downloads?
Date: Mon, 17 Mar 2003 14:58:23 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030317135823.GG8319@poup.poupinou.org>
References: <20030313183945.GA1419@elf.ucw.cz> <20030315181225.GA28108@enigma.daemon.sh> <20030315204835.GA19904@atrey.karlin.mff.cuni.cz> <20030316132246.GA10259@enigma.daemon.sh>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030316132246.GA10259-adzhR0EPeY/7X6WiDY61Ug@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Sebastian Henschel <shensche-1rjuZeEg9oEb1SvskN2V4Q@public.gmane.org>
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Sun, Mar 16, 2003 at 02:22:46PM +0100, Sebastian Henschel wrote:
> rehi..
> 
> Received at 2003-03-16 / 13:31 by Pavel Machek:
> > 
> > > > I spend quite a lot of time searching for pmtools. perhaps they are
> > > > worth link from Downloads section?
> > > 
> > > do you mean the tools from
> > > http://developer.intel.com/technology/iapc/acpi/downloads/pmtools-20010730.tar.gz
> > > ?
> > > 
> > > are they directly related to the sourceforge project?
> > > currently you get the link by going to
> > > links->intel:useful tools->search on intel page.
> > > or are they really important enuff to be shown on the download page?
> > > no pun intended, i just do not know. :)
> > 
> > I think they are: when something goes wrong, first thing you need is
> > acpi disassembler... And that's in pmtools.

iasl -h = give help.
iasl -d = disassemble.
iasl -g = retrieve ACPI tables and write them to .dat files.

For now, pmtools is still needed for me, but only for the acpitbl perl
script...

Cheers,

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
