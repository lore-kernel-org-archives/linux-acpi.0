From: Lukas Hejtmanek <xhejtman@ics.muni.cz>
Subject: Re: ACPI related Warning in 2.6.24-rc3-git2
Date: Tue, 27 Nov 2007 16:54:37 +0100
Message-ID: <20071127155437.GC4365@ics.muni.cz>
References: <20071127150557.GA4365@ics.muni.cz> <200711271637.13036.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758907AbXK0PzZ@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200711271637.13036.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>
List-Id: linux-acpi@vger.kernel.org

On Tue, Nov 27, 2007 at 04:37:12PM +0100, Rafael J. Wysocki wrote:
> > in recent kernel, I got the following warnings while booting. It's =
ACPI
> > related. Does anybode care? Lenovo ThinkPad T61 (6465CTO).
>=20
> Appropriate Ccs added.
>=20
> Did it happen before?

didn't see it in 2.6.24-rc3-git1.
=20
> > [   13.114814] Pid: 1, comm: swapper Not tainted 2.6.24-rc3-git2 #3
> > [   13.114885]=20
> > [   13.114885] Call Trace:
> > [   13.115020]  [<ffffffff80357ab6>] acpi_ut_update_ref_count+0x50/=
0x9d
> > [   13.115095]  [<ffffffff8021e7ad>] smp_call_function_single+0xbd/=
0xd0
> > [   13.115169]  [<ffffffff80331dbc>] _rdmsr_on_cpu+0x5c/0x60
> > [   13.115241]  [<ffffffff803631c7>]
> > acpi_processor_get_throttling_ptc+0xf3/0x158
> > [   13.115323]  [<ffffffff80362f04>]
> > acpi_processor_get_throttling_info+0x460/0x4af
> > [   13.115406]  [<ffffffff80362264>] acpi_processor_start+0x54a/0x6=
06
> > [   13.115478]  [<ffffffff802abc38>] ifind+0x48/0xd0
> > [   13.115550]  [<ffffffff8035a31e>] acpi_start_single_object+0x24/=
0x46
> > [   13.115622]  [<ffffffff8035b716>] acpi_device_probe+0x7d/0x91
> > [   13.115694]  [<ffffffff8038effc>] driver_probe_device+0x9c/0x1b0
> > [   13.115766]  [<ffffffff8038f2c9>] __driver_attach+0xc9/0xd0
> > [   13.115840]  [<ffffffff8038f200>] __driver_attach+0x0/0xd0
> > [   13.115924]  [<ffffffff8038e1dd>] bus_for_each_dev+0x4d/0x80
> > [   13.115994]  [<ffffffff8038e64c>] bus_add_driver+0xac/0x220
> > [   13.116080]  [<ffffffff8064dd7c>] acpi_processor_init+0x8f/0xfc
> > [   13.116153]  [<ffffffff806386f4>] kernel_init+0x154/0x330
> > [   13.116225]  [<ffffffff8020d178>] child_rip+0xa/0x12
> > [   13.116295]  [<ffffffff806385a0>] kernel_init+0x0/0x330
> > [   13.116365]  [<ffffffff8020d16e>] child_rip+0x0/0x12
> > [   13.116435]=20
> > [   13.116504] WARNING: at arch/x86/kernel/smp_64.c:397
> > smp_call_function_mask()
> > [   13.116577] Pid: 1, comm: swapper Not tainted 2.6.24-rc3-git2 #3
> > [   13.116648]=20
> > [   13.116648] Call Trace:
> > [   13.116779]  [<ffffffff80357ab6>] acpi_ut_update_ref_count+0x50/=
0x9d
> > [   13.116851]  [<ffffffff8021e4af>] smp_call_function_mask+0x8f/0x=
a0
> > [   13.116923]  [<ffffffff80331dbc>] _rdmsr_on_cpu+0x5c/0x60
> > [   13.116994]  [<ffffffff803631c7>]
> > acpi_processor_get_throttling_ptc+0xf3/0x158
> > [   13.117077]  [<ffffffff80362f04>]
> > acpi_processor_get_throttling_info+0x460/0x4af
> > [   13.117169]  [<ffffffff80362264>] acpi_processor_start+0x54a/0x6=
06
> > [   13.117248]  [<ffffffff802abc38>] ifind+0x48/0xd0
> > [   13.117330]  [<ffffffff8035a31e>] acpi_start_single_object+0x24/=
0x46
> > [   13.117402]  [<ffffffff8035b716>] acpi_device_probe+0x7d/0x91
> > [   13.117488]  [<ffffffff8038effc>] driver_probe_device+0x9c/0x1b0
> > [   13.117559]  [<ffffffff8038f2c9>] __driver_attach+0xc9/0xd0
> > [   13.117631]  [<ffffffff8038f200>] __driver_attach+0x0/0xd0
> > [   13.117715]  [<ffffffff8038e1dd>] bus_for_each_dev+0x4d/0x80
> > [   13.117786]  [<ffffffff8038e64c>] bus_add_driver+0xac/0x220
> > [   13.117856]  [<ffffffff8064dd7c>] acpi_processor_init+0x8f/0xfc
> > [   13.117941]  [<ffffffff806386f4>] kernel_init+0x154/0x330
> > [   13.118018]  [<ffffffff8020d178>] child_rip+0xa/0x12
> > [   13.118088]  [<ffffffff806385a0>] kernel_init+0x0/0x330
> > [   13.118158]  [<ffffffff8020d16e>] child_rip+0x0/0x12
> > [   13.118227]=20
> > [...]
> > [   13.124714] WARNING: at arch/x86/kernel/smp_64.c:427
> > smp_call_function_single()
> > [   13.124798] Pid: 1, comm: swapper Not tainted 2.6.24-rc3-git2 #3
> > [   13.125460]=20
> > [   13.125461] Call Trace:
> > [   13.125592]  [<ffffffff80357ab6>] acpi_ut_update_ref_count+0x50/=
0x9d
> > [   13.125665]  [<ffffffff8021e7ad>] smp_call_function_single+0xbd/=
0xd0
> > [   13.125737]  [<ffffffff80331dbc>] _rdmsr_on_cpu+0x5c/0x60
> > [   13.125807]  [<ffffffff803631c7>]
> > acpi_processor_get_throttling_ptc+0xf3/0x158
> > [   13.125903]  [<ffffffff80362f04>]
> > acpi_processor_get_throttling_info+0x460/0x4af
> > [   13.125999]  [<ffffffff80362264>] acpi_processor_start+0x54a/0x6=
06
> > [   13.126071]  [<ffffffff803625ed>] acpi_processor_add+0x24/0x6b
> > [   13.126142]  [<ffffffff8035a31e>] acpi_start_single_object+0x24/=
0x46
> > [   13.126214]  [<ffffffff8035b716>] acpi_device_probe+0x7d/0x91
> > [   13.126285]  [<ffffffff8038effc>] driver_probe_device+0x9c/0x1b0
> > [   13.126357]  [<ffffffff8038f2c9>] __driver_attach+0xc9/0xd0
> > [   13.126441]  [<ffffffff8038f200>] __driver_attach+0x0/0xd0
> > [   13.126518]  [<ffffffff8038e1dd>] bus_for_each_dev+0x4d/0x80
> > [   13.126600]  [<ffffffff8038e64c>] bus_add_driver+0xac/0x220
> > [   13.126670]  [<ffffffff8064dd7c>] acpi_processor_init+0x8f/0xfc
> > [   13.126755]  [<ffffffff806386f4>] kernel_init+0x154/0x330
> > [   13.126832]  [<ffffffff8020d178>] child_rip+0xa/0x12
> > [   13.126916]  [<ffffffff806385a0>] kernel_init+0x0/0x330
> > [   13.126986]  [<ffffffff8020d16e>] child_rip+0x0/0x12
> > [   13.127059]=20
> > [   13.127124] WARNING: at arch/x86/kernel/smp_64.c:397
> > smp_call_function_mask()
> > [   13.127197] Pid: 1, comm: swapper Not tainted 2.6.24-rc3-git2 #3
> > [   13.127267]=20
> > [   13.127268] Call Trace:
> > [   13.127398]  [<ffffffff80357ab6>] acpi_ut_update_ref_count+0x50/=
0x9d
> > [   13.127473]  [<ffffffff8021e4af>] smp_call_function_mask+0x8f/0x=
a0
> > [   13.127545]  [<ffffffff80331dbc>] _rdmsr_on_cpu+0x5c/0x60
> > [   13.127616]  [<ffffffff803631c7>]
> > acpi_processor_get_throttling_ptc+0xf3/0x158
> > [   13.127699]  [<ffffffff80362f04>]
> > acpi_processor_get_throttling_info+0x460/0x4af
> > [   13.127782]  [<ffffffff80362264>] acpi_processor_start+0x54a/0x6=
06
> > [   13.127861]  [<ffffffff803625ed>] acpi_processor_add+0x24/0x6b
> > [   13.127933]  [<ffffffff8035a31e>] acpi_start_single_object+0x24/=
0x46
> > [   13.128005]  [<ffffffff8035b716>] acpi_device_probe+0x7d/0x91
> > [   13.128076]  [<ffffffff8038effc>] driver_probe_device+0x9c/0x1b0
> > [   13.128147]  [<ffffffff8038f2c9>] __driver_attach+0xc9/0xd0
> > [   13.128226]  [<ffffffff8038f200>] __driver_attach+0x0/0xd0
> > [   13.128310]  [<ffffffff8038e1dd>] bus_for_each_dev+0x4d/0x80
> > [   13.128381]  [<ffffffff8038e64c>] bus_add_driver+0xac/0x220
> > [   13.128452]  [<ffffffff8064dd7c>] acpi_processor_init+0x8f/0xfc
> > [   13.128523]  [<ffffffff806386f4>] kernel_init+0x154/0x330
> > [   13.128594]  [<ffffffff8020d178>] child_rip+0xa/0x12
> > [   13.128664]  [<ffffffff806385a0>] kernel_init+0x0/0x330
> > [   13.128734]  [<ffffffff8020d16e>] child_rip+0x0/0x12
> >=20
> >=20
>=20
>=20
>=20
> --=20
> "Premature optimization is the root of all evil." - Donald Knuth

--=20
Luk=E1=B9 Hejtm=E1nek
