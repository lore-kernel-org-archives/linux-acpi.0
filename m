From: Alexander Hoogerhuis <alexh-RsuaBgf086Q@public.gmane.org>
Subject: RE: HP DL360G3 and ACPI
Date: Fri, 23 Apr 2004 16:23:55 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1082730234.9392.18.camel@dorker.boxed.no>
References: <C50AB9511EE59B49B2A503CB7AE1ABD1066115A2@cceexc19.americas.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <C50AB9511EE59B49B2A503CB7AE1ABD1066115A2-Iar2LzuD2f6P0FQRY6S+e9kSKC0Mw0DFJ8am2ALHCgk@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Cagle, John (ISS-Houston)" <john.cagle-VXdhtT5mjnY@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Thanks for the quick reply. Ans thanks for the quick resolution. I am
running an unsupported distribution, and I seem to remember I ad
problems rebuilding the hpasm-driver for the 2.6 kernel (running on
2.6.5-mm6 at the moment). Is it supposed to build on 2.6?

mvh,
A

On Fri, 2004-04-23 at 08:43 -0500, Cagle, John (ISS-Houston) wrote:
> > -----Original Message-----
> > From: Alexander Hoogerhuis
> > Sent: Thursday, April 22, 2004 11:50 PM
> > 
> > I have a few of these beasts onsite at a customers site, and 
> > they ahve a
> > tendency to wind up the fans and not come back ddown again. I'm
> > currently running 2.6.5-mm6 on them and the only piece of suspicious
> > output I can find int he boot log is this:
> > 
> > ...
> > ACPI: Subsystem revision 20040326
> > ACPI: IRQ9 SCI: Level Trigger.
> >     ACPI-1059: *** Info: There are no GPE blocks defined in the FADT
> > ACPI: Interpreter enabled
> > ACPI: Using PIC for interrupt routing
> > ACPI: PCI Root Bridge [PCI0] (00:00)
> > ...
> > 
> > Is there any harm here or just me barking up the wrong tree?
> 
> You're barking up the wrong tree. :-)
> 
> I assume you're talking about the "Info" line above.  This used to
> be a "Warning" until I pointed out that there's no requirement
> (or need) for GPE blocks to be defined in the FADT according to the
> ACPI specification.  This "Info" line should be removed, IMHO.  It's
> like having your car tell you "There are no maps in the glove box."
> 
> If you're interested in having more intelligent fan control of the
> DL360G3, you'll need to install the 'hpasm' driver, available here:
> 
>   http://tinyurl.com/3cj8f
> 
> That link is for the Red Hat 8.0 version.  For the list of support
> pages for the different OS's, go here:
> 
>   http://tinyurl.com/2xtrv
> 
> If you're not running one of the officially supported OS's, you can
> still use the 'hpasm' driver.  The documentation gives instructions
> on rebuilding the driver for any kernel.
> 
> Regards,
> John
> 
> -----------------------------
> John Cagle  john.cagle-VXdhtT5mjnY@public.gmane.org
> HP Distinguished Technologist
> ProLiant Software Development
>   http://www.hp.com/linux/
>   Hewlett-Packard Company



-------------------------------------------------------
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297
