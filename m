From: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>
Subject: Re: Re: Linux 2.4.26-rc1 (cmpxchg vs 80386 build)
Date: Mon, 29 Mar 2004 02:09:57 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040329020957.43a2ce5a.ak@suse.de>
References: <A6974D8E5F98D511BB910002A50A6647615F6939@hdsmsx402.hd.intel.com>
	<1080535754.16221.188.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1080535754.16221.188.camel-D2Zvc0uNKG8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: arekm-k0Z414SquRyhPH1hqNUYSQ@public.gmane.org, marcelo.tosatti-3EexvZdKGZRWk0Htik3J/w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On 28 Mar 2004 23:49:15 -0500
Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:

> 
> I'm open to suggestions on the right way to fix this.
> 
> 1. recommend CONFIG_ACPI=n for 80386 build.
> 
> 2. force CONFIG_ACPI=n for 80386 build.
> 
> 3. invoke cmpxchg from acpi even for 80386 build.


I think (3) is best. Just define it always, even when the kernel is built for
i386. I considered it always a bug that cmpxchg was not defined in i386 builds. 
The users of it just have to ensure it won't actually run on an i386 (by cpuid 
or implicitely like ACPI does) 

-Andi


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
