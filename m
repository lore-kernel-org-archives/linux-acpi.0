From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: APM sleep vs. ACPI S3 sleep
Date: 20 May 2004 23:57:47 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1085111866.12354.567.camel@dhcppc4>
References: <40ACE6B4.4060408@mesias.co.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <40ACE6B4.4060408-Nk/s8sJ9yP7QXOPxS62xeg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Cam <camilo-Nk/s8sJ9yP7QXOPxS62xeg@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, 2004-05-20 at 13:11, Cam wrote:
> Hi
> 
> APM sleep eg. when running linux 2.4 with the APM behaviour in the BIOS 
> used to suspend the machine, the battery would last for a long time and 
> the machine would be cold to the touch (ie it's at the ambient temperature).
> 
> ACPI S3 sleep looks the same but the battery does not last long and the 
> machine is warm to the touch.
> 
> Has anyone else seen this behaviour? Is it possible that the machine is 
> waking itself periodically or at a certain level of discharge? Is it 
> possible to make the ACPI sleep deeper?

S3 is suspend to RAM, so the processor will be off, but RAM will still
be refreshed; and some devices may still consume power.

S4 is suspend to disk, and it should be as cold this way as S5.

-Len




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
