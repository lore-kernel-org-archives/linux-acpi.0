From: Andrew Kohlsmith <akohlsmith-uiYP0llB1AZBDgjK7y7TUQ@public.gmane.org>
Subject: Re: ACPI & APIC
Date: Wed, 16 Oct 2002 09:13:43 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200210160913.43931@-mixdown.ca>
References: <20021014105058.7898C2063B@mail.uboot.com> <1034711544.1511.2.camel@speedy-gonzales> <3DAD2270.A97616D7@monetplus.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3DAD2270.A97616D7-Bh/+Xfn7orxQjibfaplwYw@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> 	I have Compaq Armada 110, kernel 2.4.19 with ACPI patch and notice the
> same. But when I played with kernel configuration (& serial console :-) I
> figured, that when I have enabled both ACPI (without pci=noacpi) & APIC
> together, my computer hangs on boot right in Interrupt routing :-{ Has
> anybody any clue ?

You're saying that if you compile the kernel WITHOUT APIC support that you 
don't need pci=noacpi?  This is a valuable clue I think!  I think I'm going 
to try that in the next day or so and see if it's the same here.

Maybe the Compaq laptops have bad entries for the APIC initialization in the 
ACPI tables or something.

Regards,
Andrew


-------------------------------------------------------
This sf.net email is sponsored by: viaVerio will pay you up to
$1,000 for every account that you consolidate with us.
http://ad.doubleclick.net/clk;4749864;7604308;v?
http://www.viaverio.com/consolidator/osdn.cfm
