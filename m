From: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Subject: Re: HP/Compaq NC6120 ACPI problems
Date: Sat, 19 Mar 2005 03:19:34 +0000
Message-ID: <1111202374.8136.210.camel@tyrosine>
References: <20050317200052.686d683f.andrej.prsa@guest.arnes.si>
	 <1111088904.11380.36.camel@eeyore>
	 <20050317215635.1c788c09.andrej.prsa@guest.arnes.si>
	 <1111104319.8136.182.camel@tyrosine>
	 <20050318192300.629e2148.andrej.prsa@guest.arnes.si>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <20050318192300.629e2148.andrej.prsa-zs/Xt9NzJtxxh+DGd0HQrg@public.gmane.org>
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

On Fri, 2005-03-18 at 19:23 +0100, Andrej Prsa wrote:

> Tried it, unfortunately the outcome is still the same; I used the patch
> against 2.6.11.4 kernel *without* any other ACPI patch. Should I use the
> patch you provided over the ACPI patch or was it supposed to fix the fan
> issue by itself? Seemingly the problem is the fan; is there a way to
> test this to be sure?

Hmm. Yes, I can now repeat this with a 6220, though most of the time I
manage it it seems to be linked to a suspend to disk beforehand. I
suspect this /may/ be linked to the fact that on the 6120, only the
first lid event is received. I'll see if I can track this down over the
weekend.

-- 
Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
