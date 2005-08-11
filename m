From: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH] Disable slow duplicate object tracking in ACPI_DEBUG
Date: Thu, 11 Aug 2005 04:29:52 +0200
Message-ID: <20050811022952.GG8974@wotan.suse.de>
References: <F7DC2337C7631D4386A2DF6E8FB22B30044D213E@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B30044D213E-N2PTB0HCzHKkrb+BlOpmy7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Aug 10, 2005 at 10:14:43PM -0400, Brown, Len wrote:
> Maybe it is time to figure out why SLES has ACPI_DEBUG enabled.
> If it is certain warnings and error messages, then perhaps
> we should enable those but not all the other misc debug
> and paranoia checks that come with ACPI_DEBUG?

SLES doesn't have ACPI_DEBUG enabled. 

ACPI_DEBUG is just sometimes enabled in the betas because it makes
it easier to track down ACPI bugs - mostly because of the
tracing options which can be then used without recompiling the kernel

(which BTW seem to also cause considerable 
overhead. One current case is a system where kacpid takes about 1.7%
of CPU and most of that seems to be just tracing functions) 

ACPI_DEBUG_LITE was intended to be a subset that has only the 
needed stuff enabled, but somehow that didn't take off.

-Andi


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
