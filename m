From: Lyle <lwspm-RAHWjsxJnJUdnm+yROfE0A@public.gmane.org>
Subject: Re: suspend.c vs driver-model.txt
Date: Wed, 24 Jul 2002 13:56:59 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020724175704.2785B14808@o-o.yi.org>
References: <mochel@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: Message from Patrick Mochel <mochel-3NddpPZAyC0@public.gmane.org>
   of "Wed, 24 Jul 2002 08:51:34 PDT." <Pine.LNX.4.44.0207240843090.954-100000-yZQdDDOm3n9ZQn2sFP3R7eTW4wlIGRCZ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


> On a side, though related, note, while we were in Ottawa, several of us 
> had a chance to sit down and hammer out exactly what needs to take place. 
> The results exist in a notebook (a real, pencil-driven one), but have not 
> had a chance to be expressed in ASCII text yet. (Frankly, it's a low 
> priority right now: -EPLATEFULL). 

Did you talk at all about the fact that pci.h has its own set of power-management hooks that almost-but-not-quite map to the ACPI
ones, and how to resolve that?




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
