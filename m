From: Bruce Mackay <brucem128-Wuw85uim5zDR7s880joybQ@public.gmane.org>
Subject: Re: Impossible to compile iasl
Date: Fri, 26 Nov 2004 15:25:08 -0500
Message-ID: <20041126152508.04ee079f.brucem128@comcast.net>
References: <6EDC9204B3704C4C8522539D5C1185E568C7D3@mssmsx403.ccr.corp.intel.com>
	<20041126150639.053DE1C00CFE@mwinf0108.wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20041126150639.053DE1C00CFE-byJVNRQBufnlT94B3i6i6RXaG6MH5uyT@public.gmane.org>
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

On Fri, 26 Nov 2004 16:07:15 +0100
"vincent.legarrec" <vincent.legarrec-39ZsbGIQGT5GWvitb5QawA@public.gmane.org> wrote:

> I've already changed flex to flex-old and install bison and bison-1.35 but
> the problem exists enough. 
> Since, I reboot the computer and no change.
> 
> May you give me another help?
> 
> Regards,
> Vincent
> 
> -----Message d'origine-----
> 
> This is the problem, which is fixed by changing flex to flex-old, I've
> already mentioned that.
> 
> Regards,
> Alex.
> 
> >-----Original Message-----
> >From: vincent.legarrec [mailto:vincent.legarrec-39ZsbGIQGT5GWvitb5QawA@public.gmane.org]
> >Sent: Friday, November 26, 2004 4:03 PM
> >To: Starikovskiy, Alexey Y
> >Subject: RE: [ACPI] Impossible to compile iasl
> >
> >Thanks a lot for all replies, one problem is solve but now I have the
> >message :
> >
> >aslcompiler.l:846: error: `yytext_ptr' undeclared (first use in this
> >function)
> >aslcompiler.l:846: error: (Each undeclared identifier is reported only once
> >aslcompiler.l:846: error: for each function it appears in.)
> >make: *** [aslcompilerlex.o] Erreur 1
> >

This happened to me too.  I fixed it as follows:

In aslcompilerlex.c  there will be a line #undef yytext_ptr.  Remove it and try make again.  It worked for me.

Bruce


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
