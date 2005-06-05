From: Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>
Subject: Re: acer aspire 3000 after a week.  ACPI report.
Date: Sun, 5 Jun 2005 20:16:13 +0200
Message-ID: <20050605181613.GA24335@message-id.gmane0305.slipkontur.de>
References: <1117244104.21648.1.camel@localhost.localdomain> <20050528101450.GA19354@fingerbrecher> <1117397912.24721.5.camel@localhost.localdomain> <1117956090.18789.16.camel@localhost.localdomain> <1117960258.19210.0.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1117960258.19210.0.camel-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sun, Jun 05, 2005 at 01:30:58AM -0700, James Sparenberg wrote:

> > So my question is should  0x0BEFADE4  be changed to 0x0BF395E4  or
> > should I go all the way (My max ram is 2G on this box) 0x7754D7E4  so
> > that in the future I don't have to adjust, or is it likely that I would
> > be best off adjusting it to match ram.  
> > 
> > The other chance... is that I'm so totally off base I'm lost *grin*
> > 
> > James
> 
> Forget what I said above.... testing shows I'm wtfo....  back to the
> drawing board.

Assuming you have a diff of the "originial" and the "fixed" DSDT, just
apply this diff to the "broken" DSDT you get from BIOS after upgrading
the RAM. The BIOS changes values in the DSDT depending on BIOS settings,
RAM size etc.pp and you always have to adopt your patched DSDT to those
changed settings. This is why it is such a pain in the ass when vendors
ship broken DSDTs: it is not a "fix it once and for all" but a "fix it
everytime you change your setup" scenario :-(

At least this is how i understood the issue.
Good luck.
-- 
Stefan Seyfried



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
