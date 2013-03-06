From: Dirk Brandewie <dirk.brandewie@gmail.com>
Subject: Re: intel-pstate driver blows up if
	cpufreq_register_driver fails.
Date: Tue, 5 Mar 2013 16:21:12 -0800
Message-ID: <CANOOhLRPwBsuk=3ceX2YgPnL=R2WsNUtAJcgj-hPyTFf8YLCgw@mail.gmail.com>
References: <20130305182541.GC24062@phenom.dumpdata.com>
	<1963152.0L5Apfde8A@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1948481524990211170=="
Return-path: <xen-devel-bounces@lists.xen.org>
In-Reply-To: <1963152.0L5Apfde8A@vostro.rjw.lan>
List-Unsubscribe: <http://lists.xen.org/cgi-bin/mailman/options/xen-devel>,
	<mailto:xen-devel-request@lists.xen.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xen.org>
List-Help: <mailto:xen-devel-request@lists.xen.org?subject=help>
List-Subscribe: <http://lists.xen.org/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xen.org?subject=subscribe>
Sender: xen-devel-bounces@lists.xen.org
Errors-To: xen-devel-bounces@lists.xen.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
List-Id: linux-acpi@vger.kernel.org

--===============1948481524990211170==
Content-Type: multipart/alternative; boundary=f46d0443046650459d04d73691ae

--f46d0443046650459d04d73691ae
Content-Type: text/plain; charset=ISO-8859-1

On Tuesday, March 5, 2013, Rafael J. Wysocki wrote:

> Hi,
>
> Thanks for the report!
>
> Dirk, can you please have a look at that?


The patch for this should be some where deeper in your inbox

--Dirk


