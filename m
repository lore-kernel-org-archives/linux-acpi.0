From: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>
Subject: Re: C2/C3 don't do anything
Date: Sat, 5 Feb 2005 08:39:21 +0100
Message-ID: <20050205073921.GD8019@dominikbrodowski.de>
References: <20050203034639.GA29164@atomide.com> <20050204203026.GA8049@dominikbrodowski.de> <20050204213407.GA26515@hell.org.pl> <20050204225527.GA30585@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050204225527.GA30585-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Feb 04, 2005 at 02:55:28PM -0800, Tony Lindgren wrote:
> > > > Should we have some extra code to scan the southbridges,
> > > 
> > > Definitely. There is already some "errata" handling in the processor module,
> > > possibly this could get extended.
> > 
> > I'm still using the patch to enable C3 on ICHx-M I once posted. Basically,
> > it provided a valid PM2_CNT_BLK address in case the OEM had forgotten to do
> > that, which in turn enabled C3 by providing a valid ARB_DIS address
> > (provided P_LVL3_LAT is valid).
> 
> I have some code for the amd76x_pm module that can be modified for
> scanning various southbridges. And then add functions for the
> to enable them. I don't know when I'll have time to play with that
> though.
> 
> This could be a separate module to start with, and then get integrated
> into the ACPI code later on.

Or this could be an extension of
drivers/acpi/processor_core.c::acpi_processor_errata() from the beginning.
Len, what do you think?

	Dominik


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
