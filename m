From: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Subject: Re: HP/Compaq NC6120 ACPI problems
Date: Fri, 18 Mar 2005 00:05:18 +0000
Message-ID: <1111104319.8136.182.camel@tyrosine>
References: <20050317200052.686d683f.andrej.prsa@guest.arnes.si>
	 <1111088904.11380.36.camel@eeyore>
	 <20050317215635.1c788c09.andrej.prsa@guest.arnes.si>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <20050317215635.1c788c09.andrej.prsa-zs/Xt9NzJtxxh+DGd0HQrg@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andrej Prsa <andrej.prsa-zs/Xt9NzJtxxh+DGd0HQrg@public.gmane.org>
Cc: ACPI Support <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, 2005-03-17 at 21:56 +0100, Andrej Prsa wrote:

> Observational update: it does *NOT* gradually slow down, it slows down
> *instantly* after 2-3 minutes of running; the time of kacpid blowup is
> somewhat arbitrary, it sometimes happens even before the boot-up is
> complete. If I was to make another wild guess, it might be connected
> with the fan - when the computer is cool, the blowup occurs later, if it
> is warm, it occurs sooner. Is it possible that the call to turn the fan
> on is triggering this kacpid blowup? How does one go about to test this?

Ah, right - I've seen similar behaviour on a range of HPs (inluding the
6120). Try using 
http://bugzilla.kernel.org/attachment.cgi?id=4516&action=view and see if
it makes a difference.
-- 
Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
