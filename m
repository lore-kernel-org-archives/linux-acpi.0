From: bruno <bruno.biagini-anva-Syd3ARw+vPY@public.gmane.org>
Subject: Re: toshiba tecra 8100 problems with ACPI
Date: Fri, 4 Mar 2005 09:47:03 +0100
Message-ID: <200503040947.03320.bruno.biagini-anva@poste.it>
References: <200503031648.29509.bruno.biagini-anva@poste.it> <20050303172300.GA31985@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
In-Reply-To: <20050303172300.GA31985-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Content-Disposition: inline
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

On Thursday 03 March 2005 18:23, Bruno Ducrot wrote:
> On Thu, Mar 03, 2005 at 04:48:29PM +0100, bruno wrote:
> > Dear all
> > I'm posting after having read different messages in such mailing list.
[...]
> > The problem is the following:
> >

[...]

> > ..........
> > ACPI: Subsystem revision 20040326
>
>                            ^^^^^^^^
> 			This is the problem.
> 		   Please upgrade your kernel.

Ok I'll do !!

> ...
>
> > ">> dsdt.asl 134: Method(_WAK, 1) {
> >
> >  >> Warning 2026 - ^ Reserved method must return a value (_WAK)
> >
> >  You should probably add a "Return(Package(0x02){0x00, 0x00})" on a new
> >  line just before the closing curly brace like so:
[...]
> > I used such workaround for all my warnings (adding such line) then I
> > recompiled the new dsdt.dsl and I got 0 errors, 0 warnings, 0 remarks but
> > .
>
> No.  This work only for _WAK.

[...]

>
> Most recent versions of ACPI-CA do have already a quirk in order to
> fix those troubles for (older) Toshiba.

Ok I'll get new kernel (2.6.10 seems to be good). If I have again problems 
after the kernel compilation I'll study in better detail ACPI spec document.

Thanks a lot Bruno for your kind reply
and
all the best to all
Bruno (again ;-) ) 


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
