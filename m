From: James Sparenberg <james-q+VOwRQyn90NJZHkBl2fuw@public.gmane.org>
Subject: Re: AE_NO_MEMORY on ACPI init after memory upgrade and oops
Date: Thu, 30 Jun 2005 19:19:50 -0700
Message-ID: <1120184390.23499.16.camel@localhost.localdomain>
References: <200506300042.22255.fedor@karpelevitch.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200506300042.22255.fedor-ugkMPi23kyXAHCkTjeiZhQ@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI Devl List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, 2005-06-30 at 00:42 -0700, Fedor Karpelevitch wrote:

<generous snip>

> any suggestions? what other information should I provide?
> 
> Fedor
> 

Fedor ... I've the same problem with an Aspire 3000 series laptop here.
Increasing RAM from "stock" (256MB up to 512 with a limit of 2GB)  gives
me a similar plethora of errors and some hardware that suddenly won't
work.  Now this is with a "repaired" DSDT loaded via intrd image.  The
stock DSDT that cannot compile runs  the larger ram but with it there is
no battery.   This is with 2.6.10 on Ubuntu and 2.6.11 on Mandriva.

James



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
