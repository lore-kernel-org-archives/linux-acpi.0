From: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>
Subject: Re: what is throttling?
Date: Wed, 6 Oct 2004 13:49:35 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20041006114935.GF17247@wotan.suse.de>
References: <20041006090408.GA17104@rap.rap.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20041006090408.GA17104-EittdKFJ/bZ/SzgSGea1oA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Keld J?rn Simonsen <keld-6PR53cSIHaE@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Oct 06, 2004 at 11:04:08AM +0200, Keld J?rn Simonsen wrote:
> Hi!
> 
> I have googled around for a couple of hours to find out precisely what
> throttling means. I did it before and found some useful information, but
> this time I did not find the relevant data.
> 
> I would like to find out, which state precisely that the CPU enters when
> throttling. Maybe it is different from CPU to CPU. Specifically I would
> like to know if the CPU is completely powered off, my recollection of
> some information I have seen earlier is that this may be the case.

On Intel CPUs Throttling means that the CPU skips each other
(or more) clock. This is quite slow, but only done to get 
the temperature down.

AMD CPUs don't have it afaik.

-Andi


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
