From: Dumitru Ciobarcianu <swsusp-devel-P4rH+HwZiSk@public.gmane.org>
Subject: Re: [Suspend2-devel] Cause of Suspend2 resume failures on Toshiba
 laptops
Date: Sat, 05 Mar 2005 14:21:09 +0200
Message-ID: <1110025269.5080.3.camel__5182.31129176474$1110025196$gmane$org@DustPuppy.LNX.RO>
References: <20050304175058.GA4042@blackham.com.au>
	 <1110012298.6028.10.camel@DustPuppy.LNX.RO>
	 <20050305100254.GH4042@blackham.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20050305100254.GH4042-4vSAtV5O1nc0n/F98K4Iww@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bernard Blackham <bernard-4vSAtV5O1nc0n/F98K4Iww@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, suspend2-devel-g/J2nbn7YhmWn91e4EydUaxOck334EZe@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

=C3=8En data de S=C3=AE, 05-03-2005 la 18:02 +0800, Bernard Blackham a sc=
ris:
> Ahh, d'oh. Try this patch instead.
>=20
> After more investigation, it seems that the issue is the GPE is
> fired but not serviced because kacpid is frozen. This in itself
> would be okay, however, the GPE isn't being disabled before the
> method executes (despite there being code there to do so), and hence
> fires continuously.
>=20
> The attached patch makes kacpid NOFREEZE so the GPE does get
> serviced (eventually), but probably still isn't the correct
> solution. (A better solution being making sure the GPE gets disabled
> in the first place ... still looking into this).


You got it this time!
Several successful suspend/resume cycles for me! And even the events are
working! :)=20

Thanks,=20

--=20
Cioby




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
