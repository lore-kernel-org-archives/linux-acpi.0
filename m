From: "Charl P. Botha" <c.p.botha-ra0OqMccq8edIhEUFHOBvg@public.gmane.org>
Subject: Re: Problems waking up from S3 (2.5.25-dj2)
Date: Mon, 29 Jul 2002 16:32:11 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020729143211.GN20462@dutidad.twi.tudelft.nl>
References: <20020720170919.GA9308@dutidad.twi.tudelft.nl> <20020729142333.GA977@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20020729142333.GA977-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Jul 29, 2002 at 04:23:33PM +0200, Pavel Machek wrote:
> > I have this same problem and would like to know what possible courses of
> > action there are.  I am experimenting with 2.5.25-dj2 (acpi-20020611
> > integrated) on a i845 laptop with Phoenix BIOS 4.0 release 6.  For the
> > moment, swsusp will not work on this laptop (due to the fact that the Radeon
> > has the switch to VT X freezing problem) so I'm looking at S3 as a temporary
> > alternative.
> 
> Perhaps it is easier to make swsusp working?

Heh, you were right.  I have since fixed the VT switch bug with the help of
Michel Dänzer and Mike Harris.  That was still not enough to get swsusp
working, as the Radeon hardware does not get reconfigured correctly on
resume (this is not so easy).  

So I modified the DRI drivers to de-init and re-init the Radeon with every
VT switch.  People on this list might also be interested:
http://cpbotha.net/dri_reinit_kludge.html

Thanks for your help Pavel.  I will have to try 2.5.x again later.

Best regards,
Charl

-- 
charl p. botha http://cpbotha.net/ http://visualisation.tudelft.nl/


-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
