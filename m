From: Jos Delbar <jos.delbar-Cru1EgDzd7c@public.gmane.org>
Subject: Re: Re: Linux ACPI processor driver patch: user-definable power state limit
Date: Sat, 6 Nov 2004 00:39:27 +0100
Message-ID: <200411060039.28067.jos.delbar@ugent.be>
References: <F7DC2337C7631D4386A2DF6E8FB22B3001A193B6@hdsmsx401.amr.corp.intel.com> <1099683907.13837.1353.camel@d845pe> <20041105225438.GA8262@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20041105225438.GA8262-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>
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
To: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>
Cc: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Robert Moore <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, James P Ketrenos <james.p.ketrenos-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Is it safe to return a pointer to an internal module structure? I think a bad 
driver could potentially ruin the linked list by changing the next pointer.

On Friday 05 November 2004 23:54, Dominik Brodowski wrote:
> That sounds to be quite racy. Multiple callers will get confused.
> You probably need a
>
> struct acpi_cstate_limit {
>  list_head next;
>  unsigned int limit;
> }
>
> and you export
>
> struct *acpi_cstate_limimt acpi_set_cstate_limit(unsigned int limit);
>
> int acpi_modify_cstate_limit(struct acpi_cstate_limit * cstate_limit);
>
> void acpi_remove_cstate_limit(struct acpi_cstate_limit * cstate_limit);
>
> Whenever such an operation occurs, you need to walk all these limit structs
> for the highest "limit", and use that.

-- 

Jos Delbar
jos.delbar-Cru1EgDzd7c@public.gmane.org


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
