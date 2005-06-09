From: Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>
Subject: Re: S3 test tool (was : Re: Bizarre oops after suspend to RAM (was: Re: Resume from Suspend to RAM))
Date: Thu, 9 Jun 2005 17:29:43 +0200
Message-ID: <20050609152943.GA3334@message-id.s3e.de>
References: <200506061531.41132.stefandoesinger@gmx.at> <1118125410.3828.12.camel@linux-hp.sh.intel.com> <20050607120727.GA6077@deprecation.cyrius.com> <20050609115134.GA31903@message-id.gmane0305.slipkontur.de> <1118327939.12491.44.camel@elrond.flymine.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1118327939.12491.44.camel-Xmbc1Sz64/5pghhO6/9/sx2eb7JE58TQ@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Jun 09, 2005 at 03:38:59PM +0100, Matthew Garrett wrote:
> On Thu, 2005-06-09 at 13:51 +0200, Stefan Seyfried wrote:
> > On Tue, Jun 07, 2005 at 01:07:27PM +0100, Martin Michlmayr wrote:
> > > strange way, as posted by Matthew the other day).  I see a yellow
> > > 'Linu' on the screen, then I hear the hard drive spinning up, the
> > 
> > try "acpi_sleep=s3_mode" or no framebuffer (vga=normal) and you should
> > get your display back.
> 
> No, the machine fails to resume for entirely different reasons. It
> alm machine fails to resume for entirely different reasons. It

My hint was for Martin only, sorry for not being more clear ;-)

If you can see a yellow "Linu" on the screen, chances are good that
"acpi_sleep=s3_mode" fixes the remaining problems.

> almost sounds as if the memory isn't being set to self refresh when S3
> is entered. Is it possible that a northbridge register needs to be set
> to enable this?

To be honest: i have no idea.
-- 
Stefan Seyfried


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
