From: Ken Hughes <khughes-kam3zbT8ll8@public.gmane.org>
Subject: Re: Re: kacpid respawning under linux-2.4.20 on Toshiba Satellite 5105
Date: Fri, 3 Jan 2003 11:14:47 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030103191447.GD397@budgie.we1.client2.attbi.com>
References: <F760B14C9561B941B89469F59BA3A84725A108@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <F760B14C9561B941B89469F59BA3A84725A108-sBd4vmA9Se4Lll3ZsUKC9FDQ4js95KgL@public.gmane.org>; from andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org on Fri, Jan 03, 2003 at 11:10:48 -0800
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Ken Hughes <khughes-kam3zbT8ll8@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On 2003.01.03 11:10 "Grover, Andrew" wrote:
> (oops, should have read your followup before replying to your original
> msg - sorry)
> 
> > From: Ken Hughes [mailto:khughes-kam3zbT8ll8@public.gmane.org]
> > A follow-up to my last post:
> >
> > I traced my problem to this code in drivers/acpi/osl.c in
> > acpi_os_derive_pci_id():
> >
> >         /* any nicer way to get bus number of bridge ? */
> >         status = acpi_os_read_pci_configuration(pci_id, 0x0e,
> > &tu8, 8);
> >        if (ACPI_SUCCESS(status) && (tu8 & 0x7f) == 1) {
> >                 status = acpi_os_read_pci_configuration(pci_id,0x19,
> 
> > &tu8, 8);
> >                 if (ACPI_SUCCESS(status))
> >                         pci_id->bus = tu8;
> >
> > If I replace the assignment to pci_id->bus with a printk, the zombie
> 
> > kacpidpc
> > processes go away.  The value shown for tu8 is 2.  pci_id->device is
> 
> > 0x1e and
> > pci_id->function is 0 at this point.
> 
> What value was pci_id->bus before it got overwritten with 2?

pci_id->bus was 0.

Ken


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
