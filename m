From: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Subject: Re: HP/Compaq NC6120 ACPI problems
Date: Sun, 20 Mar 2005 23:46:56 +0000
Message-ID: <1111362416.8136.225.camel@tyrosine>
References: <20050317200052.686d683f.andrej.prsa@guest.arnes.si>
	 <1111088904.11380.36.camel@eeyore>
	 <20050317215635.1c788c09.andrej.prsa@guest.arnes.si>
	 <1111104319.8136.182.camel@tyrosine>
	 <20050318192300.629e2148.andrej.prsa@guest.arnes.si>
	 <1111202374.8136.210.camel@tyrosine>
Mime-Version: 1.0
Content-Type: text/plain
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
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sat, 2005-03-19 at 03:19 +0000, Matthew Garrett wrote:

> Hmm. Yes, I can now repeat this with a 6220, though most of the time I
> manage it it seems to be linked to a suspend to disk beforehand. I
> suspect this /may/ be linked to the fact that on the 6120, only the
> first lid event is received. I'll see if I can track this down over the
> weekend.

Ha. Yes, progress, of sorts. On the 6120, you need to do

setpci -s 1f.0 bb.b=84

after every lid event in order to get any more. I /think/ this is a bug
with the HP BIOS (the 6220 doesn't do this) - I'm in touch with HP over
it now. As for the high kacpid load, I'm only able to trigger this after
a suspend to disk, and using the platform option (to ensure the _WAK
methods are called) /seems/ to avoid it. Could you try building a kernel
with acpi debug support, set the output level fairly high (echo -n
0x0000ffff >/proc/acpi/debug_level) and see what sort of output you get?

Warning - there'll be huge amounts of it. Really huge amounts. The stuff
we're interested in is whatever appears after kacpid has begun taking up
all the processor time.

-- 
Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
