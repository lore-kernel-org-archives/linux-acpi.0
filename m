From: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Subject: Re: Savage backlight control
Date: Thu, 14 Apr 2005 10:19:36 +0100
Message-ID: <1113470376.10110.160.camel@tyrosine>
References: <20050414060742.71711.qmail@web50205.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050414060742.71711.qmail-/7KY5DUzB96A/QwVtaZbd3CJp6faPEW9@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Johan Braennlund <johan_brn-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, 2005-04-13 at 23:07 -0700, Johan Braennlund wrote:

> Would it be possible to connect either of those methods to the /proc
> interface? My interest in all this comes from a desire to be able to
> script brightness control, depending on whether I'm on AC or batteries.

It's quite likely that your machine will have acpi methods to control
the brightness, and if it does you could hook them up to the /proc
interface. However, these methods tend to be per-manufacturer rather
than per-graphics chipset. The current /proc/acpi/video stuff uses the
standard ACPI video methods, and sadly many manufacturers don't support
that. Your best bet may be to work on a hardware-specific support module
- it's likely to work on several other machines from the same
manufacturer as well.

-- 
Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
