From: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Subject: Re: Re: ACPI Suspend on Inspiron 1100
Date: Mon, 04 Apr 2005 14:27:24 +0100
Message-ID: <1112621244.20939.103.camel@tyrosine>
References: <20050331191931.GA16450@jose.lug.udel.edu>
	 <200504011602.06831.stefandoesinger@gmx.at>
	 <20050403224042.GA30240@jose.lug.udel.edu>
	 <1112569030.20939.93.camel@tyrosine>
	 <20050404071524.GB8666@message-id.gmane0305.slipkontur.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050404071524.GB8666-l0tNAEGuAhhzZ8+rp42Dbp9+tswZ0GTaehPwdyo5hKaELgA04lAiVw@public.gmane.org>
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

On Mon, 2005-04-04 at 09:15 +0200, Stefan Seyfried wrote:

> Some of our X gurus told me, that it is actually illegal to simply restore
> vbestate without further knowledge and that "bad things may happen" when
> i asked them if they could not put "vbetool {save,restore}" functionality
> into vt-switch of all x servers. I have not enough knowledge about this stuff
> and could only tell them "but it works sometimes" :-)

I can imagine that restoring a graphical state may not put the card back
in exactly the same mode as X expects it to be in, and that bad things
might then happen. The way we tend to use it for ACPI is to restore a
text mode, and things seem to work well enough then. I've had /some/
luck with using it with vesafb, and it may well be possible to hack
suspend/resume support into vesafb. We'd either need in-kernel vm86 or
to resume vesafb after userspace is up, though.

-- 
Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
