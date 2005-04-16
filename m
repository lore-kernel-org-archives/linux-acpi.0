From: Janosch Machowinski <scotch-cGBD8117FJM@public.gmane.org>
Subject: _CST Patches
Date: Sat, 16 Apr 2005 17:25:41 +0200
Message-ID: <1113665142.7964.13.camel@scotchmobil>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-DsAJ+Ea1Z3kvUK5BM9D/"
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


--=-DsAJ+Ea1Z3kvUK5BM9D/
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hey
it's the guy with the stupid questions again ;-) 
And now I got a few answers I think... 
ACPI specification says, that every processor has a C1
state, and on page 262 is an example of an _CST package,
where the first given C state is C2. So I would suggest following patch
to the processor_idle.c Line: 611

cx.type = obj->integer.value;

+//Test if the first entry is a C1 state, if not we fake one
+if ((cx.type != ACPI_STATE_C1) && i == 1) {
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Faking C1 State"));
+		struct acpi_processor_cx c1_fake;
+		memset(&c1_fake, 0, sizeof(c1_fake));
+
+		c1_fake.address = 0;
+		c1_fake.type = ACPI_STATE_C1;
+		c1_fake.latency = 1; //How long needs a HLT instruction to execute ?
+		c1_fake.power = 0; //We don't know anything about the power
consumption so we set it to 0
+		//We copy our fake C1 state over to the power states
+		(pr->power.count)++;
+		memcpy(&(pr->power.states[pr->power.count]), &c1_fake,
sizeof(c1_fake));
+		//Finally we avoid to have morepower 				+		//states than
ACPI_PROCESSOR_MAX_POWER
+		if(count == ACPI_PROCESSOR_MAX_POWER)
+		count--;
+		
+		//c1_fake should be freed automaticaly
+
+		}
+

		if ((cx.type != ACPI_STATE_C1) &&

This patch fakes an C1 state if the given states by the _CST object
start with anything else than C1 (like on my M6NE here it start's with
C2)

By looking throug the code I also discovered some errors :
on line 492 and 539 
for (i = 0; i < ACPI_PROCESSOR_MAX_POWER; i++)
memset(pr->power.states, 0, sizeof(struct acpi_processor_cx))

my patch also replaces these lines by 
for (i = 0; i < ACPI_PROCESSOR_MAX_POWER; i++)
memset(&(pr->power.states[i]), 0, sizeof(struct acpi_processor_cx))

Greets
	Janosch Machowinski

P.S.: Note the attached file is only a diff to the original
processor_idle.c

--=-DsAJ+Ea1Z3kvUK5BM9D/
Content-Disposition: attachment; filename=_CST_fakeC1.patch
Content-Type: text/x-patch; name=_CST_fakeC1.patch; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

493c493
< 		memset(&(pr->power.states[i]), 0, sizeof(struct acpi_processor_cx));
---
> 		memset(pr->power.states, 0, sizeof(struct acpi_processor_cx));
540c540
< 		memset(&(pr->power.states[i]), 0, sizeof(struct acpi_processor_cx));
---
> 		memset(pr->power.states, 0, sizeof(struct acpi_processor_cx));
612,632d611
< 		//Test if the first entry is a C1 state, if not we fake one
< 		if ((cx.type != ACPI_STATE_C1) && i == 1) {
< 				ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Faking C1 State"));
< 				struct acpi_processor_cx c1_fake;
< 				memset(&c1_fake, 0, sizeof(c1_fake));
< 
< 				c1_fake.address = 0;
< 				c1_fake.type = ACPI_STATE_C1;
< 				c1_fake.latency = 1; //How long needs a HLT instruction to execute ?
< 				c1_fake.power = 0; //We don't know anything about the power consumption so we set it to 0
< 				//We copy our fake C1 state over to the power states
< 				(pr->power.count)++;
< 				memcpy(&(pr->power.states[pr->power.count]), &c1_fake, sizeof(c1_fake));
< 				//Finally we avoid to have more power states than ACPI_PROCESSOR_MAX_POWER
< 				if(count == ACPI_PROCESSOR_MAX_POWER)
< 				  count--;
< 				
< 				//c1_fake should be freed automaticaly
< 		}
< 
< 

--=-DsAJ+Ea1Z3kvUK5BM9D/--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
