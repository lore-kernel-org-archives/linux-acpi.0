From: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Subject: Re: S3 test tool (was : Re: Bizarre oops after suspend to
	RAM (was: Re: Resume from Suspend to RAM))
Date: Thu, 09 Jun 2005 18:51:43 +0100
Message-ID: <1118339503.6648.322.camel@tyrosine>
References: <200506061531.41132.stefandoesinger@gmx.at>
	 <1118125410.3828.12.camel@linux-hp.sh.intel.com>
	 <20050607120727.GA6077@deprecation.cyrius.com>
	 <20050609115134.GA31903@message-id.gmane0305.slipkontur.de>
	 <1118327939.12491.44.camel@elrond.flymine.org>
	 <20050609152943.GA3334@message-id.s3e.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050609152943.GA3334-l0tNAEGuAhiXoBlonBaIS7NAH6kLmebB@public.gmane.org>
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

On Thu, 2005-06-09 at 17:29 +0200, Stefan Seyfried wrote:

> My hint was for Martin only, sorry for not being more clear ;-)

Heh. Sorry, I've been working with Martin on this, so it gets a bit
confusing :)

> If you can see a yellow "Linu" on the screen, chances are good that
> "acpi_sleep=s3_mode" fixes the remaining problems.

That's only with the test patch that doesn't actually suspend the
machine. If it's properly suspended, it doesn't get that far.

-- 
Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
