From: tmc-+XVqjN4+fIJfbCVcMT5z6Ydd74u8MsAO@public.gmane.org (Tomasz Ciolek)
Subject: Re: question about ACPI & Smart Batteries
Date: Fri, 13 Aug 2004 08:36:33 +1000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040812223633.GA2750@dreamcraft.com.au>
References: <F760B14C9561B941B89469F59BA3A8470726AFF5@orsmsx401.amr.corp.intel.com> <20040812222936.GD30862@miramar.cse.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20040812222936.GD30862-v28VZnYc+MmC5P5rv/TENfZ8FUJU4vz8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Cintia B. Margi" <cintia-Emgmuai4XwL2fBVCVOL8/A@public.gmane.org>
Cc: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Write to the maintainer of wmacpi-ng package. He has a good clue as to
how ACPI generates the battery values...

Tomasz Ciolek

On Thu, Aug 12, 2004 at 03:29:36PM -0700, Cintia B. Margi wrote:
> * Grover, Andrew (andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org) said:
> > Unless you have a Fujitsu Uva, you do not have a smart battery, you have
> > a control method battery.
> 
> I don't have a smart battery then.
>  
> > For a CM battery, the OS can poll the battery state by calling _BST, or
> > set a trip point (via _BTP) and the OS will get an interrupt when the
> > battery crosses that trip.
> 
> I do not want to set a trip point, but I would like to monitor the battery discharge
> process... I want to characterize the battery discharge behavior under different tasks,
> so I intend to monitor the battery voltage and the discharge rate (which I can obtain
> from /proc/acpi/battery/BAT0/state). What I would like to know is how often the state
> file is updated and how accurate these values are. Any idea where I can get this info?
> 
> Thanks,
> 
> Cintia 
> 
> --
> Cintia Margi
> Graduate Student
> SoE - UCSC
> http://www.soe.ucsc.edu/~cintia
> GPG Public Key: http://www.soe.ucsc.edu/~cintia/cintia.gpg
> B4DE 9355 3840 FF72 50F2 ACAC E2EC AA9A 41E2 CD55



-- 
Tomasz M. Ciolek	
*******************************************************************************
 tmc at dreamcraft dot com dot au 
*******************************************************************************
   GPG Key ID:		0x41C4C2F0
   GPG Key Fingerprint: 3883 B308 8256 2246 D3ED  A1FF 3A1D 0EAD 41C4 C2F0
   Key available on www.pgp.net	
*******************************************************************************


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
