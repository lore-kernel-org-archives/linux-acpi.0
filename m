From: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: [giri@lmc.cs.sunysb.edu: Resume from suspend-to-ram]
Date: Sat, 21 Feb 2004 15:13:12 +1100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1077336792.17072.30.camel@gaston>
References: <20040220235512.GA27779@dreamland.darkstar.lan>
	 <1077321457.9623.27.camel@gaston>
	 <20040221041647.2F8307831D@mail.lmc.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040221041647.2F8307831D-Yo/1PYb2HdawRS80dfYGFoIJIQD0bWaD@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Giridhar Pemmasani <giri-IxWJ8JVbGpr5NRxSJurNR4dd74u8MsAO@public.gmane.org>
Cc: Kronos <kronos-OwEdLhkac/ZLIFpYAn0waQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sat, 2004-02-21 at 15:16, Giridhar Pemmasani wrote:
> Actually there was another patch that I missed. 
> 
> I also had to patch radeon driver in XFree86 to softboot/POST. This
> patch is from
> http://mrohne.home.cern.ch/mrohne/P2120/P2120_Linux_S3.html (actually
> there is no patch there, but I didn't want to post his email address
> here, but if you need to contact him, go to the top of this link). 

Ahhhh ... that explains it.. yes, we need to re-POST the card.

I'm afraid in the kernel, that will be a problem, unless we can
do that from real mode some way... my knowledge of x86 isn't good
enough. One thing is sure, we can't rely on the PCI ROM of the
card having a valid useable BIOS image, it's usually hidden
somewhere with the main BIOS, so either we use the RAM image
at c0000 or we ask the main BIOS to re-post the card.

Ben.



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
