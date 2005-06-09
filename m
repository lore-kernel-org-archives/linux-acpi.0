From: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Subject: Re: S3 test tool (was : Re: Bizarre oops after suspend to
	RAM (was: Re: Resume from Suspend to RAM))
Date: Thu, 09 Jun 2005 15:38:59 +0100
Message-ID: <1118327939.12491.44.camel@elrond.flymine.org>
References: <200506061531.41132.stefandoesinger@gmx.at>
	 <1118125410.3828.12.camel@linux-hp.sh.intel.com>
	 <20050607120727.GA6077@deprecation.cyrius.com>
	 <20050609115134.GA31903@message-id.gmane0305.slipkontur.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050609115134.GA31903-l0tNAEGuAhhzZ8+rp42Dbp9+tswZ0GTaehPwdyo5hKaELgA04lAiVw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, 2005-06-09 at 13:51 +0200, Stefan Seyfried wrote:
> On Tue, Jun 07, 2005 at 01:07:27PM +0100, Martin Michlmayr wrote:

> > This works on a HP Compaq nc4000 which previously never comes back
> > from resume (except for one time in which case the kernel oopsed in a
> > strange way, as posted by Matthew the other day).  I see a yellow
> > 'Linu' on the screen, then I hear the hard drive spinning up, the
> 
> try "acpi_sleep=s3_mode" or no framebuffer (vga=normal) and you should
> get your display back.

No, the machine fails to resume for entirely different reasons. It
almost sounds as if the memory isn't being set to self refresh when S3
is entered. Is it possible that a northbridge register needs to be set
to enable this? (It's an ATI northbridge)

-- 
Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
