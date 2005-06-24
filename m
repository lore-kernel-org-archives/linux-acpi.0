From: Josh Green <josh-momsFTegVwnNLxjTenLetw@public.gmane.org>
Subject: Re: Extreme latency issues when fan kicks in on a Z71V laptop
Date: Thu, 23 Jun 2005 21:48:52 -0700
Message-ID: <1119588532.20644.5.camel@SillyPuddy.localdomain>
References: <1119349986.16343.26.camel@SillyPuddy.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ODFnNTXbIxh/m2OlPK3j"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1119349986.16343.26.camel-y/iEnC32RtTVaArFeby7KQ0JkcsJGQge@public.gmane.org>
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


--=-ODFnNTXbIxh/m2OlPK3j
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

An update on this issue.  I traced down which ACPI events are being
executed in acpi_psx_execute.  It seems that when the fan kicks into
high speed there are 2 methods that get called very rapidly (I counted
360 executes within a few seconds).  First "_L00" gets executed followed
by "_TMP", and this happens over and over again.  Here are the relevant
methods from my DSDT (decoded into DSL).  I've placed my complete dsdt
and dsl files at the following 2 links, for those interested:
http://resonance.org/~josh/ASUS-Z71V.dsdt
http://resonance.org/~josh/ASUS-Z71V.dsl


                Scope (\_GPE)
                {
                    Method (_L00, 0, Serialized)
                    {
                        \_TZ.TCHG ()
                        Notify (\_TZ.THRM, 0x80)
                    }
                }

...
                    ThermalZone (THRM)
                    {
                        Method (_CRT, 0, NotSerialized)
                        {
                            Return (KELV (TCRT))
                        }

                        Method (_TMP, 0, NotSerialized)
                        {
                            Store (0x05, Local1)
                            While (Local1)
                            {
                                Store (RTMP (), Local0)
                                If (LGreater (Local0, TCRT))
                                {
                                    Decrement (Local1)
                                }
                                Else
                                {
                                    Store (0x00, Local1)
                                }
                            }

                            Return (KELV (Local0))
                        }
...


I put in a little hack into acpi_psx_execute to just ignore all _L00
events, but apparently this needs to be blocked (or slowed down) further
up the chain, because latency is still really bad.  An oprofile of
vmlinux now shows:

CPU: PIII, speed 1955.53 MHz (estimated)
Counted CPU_CLK_UNHALTED events (clocks processor is not halted) with a
unit mask of 0x00 (No unit mask) count 100000
samples  %        symbol name
217465   23.9865  acpi_os_read_port
107297   11.8349  sysenter_past_esp
104366   11.5116  schedule
98054    10.8154  mask_and_ack_8259A
76999     8.4930  acpi_os_write_port
53767     5.9305  dequeue_task
30784     3.3955  sub_preempt_count
27171     2.9970  enable_8259A_irq
24006     2.6479  irq_entries_start
23479     2.5897  enqueue_task
21135     2.3312  sys_sched_yield
17330     1.9115  add_preempt_count
16985     1.8735  sched_clock
13813     1.5236  get_offset_pmtmr
9074      1.0009  buffered_rmqueue


Any ideas on ways to fix this (both proper and improper :)  I'd really
appreciate the suggestions.  I'm curious how these events originate, and
if the speed of occurrence I'm experiencing is normal.  Cheers.
	Josh Green



On Tue, 2005-06-21 at 03:33 -0700, Josh Green wrote:=20
> Hello,
> I recently bought an ASUS Z71V based laptop.  I've been having problems
> when running 3D intensive applications.  When playing a 3D game, the
> cooling fan will sometimes kick into high gear.  When this happens the
> machine can stall for sometimes several seconds, during which time it is
> completely unresponsive.  The fan will then slow down again and things
> will once again be fine, then kick in again, stall.. stall.. etc.
>=20
> Details of my system:
> Pentium M 1.86GHz CPU
> NVidia GeForce Go 6600 PCI-E card
> Linux kernel 2.6.11-gentoo-r9
> gcc 3.3.4
> glibc 2.3.4.20040808
>=20
> I'm using the acpi_cpufreq module for CPU frequency control.
>=20
> I've verified that the CPU is at a constant temperature of 59C, so I=20
> don't believe the CPU is being throttled (active state does not change
> in /proc/acpi/processor/CPU1/throttling).  The correlation does not
> appear to be related to CPU usage either, since I can do heavy compiles
> without the fan kicking in, its only with heavy 3D apps.
>=20
> I ran oprofile to try and get an idea of what could be hanging the
> system.  I ran it for a brief amount of time during the occurrence of
> the problem.  The report showed that the kernel consumed ~45%,
> libGLcore.so ~40%, ~9% for the game binary, ~2% nvidia module, etc.
>=20
> Excerpt of vmlinux kernel symbol profile:
>=20
> CPU: PIII, speed 1955.68 MHz (estimated)
> Counted CPU_CLK_UNHALTED events (clocks processor is not halted) with a
> unit mask of 0x00 (No unit mask) count 100000
> samples  %        symbol name
> 31698    13.4055  acpi_ut_callocate
> 24138    10.2082  kfree
> 24133    10.2061  __kmalloc
> 13162     5.5664  acpi_ns_search_node
> 10561     4.4664  delay_pmtmr
> 9678      4.0929  acpi_ps_parse_loop
> 6840      2.8927  acpi_os_read_port
> 6036      2.5527  acpi_ps_get_opcode_info
> 4690      1.9835  acpi_ut_update_object_reference
> 4249      1.7970  schedule
> 3831      1.6202  acpi_ns_get_parent_node
> 3778      1.5978  sysenter_past_esp
> 3551      1.5018  acpi_ds_method_data_init
> 3521      1.4891  acpi_ut_acquire_from_cache
> 3380      1.4294  acpi_ns_delete_namespace_by_owner
> 3160      1.3364  acpi_ns_get_next_node
> 2731      1.1550  acpi_ds_exec_end_op
> 2717      1.1491  acpi_os_allocate
> 2614      1.1055  acpi_ds_exec_begin_op
> 2597      1.0983  mask_and_ack_8259A
> ...
>=20
> If you would like to see the complete output, I've put it here:
> http://resonance.org/~josh/acpi_oprofile.txt
>=20
> So it appears that ACPI related code is consuming quite a lot of CPU
> when the problem is occurring.  My guess is that an event of some sort
> is being generated rather rapidly and causing system CPU starvation.
> Any ideas?  Thanks in advance for help on resolving this issue.  I'm a
> semi-competent programmer with some kernel experience, so I can do some
> additional probing/tests with a little guidance.
> Best regards,
> 	Josh Green
>=20


--=-ODFnNTXbIxh/m2OlPK3j
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCu5C0RoMuWKCcbgQRAh1zAJ9zGzOF9rWdW2PzHusAmgKetWQIcQCeKqNH
yi2rvweaZlbrnaDMySevWF4=
=hAnq
-----END PGP SIGNATURE-----

--=-ODFnNTXbIxh/m2OlPK3j--



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
