From: Andrej Prsa <andrej.prsa-zs/Xt9NzJtxxh+DGd0HQrg@public.gmane.org>
Subject: Re: HP/Compaq NC6120 ACPI problems
Date: Sat, 19 Mar 2005 10:35:50 +0100
Message-ID: <20050319103550.2cd6bd9d.andrej.prsa@guest.arnes.si>
References: <20050317200052.686d683f.andrej.prsa@guest.arnes.si>
	<1111088904.11380.36.camel@eeyore>
	<20050317215635.1c788c09.andrej.prsa@guest.arnes.si>
	<1111104319.8136.182.camel@tyrosine>
	<20050318192300.629e2148.andrej.prsa@guest.arnes.si>
	<1111202374.8136.210.camel@tyrosine>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
In-Reply-To: <1111202374.8136.210.camel@tyrosine>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

just a small observational update:

* applying the latest ACPI patch + the patch you recommended doesn't
  solve the issue
* during boot-up, the fan.ko module doesn't get loaded automatically
  and hence there is no /proc/acpi/fan entry. If I modprobe it manually,
  the fan/ directory is created with four subdirectories C253 through
  C256, each having only a state entry; all are set to off
* if I try to change them to on by 'echo 0 > ...' or 'echo on > ...',
  it doesn't work - they all remain set to "off".

> Hmm. Yes, I can now repeat this with a 6220, though most of the time I
> manage it it seems to be linked to a suspend to disk beforehand. I
> suspect this /may/ be linked to the fact that on the 6120, only the
> first lid event is received. I'll see if I can track this down over
> the weekend.

Thanks; if there's anything I can do to help, please let me know!

Bye,

Andrej


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
