From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Repeatable lockup with sustained polling of battery state
Date: Fri, 29 Nov 2002 19:45:30 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021129184530.GR1989@poup.poupinou.org>
References: <1034266219.1287.40.camel@sirius.strandboge.cxm> <1036013358.9704.93.camel@sirius.strandboge.cxm> <1038339343.1840.4.camel@sirius.strandboge.cxm> <200211291320.39188@-mixdown.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200211291320.39188-T9p8nP5vHr8sA/PxXw9srA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andrew Kohlsmith <akohlsmith-acpi-uiYP0llB1AZBDgjK7y7TUQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Nov 29, 2002 at 01:20:39PM -0500, Andrew Kohlsmith wrote:
> > I am still having this problem.  I have attached my dsdt file in hopes
> > someone can help with this.  I am using 2.4.20-rc2 with acpi-20021118.
> > I get no errors on boot, and cannot find any errors in my logs.  If I
> > poll my battery state, the system locks up.  One extra note is that the
> > BIOS keys do in fact work when the machine is locked, I just can't get
> > the OS to respond.
> 
> I honestly don't think it has anything to do with the DSDT; I think that there 
> is a subtle bug somewhere in the ACPI code which reads out the battery level 
> from the controller that causes the hang.
> 
> I mean the DSDT organizes what is there and how to get to it, but doesn't 
> actually have any code that is executed to obtain the information, correct?

No.  You use DSDT methods that need to be interpreted by ACPI.  And yes, linux
ACPI could have some bug, but the DSDT can be faulty as well.

For example, I have rewrotten completely the methods in this area on my DSDT for
my own laptop in order to have more precise values and also it was more faster than
the original.


-- 
Ducrot Bruno
http://www.poupinou.org        Page profaissionelle
http://toto.tu-me-saoules.com  Haume page


-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
