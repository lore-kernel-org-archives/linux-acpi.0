From: "Cezar Halmagean" <cezar-WE3S9J525UShKNWrAYCRhA@public.gmane.org>
Subject: Re: back from suspend
Date: Wed, 23 Feb 2005 17:37:26 +0200
Message-ID: <20050223153726.M31999@mixandgo.ro>
References: <20050222215216.M55296@mixandgo.ro> <20050223160825.24ec9888@orfeo.nikhef.nl>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=utf-8
In-Reply-To: <20050223160825.24ec9888-acHaiI0CM+haAVKTNDtesg@public.gmane.org>
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

no, that does not help

--
Cezar Halmagean
Mix & Go

---------- Original Message -----------
From: Tim Dijkstra <newsuser-TpnWJeB+oO0hKRfeEwdQzg@public.gmane.org>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Sent: Wed, 23 Feb 2005 16:08:25 +0100
Subject: Re: [ACPI] back from suspend

> On Tue, 22 Feb 2005 23:54:08 +0200
> "Cezar Halmagean" <cezar-WE3S9J525UShKNWrAYCRhA@public.gmane.org> wrote:
> 
> > 
> > the patch on hwsleep.c solved half the problem, now It goes nice and
> > clean into sleep mode, but when I come back, both keyboard is dead and
> > screen remains blank.
> 
> On my (totally different notebook) it helped to add 
> 	 acpi_sleep=s3_bios,s3_mode
> 
> to the kernel options. Also I had to remove firewire modules before
> suspend.
> 
> grts Tim
> 
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
------- End of Original Message -------



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
