From: Tim Dijkstra <newsuser-TpnWJeB+oO0hKRfeEwdQzg@public.gmane.org>
Subject: Re: Should battery generate events?
Date: Thu, 7 Oct 2004 21:06:46 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20041007210646.1d31e32e@commensaal.drs.p>
References: <20041004232557.6c342288@commensaal.drs.p>
	<Pine.LNX.4.60.0410051614420.3936@frog.athome>
	<20041005204929.647d25c9@commensaal.drs.p>
	<Pine.LNX.4.60.0410052308181.5157@frog.athome>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.60.0410052308181.5157-KnfdeQs3A3X/9pzu0YdTqQ@public.gmane.org>
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

On Tue, 5 Oct 2004 23:20:22 +0200 (CEST)
liste-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Salut Tim,
> On Tue, 5 Oct 2004, Tim Dijkstra wrote:
> > On Tue, 5 Oct 2004 16:25:58 +0200 (CEST)
> > It does show the correct state while discharging, so that's not the
> > problem.
> Sorry, but I doubt that, or you do not have the latest BIOS - and the 
> introduced this later. The DSDT from r01c0O-BIOS for TM 63x does
> allways say, that the "present-rate" is unknown.

Ah, yes present rate is always unknown, but what seemed more important
to me is 'remaining capacity', that does represents a usefull value.
Also the ACPI spec says that the battery/bios could signal that the
battery is almost empty by generating an event if capacity goes under a
certain value (see other mail from me in this thread).

grts TIm


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
