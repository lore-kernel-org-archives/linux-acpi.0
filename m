From: Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>
Subject: Re: HP/Compaq NC6120 ACPI problems
Date: Sat, 19 Mar 2005 23:13:43 +0100
Message-ID: <20050319221343.GA29495@message-id.gmane0305.slipkontur.de>
References: <20050317200052.686d683f.andrej.prsa@guest.arnes.si> <1111088904.11380.36.camel@eeyore> <20050317215635.1c788c09.andrej.prsa@guest.arnes.si> <1111104319.8136.182.camel@tyrosine> <20050318192300.629e2148.andrej.prsa@guest.arnes.si> <1111202374.8136.210.camel@tyrosine> <20050319103550.2cd6bd9d.andrej.prsa@guest.arnes.si>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050319103550.2cd6bd9d.andrej.prsa-zs/Xt9NzJtxxh+DGd0HQrg@public.gmane.org>
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

On Sat, Mar 19, 2005 at 10:35:50AM +0100, Andrej Prsa wrote:
> Hi,
> 
> just a small observational update:
> 
> * applying the latest ACPI patch + the patch you recommended doesn't
>   solve the issue
> * during boot-up, the fan.ko module doesn't get loaded automatically
>   and hence there is no /proc/acpi/fan entry. If I modprobe it manually,
>   the fan/ directory is created with four subdirectories C253 through
>   C256, each having only a state entry; all are set to off

on my HP / Compaqs, each "fan" is for one speed level of the fan which
has 4 speeds (on nx500 and on an Armada E500)

> * if I try to change them to on by 'echo 0 > ...' or 'echo on > ...',
>   it doesn't work - they all remain set to "off".

echo 0 > ... => off
echo 3 > ... => on
-- 
Stefan Seyfried



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