>
> Rafael
>
>
> On Tuesday, March 05, 2013 01:25:41 PM Konrad Rzeszutek Wilk wrote:
> > This is what we get:
> >
> > [   14.429235] calling  intel_pstate_init+0x0/0x14d @ 1^M^M
> > [   14.434268] Intel P-state driver initializing.^M^M
> > [   14.438775] BUG: unable to handle kernel NULL pointer dereference at
> 0000000000000030^M^M
> > [   14.446649] IP: [<ffffffff8121a254>] sysfs_remove_group+0x14/0x100^M^M
> > [   14.452889] PGD 0 ^M^M
> > [   14.454968] Oops: 0000 [#1] SMP ^M^M
> > [   14.458261] Modules linked in:^M^M
> > [   14.461382] CPU 0 ^M^M
> > [   14.463204] Pid: 1, comm: swapper/0 Not tainted
> 3.9.0-rc1upstream-00021-g9e952b4-dirty #8 MSI MS-7680/H61M-P23 (MS-7680)^M^M
> > [   14.474382] RIP: e030:[<ffffffff8121a254>]  [<ffffffff8121a254>]
> sysfs_remove_group+0x14/0x100^M^M
> > [   14.483048] RSP: e02b:ffff8801e3489e58  EFLAGS: 00010296^M^M
> > [   14.488422] RAX: 00000000ffffffed RBX: ffffffff81a7cd80 RCX:
> 0000000000000000^M^M
> > [   14.495614] RDX: 0000000000000000 RSI: ffffffff81a7cd80 RDI:
> 0000000000000000^M^M
> > [   14.502806] RBP: ffff8801e3489e78 R08: 0000000000000001 R09:
> 0000000000000008^M^M
> > [   14.510001] R10: 0000000000000008 R11: 00000000fffffffa R12:
> 0000000000000000^M^M
> > [   14.517194] R13: ffffffff81afac08 R14: 000000014c7ca386 R15:
> 0000000000000000^M^M
> > [   14.524389] FS:  00007f49debd2700(0000) GS:ffff8801f0e00000(0000)
> knlGS:0000000000000000^M^M
> > [   14.532532] CS:  e033 DS: 0000 ES: 0000 CR0: 0000000080050033^M^M
> > [   14.538340] CR2: 0000000000000030 CR3: 0000000001a0c000 CR4:
> 0000000000042660^M^M
> > [   14.545531] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000^M^M
> > [   14.552724] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7:
> 0000000000000400^M^M
> > [   14.559918] Process swapper/0 (pid: 1, threadinfo ffff8801e3488000,
> task ffff8801e347c800)^M^M
> > [   14.568237] Stack:^M^M
> > [   14.570316]  00000000ffffffed ffffffff81a9d520 ffffffff81afac08
> 000000014c7ca386^M^M
> > [   14.577771]  ffff8801e3489ea8 ffffffff814e8690 00000000ffffffff
> 00000000ffffffed^M^M
> > [   14.585223]  ffffffff81a9d520 ffffffff81afac08 ffff8801e3489ec8
> ffffffff81afad42^M^M
> > [   14.592677] Call Trace:^M^M
> > [   14.595193]  [<ffffffff81afac08>] ? cpufreq_p4_init+0x55/0x55^M^M
> > [   14.601000]  [<ffffffff814e8690>] intel_pstate_exit+0x20/0xd0^M^M
> > [   14.606805]  [<ffffffff81afac08>] ? cpufreq_p4_init+0x55/0x55^M^M
> > [   14.612612]  [<ffffffff81afad42>] intel_pstate_init+0x13a/0x14d^M^M
> > [   14.618593]  [<ffffffff81002124>] do_one_initcall+0x124/0x170^M^M
> > [   14.624396]  [<ffffffff81ac1a03>] kernel_init_freeable+0x157/0x1e6^M^M
> > [   14.630635]  [<ffffffff81ac1a92>] ?
> kernel_init_freeable+0x1e6/0x1e6^M^M
> > [   14.637050]  [<ffffffff8165add0>] ? rest_init+0xa0/0xa0^M^M
> > [   14.642337]  [<ffffffff8165add9>] kernel_init+0x9/0xf0^M^M
> > [   14.647538]  [<ffffffff8167c9fc>] ret_from_fork+0x7c/0xb0^M^M
> > [   14.652998]  [<ffffffff8165add0>] ? rest_init+0xa0/0xa0^M^M
> > [   14.658282] Code: 1f 84 00 00 00 00 00 55 48 89 f2 31 f6 48 89 e5 e8
> e2 fd ff ff c9 c3 55 48 89 e5 41 56 41 55 41 54 49 89 fc 53 48 8b 16 48 89
> f3 <4c> 8b 77 30 48 85 d2 0f 84 87 00 00 00 31 f6 4c 89 f7 e8 d5 e3 ^M^M
> > [   14.677174] RIP  [<ffffffff8121a254>]
> sysfs_remove_group+0x14/0x100^M^M
> > [   14.683498]  RSP <ffff8801e3489e58>^M^M
> > [   14.687052] CR2: 0000000000000030^M^M
> > [   14.690450] ---[ end trace 104ea7a191a991d2 ]---^M^M
> > [   14.695120] swapper/0 (1) used greatest stack depth: 3688 bytes
> left^M^M
> > [   14.701532] Kernel panic - not syncing: Attempted to kill init!
> exitcode=0x00000009^M^M
> >
> >
> > The cpufreq is disabled, so we end up with:
> >
> > 797         rc = cpufreq_register_driver(&intel_pstate_driver);
> > 798         if (rc)
> > 799                 goto out;
> > 800
> > 801         intel_pstate_debug_expose_params();
> > 802         intel_pstate_sysfs_expose_params();
> > 803         return rc;
> > 804 out:
> > 805         intel_pstate_exit();
> > 806     > --
> > To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> > the body of a message to majordomo@vger.kernel.org <javascript:;>
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> I speak only for myself.
> Rafael J. Wysocki, Intel Open Source Technology Center.
>

--f46d0443046650459d04d73691ae
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br>On Tuesday, March 5, 2013, Rafael J. Wysocki  wrote:<br><blockquote=
 class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc soli=
d;padding-left:1ex">Hi,<br>
<br>
Thanks for the report!<br>
<br>
Dirk, can you please have a look at that?</blockquote><div><br></div><div>T=
he patch for this should be some where deeper in your inbox</div><div><br><=
/div><div>--Dirk</div><div><span></span>=A0</div><blockquote class=3D"gmail=
_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:=
1ex">

<br>
Rafael<br>
<br>
<br>
On Tuesday, March 05, 2013 01:25:41 PM Konrad Rzeszutek Wilk wrote:<br>
&gt; This is what we get:<br>
&gt;<br>
&gt; [ =A0 14.429235] calling =A0intel_pstate_init+0x0/0x14d @ 1^M^M<br>
&gt; [ =A0 14.434268] Intel P-state driver initializing.^M^M<br>
&gt; [ =A0 14.438775] BUG: unable to handle kernel NULL pointer dereference=
 at 0000000000000030^M^M<br>
&gt; [ =A0 14.446649] IP: [&lt;ffffffff8121a254&gt;] sysfs_remove_group+0x1=
4/0x100^M^M<br>
&gt; [ =A0 14.452889] PGD 0 ^M^M<br>
&gt; [ =A0 14.454968] Oops: 0000 [#1] SMP ^M^M<br>
&gt; [ =A0 14.458261] Modules linked in:^M^M<br>
&gt; [ =A0 14.461382] CPU 0 ^M^M<br>
&gt; [ =A0 14.463204] Pid: 1, comm: swapper/0 Not tainted 3.9.0-rc1upstream=
-00021-g9e952b4-dirty #8 MSI MS-7680/H61M-P23 (MS-7680)^M^M<br>
&gt; [ =A0 14.474382] RIP: e030:[&lt;ffffffff8121a254&gt;] =A0[&lt;ffffffff=
8121a254&gt;] sysfs_remove_group+0x14/0x100^M^M<br>
&gt; [ =A0 14.483048] RSP: e02b:ffff8801e3489e58 =A0EFLAGS: 00010296^M^M<br=
>
&gt; [ =A0 14.488422] RAX: 00000000ffffffed RBX: ffffffff81a7cd80 RCX: 0000=
000000000000^M^M<br>
&gt; [ =A0 14.495614] RDX: 0000000000000000 RSI: ffffffff81a7cd80 RDI: 0000=
000000000000^M^M<br>
&gt; [ =A0 14.502806] RBP: ffff8801e3489e78 R08: 0000000000000001 R09: 0000=
000000000008^M^M<br>
&gt; [ =A0 14.510001] R10: 0000000000000008 R11: 00000000fffffffa R12: 0000=
000000000000^M^M<br>
&gt; [ =A0 14.517194] R13: ffffffff81afac08 R14: 000000014c7ca386 R15: 0000=
000000000000^M^M<br>
&gt; [ =A0 14.524389] FS: =A000007f49debd2700(0000) GS:ffff8801f0e00000(000=
0) knlGS:0000000000000000^M^M<br>
&gt; [ =A0 14.532532] CS: =A0e033 DS: 0000 ES: 0000 CR0: 0000000080050033^M=
^M<br>
&gt; [ =A0 14.538340] CR2: 0000000000000030 CR3: 0000000001a0c000 CR4: 0000=
000000042660^M^M<br>
&gt; [ =A0 14.545531] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000=
000000000000^M^M<br>
&gt; [ =A0 14.552724] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000=
000000000400^M^M<br>
&gt; [ =A0 14.559918] Process swapper/0 (pid: 1, threadinfo ffff8801e348800=
0, task ffff8801e347c800)^M^M<br>
&gt; [ =A0 14.568237] Stack:^M^M<br>
&gt; [ =A0 14.570316] =A000000000ffffffed ffffffff81a9d520 ffffffff81afac08=
 000000014c7ca386^M^M<br>
&gt; [ =A0 14.577771] =A0ffff8801e3489ea8 ffffffff814e8690 00000000ffffffff=
 00000000ffffffed^M^M<br>
&gt; [ =A0 14.585223] =A0ffffffff81a9d520 ffffffff81afac08 ffff8801e3489ec8=
 ffffffff81afad42^M^M<br>
&gt; [ =A0 14.592677] Call Trace:^M^M<br>
&gt; [ =A0 14.595193] =A0[&lt;ffffffff81afac08&gt;] ? cpufreq_p4_init+0x55/=
0x55^M^M<br>
&gt; [ =A0 14.601000] =A0[&lt;ffffffff814e8690&gt;] intel_pstate_exit+0x20/=
0xd0^M^M<br>
&gt; [ =A0 14.606805] =A0[&lt;ffffffff81afac08&gt;] ? cpufreq_p4_init+0x55/=
0x55^M^M<br>
&gt; [ =A0 14.612612] =A0[&lt;ffffffff81afad42&gt;] intel_pstate_init+0x13a=
/0x14d^M^M<br>
&gt; [ =A0 14.618593] =A0[&lt;ffffffff81002124&gt;] do_one_initcall+0x124/0=
x170^M^M<br>
&gt; [ =A0 14.624396] =A0[&lt;ffffffff81ac1a03&gt;] kernel_init_freeable+0x=
157/0x1e6^M^M<br>
&gt; [ =A0 14.630635] =A0[&lt;ffffffff81ac1a92&gt;] ? kernel_init_freeable+=
0x1e6/0x1e6^M^M<br>
&gt; [ =A0 14.637050] =A0[&lt;ffffffff8165add0&gt;] ? rest_init+0xa0/0xa0^M=
^M<br>
&gt; [ =A0 14.642337] =A0[&lt;ffffffff8165add9&gt;] kernel_init+0x9/0xf0^M^=
M<br>
&gt; [ =A0 14.647538] =A0[&lt;ffffffff8167c9fc&gt;] ret_from_fork+0x7c/0xb0=
^M^M<br>
&gt; [ =A0 14.652998] =A0[&lt;ffffffff8165add0&gt;] ? rest_init+0xa0/0xa0^M=
^M<br>
&gt; [ =A0 14.658282] Code: 1f 84 00 00 00 00 00 55 48 89 f2 31 f6 48 89 e5=
 e8 e2 fd ff ff c9 c3 55 48 89 e5 41 56 41 55 41 54 49 89 fc 53 48 8b 16 48=
 89 f3 &lt;4c&gt; 8b 77 30 48 85 d2 0f 84 87 00 00 00 31 f6 4c 89 f7 e8 d5 =
e3 ^M^M<br>

&gt; [ =A0 14.677174] RIP =A0[&lt;ffffffff8121a254&gt;] sysfs_remove_group+=
0x14/0x100^M^M<br>
&gt; [ =A0 14.683498] =A0RSP &lt;ffff8801e3489e58&gt;^M^M<br>
&gt; [ =A0 14.687052] CR2: 0000000000000030^M^M<br>
&gt; [ =A0 14.690450] ---[ end trace 104ea7a191a991d2 ]---^M^M<br>
&gt; [ =A0 14.695120] swapper/0 (1) used greatest stack depth: 3688 bytes l=
eft^M^M<br>
&gt; [ =A0 14.701532] Kernel panic - not syncing: Attempted to kill init! e=
xitcode=3D0x00000009^M^M<br>
&gt;<br>
&gt;<br>
&gt; The cpufreq is disabled, so we end up with:<br>
&gt;<br>
&gt; 797 =A0 =A0 =A0 =A0 rc =3D cpufreq_register_driver(&amp;intel_pstate_d=
river);<br>
&gt; 798 =A0 =A0 =A0 =A0 if (rc)<br>
&gt; 799 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;<br>
&gt; 800<br>
&gt; 801 =A0 =A0 =A0 =A0 intel_pstate_debug_expose_params();<br>
&gt; 802 =A0 =A0 =A0 =A0 intel_pstate_sysfs_expose_params();<br>
&gt; 803 =A0 =A0 =A0 =A0 return rc;<br>
&gt; 804 out:<br>
&gt; 805 =A0 =A0 =A0 =A0 intel_pstate_exit();<br>
&gt; 806 =A0 =A0 &gt; --<br>
&gt; To unsubscribe from this list: send the line &quot;unsubscribe linux-a=
cpi&quot; in<br>
&gt; the body of a message to <a href=3D"javascript:;" onclick=3D"_e(event,=
 &#39;cvml&#39;, &#39;majordomo@vger.kernel.org&#39;)">majordomo@vger.kerne=
l.org</a><br>
&gt; More majordomo info at =A0<a href=3D"http://vger.kernel.org/majordomo-=
info.html" target=3D"_blank">http://vger.kernel.org/majordomo-info.html</a>=
<br>
--<br>
I speak only for myself.<br>
Rafael J. Wysocki, Intel Open Source Technology Center.<br>
</blockquote>

--f46d0443046650459d04d73691ae--


--===============1948481524990211170==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Xen-devel mailing list
Xen-devel@lists.xen.org
http://lists.xen.org/xen-devel

--===============1948481524990211170==--
