From: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>
Subject: Re: what is throttling?
Date: Wed, 6 Oct 2004 16:23:58 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20041006142358.GO17247@wotan.suse.de>
References: <20041006090408.GA17104@rap.rap.dk> <20041006114935.GF17247@wotan.suse.de> <20041006141245.GB6785@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20041006141245.GB6785-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Oct 06, 2004 at 04:12:45PM +0200, Bruno Ducrot wrote:
> On Wed, Oct 06, 2004 at 01:49:35PM +0200, Andi Kleen wrote:
> > AMD CPUs don't have it afaik.
> 
> ducrot@poupoune:~$ cat /proc/acpi/processor/CPU1/throttling 
> state count:             8
> active state:            T0
> states:
>    *T0:                  00%
>     T1:                  12%
>     T2:                  25%
>     T3:                  37%
>     T4:                  50%
>     T5:                  62%
>     T6:                  75%
>     T7:                  87%
> 
> though I don't see real usefullness for throttling anyway, so
> I've not tested if that works.

Indeed. It seems to work different from the Intel implementation
though, it doesn't skip clocks.

It's only useful to prevent your machine from melting when the 
fan fails or someone misdesigns the cooling setup.

-Andi


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
