From: Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>
Subject: Re: Processor is almost never in C1 state
Date: Wed, 8 Dec 2004 13:48:49 +0100
Message-ID: <20041208124849.GA10704@message-id.gmane0305.slipkontur.de>
References: <fe1d56f504120608102afbf39b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <fe1d56f504120608102afbf39b-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

On Mon, Dec 06, 2004 at 11:10:31AM -0500, dogshu wrote:

> I have a Toshiba Portege laptop with a 500 mhz pentium-3 mobile CPU. 
> The processor is almost never is in the C1 state, and spends 99.9% of
> the time in the C2 state, even when doing heavy processing.
 
>     C1:                  promotion[C2] demotion[--] latency[000] usage[00009710]
>    *C2:                  promotion[--] demotion[C1] latency[001] usage[12232108]
>     C3:                  <not supported>
> 
> As you can see, even though the processor is being maxed out by
> burnP6, it remains in the C2 state and doesn't really use the C1 state
> at all.

The latency of C2 is very low, so there is no reason to use C1 very
often or for a prolonged amount of time.  If the Processor is doing
"real work" it is in no C-state at all (you might think of it as "C0" :-)
if i understand things correctly (please someone more knowledgeable
correct me if i am wrong).
-- 
Stefan Seyfried



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
