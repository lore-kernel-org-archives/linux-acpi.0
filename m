From: Andrew Barr <barr.156-ZbGKxL/pcrQ@public.gmane.org>
Subject: Re: DSDT loading patch
Date: Mon, 6 Dec 2004 10:14:32 -0500
Message-ID: <200412061014.33191.barr.156@osu.edu>
References: <200412060907.53079.david.goodenough@btconnect.com> <200412060740.25524.barr.156@osu.edu> <200412061435.23333.david.goodenough@btconnect.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200412061435.23333.david.goodenough-6b45v/Ft3lbby3iVrkZq2A@public.gmane.org>
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
List-Id: linux-acpi@vger.kernel.org

On Monday 06 December 2004 9:35 am, David Goodenough wrote:
[...]
> Thanks for the reply.  I am glad that some feature to get this in is now
> getting in to the standard kernel, but it does strike me that this
> in-initrd method means that normally you would not have to rebuild your
> kernel just because you have a buggy DSDT every time you put up a new
> kernel. Normally these days I can work with the stock Debian kernels, and
> so I do not need to rebuild the kernel every time.
>
> Do you know who decided this and why?
>
> Regards
>
> David

You'll only need to rebuild your kernel if your DSDT changes and is still 
buggy: for example, if Samsung updates their BIOS and you upgrade, and 
they've changed the DSDT but not fixed the bugs that the ACPI subsystem had 
problems with.

The initrd method is only adventageous if you are in the process of fixing 
your DSDT and you'd like to test different DSDTs and don't want to recompile 
your kernel each time. The in-kernel method is actually better for me; that 
way I don't have to remeber to append the DSDT to the generated initrd.

The initrd method is no longer used for technical reasons I don't remember 
exactly.

Andrew


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
