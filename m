From: "Konstantin Svist" <konstantin-6crfdjOYMUleoWH0uzbU5w@public.gmane.org>
Subject: RE: ACPI on HP ze4430us
Date: Wed, 29 Dec 2004 11:53:59 -0800
Message-ID: <00ad01c4ede0$23b57bd0$0200a8c0@Home.local>
References: <41D23B5A.9000409@swebpage.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <41D23B5A.9000409-6MNMYbGzEYJWk0Htik3J/w@public.gmane.org>
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

I see.
So is there a more solution more permanent than the hack? Does that have to
do with DSDT?


Konstantin


> Sounds like that knoppix kernel has APM and ACPI support compiled in and
> APM gets choses on your laptop even though it's not supported so you
> have to tell the kernel to use ACPI explicitly.
> 
> -Herman
> 
> > I just tried Knoppix 3.7 on my laptop - it doesn't boot. After some
> > playing around, I figured out that the problem is ACPI - it only
> > boots if I specify any of the three "hacks": "acpi=off",
> > "acpi=ht", and "acpi=force". The last one even powers down my
> > laptop on shutdown.
> > What is going on here?



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
