From: Johan Vromans <jvromans-2pNSKKP3PSKEVqv0pETR8A@public.gmane.org>
Subject: Re: Speedstep-centrino problems
Date: Thu, 10 Feb 2005 22:33:01 +0100
Message-ID: <m2zmycp0c2.fsf@phoenix.squirrel.nl>
References: <0FEA36BB2ABDF44FAAFEB7A75367C07A0117D810@alaska.condis.es>
	<200502100630.10529.galin@platformis.com>
	<420B4E31.6020306@bartol.udel.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <420B4E31.6020306-OBnUx95tOyn10jlvfTC4gA@public.gmane.org> (Rich Townsend's message of
 "Thu, 10 Feb 2005 07:06:09 -0500")
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

Rich Townsend <rhdt-OBnUx95tOyn10jlvfTC4gA@public.gmane.org> writes:

> Each
> variant has a different set of voltage characteristics, but
> unforutnately there is no way to tell which variant one has installed
> (is this actually true? How about a visual inspection?)

Dominik once gave a program called msr_is32_perf_status that reveals the
current CPU speed and voltage. I used it to find the 'real' speeds my
CPU ran (the DSDT contained wrong values).
Would that program be helpful here?

-- Johan


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
