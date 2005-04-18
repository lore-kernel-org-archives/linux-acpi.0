From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: Re: _CST implementation
Date: Mon, 18 Apr 2005 19:25:54 +0200
Message-ID: <4263EDA2.4030106@suse.de>
References: <1113598244.8367.30.camel@scotchmobil> <20050418120744.GG2298@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050418120744.GG2298-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: Janosch Machowinski <scotch-cGBD8117FJM@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Bruno Ducrot wrote:
> On Fri, Apr 15, 2005 at 10:50:44PM +0200, Janosch Machowinski wrote:
...
> 
>>Oh I almost forgot another question : 
>>About the validation of the C states. At the moment it is tested if the
>>latency of C2 if under 100 and if C3 latency is under 1000 but the
>>ACPI-Spec says that "There is no latency restrictions" so why do you do
>>this ? (My notebook hat a C3 latency of 1001)
> 
> Normally you are right, but unfortunately there are still some strange
> misread of the specification by bios writters in that regard.  Therefore
> if for C3 the latency is 1001 even if given by _CST, we should disable
> it.
> 

My spec says (Revision 3.0, September 2, 2004):
The worst-case hardware latency for this state is declared in the FADT
(p. 257).

And there they say (p. 98):
The worst-case hardware latency, in microseconds, to enter and
exit a C2 state. A value > 100 indicates the system does not
support a C2 state.
The worst-case hardware latency, in microseconds, to enter and
exit a C3 state. A value > 1000 indicates the system does not
support a C3 state.

     Thomas


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
