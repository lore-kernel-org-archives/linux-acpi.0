From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: ACPI processor module enhancements
Date: Fri, 8 Oct 2004 16:12:45 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B3001A19151@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Pallipadi, Venkatesh" <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Dominik,
Thanks for the list.
I should probably merge it with the even longer one I have and post it.

Re: ACPI 3.0 features
I think the ACPI 3.0 features will be evolutional.
I'll be most comfortable with new ACPI 3.0 code when
there are systems available to test that we got it right.
I'm not very eager to ship Linux code written to the spec just to
discover
later that the BIOS writers read the spec a different way;
but I know that is a risk we need to take sometimes.

>Hi,
>
>This is meant as sort of a "TODO list" for the ACPI processor=20
>module. There are several areas which are in need of improvement -- and

>coordination. To keep in Linux tradition, I've tried to split them up
so that small
>incremental patches are possible:
>
>
>1.) utilize pstate_cnt to notify the BIOS that a P-State=20
>driver is present
>This has already been brought up on this list, last in this thread:
>http://marc.theaimsgroup.com/?l=3Dacpi4linux&m=3D109428989121089&w=3D2

Do you think we've reached the end of that discussion
and we should put the patch in the release for broader testing?

>2.) support for _CST [more, dynamically configurable CPU power=20
>states] on UP
>Patch is at http://bugme.osdl.org/show_bug.cgi?id=3D1958 -- Bruno's
>"non-dynamic" patch instead of mine is the way to go...

Agreed, this is in the pipeline.

>3.) improved CPU power state selection algorithm
>Some ideas are in my patch=20
>http://bugme.osdl.org/show_bug.cgi?id=3D1958 , it
>needs adaption to TODO#2 and further evaluation, though.

Do you refer to C-states or P-states here?
We have a couple of things we need to fix on C-states.
eg. Bob Moore is testing a patch to fix the bus-master activity part.

>4.) _OSC / _PDC framework
>The _PDC / _OSC methods added in ACPI v. 3.0 are a bit tricky to handle
>because of the modularization in Linux. Basically we need a=20
>
>unsigned int acpi_processor_osc_update()
>
>which only adds something to a saved buffer. If the driver=20
>requests some
>"control" by calling acpi_processor_osc_update(), the latter=20
>should lock the
>driver by "try_module_get()".

We do see _PDC in the field, but I haven't seen _OSC yet.

>5.) _{P,T,C}SD groundwork
>some=20
>
>acpi_status acpi_processor_get_domain(..., cpumask_t *cpus, u8 *type);
>
>is needed which a) determines the domain of the CPU passed as argument,
>b) walks through all detected processor objects and looks for=20
>the other CPUs
>in this domain [this asserts that all CPUs are initialized as=20
>required by
>ACPI spec v.3.0 p.273], c) converts the ACPI CPU numbers to=20
>Linux kernel CPU
>numbers, and d) converts this to a cpumask_t

I think we'll only get this right when we can test it on hardware that
supports this.  I expect we'll see that hardware in 2005.

>6.) Utilizing _PSD in the ACPI perflib
>
>The cpufreq core is (almost) ready for handling domains, so=20
>it'll be only a
>question of cpufreq driver support for domain ahndling. A helper like
>
>acpi_for_domain_do_fn(cpumask_t domain; (int) (*fn) (unsigned=20
>int cpu, cpumask_t allowed_maskm void *), void *data, int type) {
>	int ret =3D -EINVAL;
>	/* we encourage type ANY as it is faster */
>	if (likely(type =3D=3D ANY)) {=20
>		ret =3D fn(find_first_bit(domain), domain, data)
>	} else {
>		for_each_cpu_mask(cpu, domain) {
>			ret =3D fn(cpu, cpu_mask_of_cpu(cpu), data)
>			if (ret)
>				return (ret);
>		}
>	}
>	return (ret);
>}
>
>or something like that may be of assistance here.
>
>
>7.) Support for C2-type sleep on multiprocessor systems.
>
>Already previous versions of the ACPI specification can support that in
>theory, though SMT awareness requires _CSD handling.

I haven't seen any HT or MP systems that support C2.
Maybe those p4-based laptops do?  I agree that MP/MT
support is important.  However, I'm not sure that
software coordination of C-states is mandatory.

>8.) Support for WBINVD-based C3
>
>Only enabled on UP if users explicitely requests it, but=20
>always available
>on multiprocessor systems.

IIR Luming was looking into this area.

>9.) throttling support using _PTC/_TSS/_TPC on UP
>Currently only the P_CNT method is available.
>
>
>10.) Make throttling multiprocessor-aware utilizing _TSD
>
>
>11.) [or maybe much much earlier?] split up drivers/acpi/processor.c in
>     individual files and modules:
>	- core
>	- C-States handling
>	- T-States handling
>	- ACPI perflib

I agree with Venki that if this list is prioritized, that this one
should be at the top instead of the bottom -- it doesn't depend
on any new specs or any new hardware.
For a long time I've wanted processor.c to be split up into
separate source files, as different parts have nothing to do
with each other.  (I want "idle" to be in the file name for c-states;-)
I hadn't thought about splitting it into different modules.
On systems with broken c-states and working p-states it would
certainly be handy to be able to unload c-states w/o unloading
p-states...

cheers,
-Len


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
