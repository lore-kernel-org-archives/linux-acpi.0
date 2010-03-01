From: Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: Touchpad led inversed ?
Date: Mon, 01 Mar 2010 12:54:03 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1003011251400.4281@localhost.localdomain>
References: <71cd59b01002210249y5dc3d93aubc79741df7da34f1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi4asus-user-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <71cd59b01002210249y5dc3d93aubc79741df7da34f1-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi4asus-user>,
	<mailto:acpi4asus-user-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=acpi4asus-user>
List-Post: <mailto:acpi4asus-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi4asus-user-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi4asus-user>,
	<mailto:acpi4asus-user-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: acpi4asus-user-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Corentin Chary <corentin.chary-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux acpi <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, debian-eeepc-devel-XbBxUvOt3X2LieD7tvxI8l/i77bcL1HB@public.gmane.org, acpi4asus-user <acpi4asus-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org



thanks,
Len Brown, Intel Open Source Technology Center

On Sun, 21 Feb 2010, Corentin Chary wrote:

> Hi,
> It seems that touchpad led is inverted on Eee1001HAG
> (http://bugzilla.kernel.org/show_bug.cgi?id=14865).
> If you get a touchpad led on your eeepc , could you test if it is
> working as expected and report the results ?
> Thanks,
> 
> Ps: not really related, but if you have to boot with acpi_osi="Linux"
> to be able to use eeepc-laptop,
> please read http://dev.iksaif.net/projects/acpi4asus/wiki/Eeepc-wmi .

BTW.

I'd rather that they use acpi_osi="!Windows 2009" than acpi_osi=Linux
as a workaround -- as the workaround here isn't enabling some special
Linux support (which doesn't actually exist).
The workaround is disabling the new win7 support.

thanks
Len Brown, Intel Open Source Technology Center

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
