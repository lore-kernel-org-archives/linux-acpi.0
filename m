From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: C2/C3 don't do anything
Date: Fri, 4 Feb 2005 14:55:28 -0800
Message-ID: <20050204225527.GA30585@atomide.com>
References: <20050203034639.GA29164@atomide.com> <20050204203026.GA8049@dominikbrodowski.de> <20050204213407.GA26515@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050204213407.GA26515-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

* Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org> [050204 13:34]:
> Thus wrote Dominik Brodowski:
> > > I've done an idle module few years ago that enables C2 for dual
> > > Athlon boxes [3], and that involved enabling it in the southbridge.
> > > 
> > > I thought the current ACPI code enables this already? But it does
> > > not seem to be the case?
> > 
> > AFAIK, if there is no initialization method included in the ACPI table, the
> > ACPI code does _not_ currently enables some special, vendor-specific bit in 
> > southbridges.

OK, can you point me to the file to add printk's in the ACPI code where
the initialization happens? I'm not too familiar with ACPI code...

> > > Should we have some extra code to scan the southbridges,
> > 
> > Definitely. There is already some "errata" handling in the processor module,
> > possibly this could get extended.
> 
> I'm still using the patch to enable C3 on ICHx-M I once posted. Basically,
> it provided a valid PM2_CNT_BLK address in case the OEM had forgotten to do
> that, which in turn enabled C3 by providing a valid ARB_DIS address
> (provided P_LVL3_LAT is valid).

I have some code for the amd76x_pm module that can be modified for
scanning various southbridges. And then add functions for the
to enable them. I don't know when I'll have time to play with that
though.

This could be a separate module to start with, and then get integrated
into the ACPI code later on.

> It might be worthwile to add some quirks, possibly opt-in by a commandline
> option.

Or it could be an ACPI southbridge module?

Tony


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
