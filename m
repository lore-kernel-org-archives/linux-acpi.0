From: inglor-L6arEPXw2n0ZNqoCg3qVjg@public.gmane.org
Subject: Re: Re: Acer TravelMate 3200 series
Date: Fri, 18 Feb 2005 12:57:15 +0200
Message-ID: <200502181257.15547.inglor@panafonet.gr>
References: <42139CFB.4000708@panafonet.gr> <89c8fbaa0502180120276cee49@mail.gmail.com> <m2sm3u189n.fsf@phoenix.squirrel.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
In-Reply-To: <m2sm3u189n.fsf-KjnUIgV0B0bak1Ioo/c9IoRWq/SkRNHw@public.gmane.org>
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

On Friday 18 February 2005 12:18, Johan Vromans wrote:
> Gerard Soldevila <soldevila-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:
> > Power Management Options (ACPI, APM ) --->
> > ACPI (Advanced Configuration and Power Interface) Support  --->
> > [*]   Include Custom DSDT
> > (/etc/dsdt.hex) Custom DSDT Table file to include
> >
> > I tried to load DSDT by this method (with 2.6.10) but no battery
> > status is shown and the loaded DSDT seems to be the original (diff
> > shows no ouptut)
> >
> > I encourage you to patch your kernel to read DSDT dinamically from
> > initrd.
>
> I use the kernel override technique all of the time, and it works
> perfectly. (I need to override the DSDT since the original DSDT has
> the wrong CPU frequencies in it. So I can immedeately see that its
> overridden.) There should be no difference whether the DSDT is
> overriden this way, or from the initrd (read the patch, it's clear).
>
> You can verify that he DSDT was actually overridden by inspecting
> dmesg:
>
>     ACPI-0294: *** Info: Table [DSDT] replaced by host OS
>
> -- Johan
>
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

Is the CPU frequency managed from acpid or cpufreqd.
I'm trying to manage the CPU and can't find a way...
Do you have any thoughts..? links..??? 
thanks..


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
