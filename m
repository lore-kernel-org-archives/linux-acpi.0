From: Bernd Schubert <bernd.schubert-VNq4CFrKgK+dPOQpRHQ53DeJuz7u0hKX@public.gmane.org>
Subject: Re: Call for help: list of machines with working S3
Date: Tue, 15 Feb 2005 19:50:25 +0100
Message-ID: <200502151950.27697.bernd.schubert@pci.uni-heidelberg.de>
References: <20050214211105.GA12808@elf.ucw.cz> <200502151535.41058.bernd.schubert@pci.uni-heidelberg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
In-Reply-To: <200502151535.41058.bernd.schubert-VNq4CFrKgK+dPOQpRHQ53DeJuz7u0hKX@public.gmane.org>
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
Cc: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hello again,

> > Stefan provided me initial list of machines where S3 works (including
> > video). If you have machine that is not on the list, please send me a
> > diff. If you have eMachines... I'd like you to try playing with
> > vbetool (it worked for me), and if it works for you supplying right
> > model numbers.
>
> we just tested our group IBM Thinkpad A31:
>
> IBM TP A31 / Type 2652-M5G     s3_mode (3)
>

I'm sorry, but I have to correct my self. We have two of laptops and on one of 
them we recently updated the bios. On the system with the bios from 2002 it 
works fine, on the other one with bios from Nov. 2004 it doesn't work in any 
acpi_sleep mode, didn't have the time to test the vbetool yet (A31s have 
radeon cards). The system configuration is otherwise completely identical, I 
just configured our environment, so that all laptops always have excactly the 
linux version. For testing purpose I could/will also try to run Xorg, 
currently its X from Debian Sarge.

IBM TP A31 / Type 2652-M5G / BIOS 1.04 2002-08-23    s3_mode (3) 
IBM TP A31 / Type 2652-M5G / BIOS 1.11 2004-11-05    not working


Sorry for not noting it immediately,
 Bernd



PS: Maybe its also interesting, with the newer bios version the kernel prints 
much less dsdt parsing errors, but nevertheless the S3 mode doesn't work.





-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
