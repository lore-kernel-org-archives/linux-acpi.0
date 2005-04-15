From: Janosch Machowinski <scotch-cGBD8117FJM@public.gmane.org>
Subject: _CST implementation
Date: Fri, 15 Apr 2005 22:50:44 +0200
Message-ID: <1113598244.8367.30.camel@scotchmobil>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Hey, 
im new to ACPI, so please be patient with my stupid questions ;-)
I spend a little time in debugging my kernel ACPI and reading the 3.0
specs... Now I am wondering about some pieces of the implementation. 
First of all in processor_idle.c in the funktion
acpi_processor_get_power_info_cst there is a test if the power.count is
less than 2. Why do you test on 2 and not on 1 ? As far 
as I can see 1 would be an valid value. 

The next question is about these lines : 
for (i = 0; i < ACPI_PROCESSOR_MAX_POWER; i++)
	memset(pr->power.states, 0, sizeof(struct acpi_processor_cx));
what's the sense in doing this up to 8 times ? 
shouldn't it be
for (i = 0; i < ACPI_PROCESSOR_MAX_POWER; i++)
       memset(pr->power.states[i], 0, sizeof(struct acpi_processor_cx));
?

The next question is about the ACPI_PROCESSOR_MAX_POWER constant.
The ACPI specification says, that the C states can be expanded "to an
arbitary number of power states" so why do you limit them ? 

And another one about these lines :
cx.address = (reg->space_id == ACPI_ADR_SPACE_FIXED_HARDWARE) ?
			0 : reg->address;
Why is the adress set to 0 in case it is a fixed hardware adress ? 
And why can only C1 have an fixed hardware adress ?

Okay the last thing I am curious about is how should _CST work, 
at the moment the code deletes all known power states (or tries it)
(hm by the way, this could be the reason why the IBM t40 crashes)
and writes all power states given by the _CST object to the
acpi_processor structure. Is this the way it is mentioned to be ? 
I couldn't figure out (of the ACPI Spec), if there could also be a way
of incremental generation of the C states. 

Oh I almost forgot another question : 
About the validation of the C states. At the moment it is tested if the
latency of C2 if under 100 and if C3 latency is under 1000 but the
ACPI-Spec says that "There is no latency restrictions" so why do you do
this ? (My notebook hat a C3 latency of 1001)

Greets
	Janosch Machowinski

P.S.: Sorry about my bad english



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
