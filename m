From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Subject: Re: Opps in ACPI on VIA K7 (2.6.18)
Date: Mon, 30 Oct 2006 03:29:37 +0000
Message-ID: <1162178977.2914.15.camel@localhost.portugal>
References: <454508C1.7030308@zombino.com>
Reply-To: sergio@sergiomb.no-ip.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=sha1; protocol="application/x-pkcs7-signature"; boundary="=-QSsrGy/4DMksZY2YBWAa"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.netcabo.pt ([212.113.174.28]:17979 "EHLO
	exch01smtp10.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S1030495AbWJ3D3w (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 29 Oct 2006 22:29:52 -0500
In-Reply-To: <454508C1.7030308@zombino.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Adam Majer <adamm@zombino.com>
Cc: linux-acpi@vger.kernel.org


--=-QSsrGy/4DMksZY2YBWAa
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

may be you need this patch=20

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc2/2.=
6.19-rc2-mm2/broken-out/remove-quirk_via_abnormal_poweroff.patch

On Sun, 2006-10-29 at 14:02 -0600, Adam Majer wrote:
> Hi all,
>=20
> I get the following Opps on my K7 VIA box with acpi=3Doff. I use acpi=3Do=
ff
> as with ACPI I have *very* high software interrupt (si) load,
>=20
> top - 13:50:15 up  2:55,  6 users,  load average: 0.18, 0.23, 0.14
> Tasks:  93 total,   1 running,  92 sleeping,   0 stopped,   0 zombie
> Cpu(s): 13.9%us,  4.2%sy,  0.3%ni, 65.1%id,  1.5%wa,  0.0%hi, 15.0%si,
> 0.0%st
> Mem:   1036644k total,   938000k used,    98644k free,     1092k buffers
> Swap:   835296k total,       76k used,   835220k free,   432912k cached
>=20
>   PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
>=20
>  6240 adamm     15   0  9324 3256 2352 S  2.0  0.3   1:30.23 elinks
>=20
> and elinks is not actually doing anything.
>=20
>=20
> Anyway, the oops was captured via a null-modem cable. The kernel is the
> current Debian kernel. The Opps occurs early in the boot processes soon
> after io schedulers are registered and before any ide or nvidia modules
> loaded. The oops is,
>=20
> Initializing Cryptographic API
> io scheduler noop registered
> io scheduler anticipatory registered
> io scheduler deadline registered
> io scheduler cfq registered (default)
> PCI: Bypassing VIA 8237 APIC De-Assert Message
> BUG: unable to handle kernel NULL pointer dereference at virtual address
> 0000009c
>  printing eip:
> c01e41ee
> *pde =3D 00000000
> Oops: 0000 [#1]
> SMP
> Modules linked in:
> CPU:    0
> EIP:    0060:[<c01e41ee>]    Not tainted VLI
> EFLAGS: 00010202   (2.6.18-1-k7 #1)
> EIP is at acpi_hw_low_level_read+0x7/0x6a
> eax: 00000010   ebx: 00000001   ecx: 00000094   edx: c18e1f80
> esi: c18e1f94   edi: 00000000   ebp: 00000000   esp: c18e1f68
> ds: 007b   es: 007b   ss: 0068
> Process swapper (pid: 1, ti=3Dc18e0000 task=3Df7b44aa0 task.ti=3Dc18e0000=
)
> Stack: 00000001 c18e1f94 00000000 c01e42ae 00fb3c00 00000000 00000000
> c02b670c
>        f7fb3c00 c02b6834 c01c21b5 c02b66dc c01c1e26 f7fb3c00 c0344b6c
> 00000000
>        c01c12d0 00000000 c01003e1 c0102b46 00000202 c01002d0 00000000
> 00000000
> Call Trace:
>  [<c01e42ae>] acpi_hw_register_read+0x5d/0x177
>  [<c01c21b5>] quirk_via_abnormal_poweroff+0x11/0x36
>  [<c01c1e26>] pci_fixup_device+0x68/0x73
>  [<c01c12d0>] pci_init+0x11/0x28
>  [<c01003e1>] init+0x111/0x28e
>  [<c0102b46>] ret_from_fork+0x6/0x1c
>  [<c01002d0>] init+0x0/0x28e
>  [<c01002d0>] init+0x0/0x28e
>  [<c0101005>] kernel_thread_helper+0x5/0xb
> Code: a0 82 2d c0 76 1b 50 68 85 8c 2a c0 68 f3 00 00 00 ff 35 ac ef 28
> c0 e8 c7 80 00 00 31 d2 83 c4 10 89 d0 c3 57 85 c9 56 53 74 5d <8b>
> 71 08 8b 59 04 89 f7 09 df 74 51 c7 02 00 00 00 00 8a 09 84
> EIP: [<c01e41ee>] acpi_hw_low_level_read+0x7/0x6a SS:ESP 0068:c18e1f68
>  <0>Kernel panic - not syncing: Attempted to kill init!
>=20
>=20
> or,
>=20
>=20
> Initializing Cryptographic API
> io scheduler noop registered
> io scheduler anticipatory registered
> io scheduler deadline registered
> io scheduler cfq registered (default)
> PCI: Bypassing VIA 8237 APIC De-Assert Message
> BUG: unable to handle kernel NULL pointer dereference at virtual address
> 0000009c
>  printing eip:
> c01e2556
> *pde =3D 00000000
> Oops: 0000 [#1]
> SMP
> Modules linked in:
> CPU:    0
> EIP:    0060:[<c01e2556>]    Not tainted VLI
> EFLAGS: 00010202   (2.6.18-1-k7 #1)
> EIP is at acpi_hw_low_level_read+0x7/0x6a
> eax: 00000010   ebx: 00000001   ecx: 00000094   edx: c18e1f80
> esi: c18e1f94   edi: 00000000   ebp: 00000000   esp: c18e1f68
> ds: 007b   es: 007b   ss: 0068
> Process swapper (pid: 1, ti=3Dc18e0000 task=3Df7b43ab0 task.ti=3Dc18e0000=
)
> Stack: 00000001 c18e1f94 00000000 c01e2616 00fb2c00 00000000 00000000
> c02b46e8
>        f7fb2c00 c02b4810 c01c0525 c02b46b8 c01c0196 f7fb2c00 c0341b68
> 00000000
>        c01bf640 00000000 c01003dc c0102b46 00000202 c01002d0 00000000
> 00000000
> Call Trace:
>  [<c01e2616>] acpi_hw_register_read+0x5d/0x177
>  [<c01c0525>] quirk_via_abnormal_poweroff+0x11/0x36
>  [<c01c0196>] pci_fixup_device+0x68/0x73
>  [<c01bf640>] pci_init+0x11/0x28
>  [<c01003dc>] init+0x10c/0x289
>  [<c0102b46>] ret_from_fork+0x6/0x1c
>  [<c01002d0>] init+0x0/0x289
>  [<c01002d0>] init+0x0/0x289
>  [<c0101005>] kernel_thread_helper+0x5/0xb
> Code: a0 5e 2d c0 76 1b 50 68 f4 6a 2a c0 68 f3 00 00 00 ff 35 4c cf 28
> c0 e8 c7 80 00 00 31 d2 83 c4 10 89 d0 c3 57 85 c9 56 53 74 5d <8b>
> 71 08 8b 59 04 89 f7 09 df 74 51 c7 02 00 00 00 00 8a 09 84
> EIP: [<c01e2556>] acpi_hw_low_level_read+0x7/0x6a SS:ESP 0068:c18e1f68
>  <0>Kernel panic - not syncing: Attempted to kill init!
>=20
>=20
>=20
> If ACPI is left with default value, then everything runs correctly.
> Well, except for the high SI load. I disabled ACPI in 2.6.17 as that
> corrected the SI load situation, but acpi=3Doff causes that oops in 2.6.1=
8
> so....
>=20
> With acpi default setting, the boot process continues though this spot
> correctly,
>=20
> Initializing Cryptographic API
> io scheduler noop registered
> io scheduler anticipatory registered
> io scheduler deadline registered
> io scheduler cfq registered (default)
> PCI: Bypassing VIA 8237 APIC De-Assert Message
> isapnp: Scanning for PnP cards...
> isapnp: No Plug & Play device found
>=20
>=20
> The kernel parameters that cause the Oops are,
>=20
> Kernel command line: root=3D/dev/sdb3 acpi=3Doff ro console=3DttyS0
>=20
> and it works correctly with,
>=20
>=20
>=20
>=20
> Please let me know if you require additional information to diagnose
> this error or to test a fix. I'm not on this ML so please CC me in replie=
s.
>=20
> Thank you,
> Adam
>=20
>=20
>=20
>=20
> adamm@mira:~$ lspci -v
> 00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400/KT600 AGP]
> Host Bridge (rev 80)
>         Subsystem: Elitegroup Computer Systems Unknown device 1884
>         Flags: bus master, 66MHz, medium devsel, latency 8
>         Memory at 40000000 (32-bit, prefetchable) [size=3D1024M]
>         Capabilities: <access denied>
>=20
> 00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI Bridge (prog-if 00
> [Normal decode])
>         Flags: bus master, 66MHz, medium devsel, latency 0
>         Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=
=3D0
>         Memory behind bridge: b0000000-b1ffffff
>         Prefetchable memory behind bridge: a0000000-afffffff
>         Capabilities: <access denied>
>=20
> 00:0f.0 RAID bus controller: VIA Technologies, Inc. VIA VT6420 SATA RAID
> Controller (rev 80)
>         Subsystem: Elitegroup Computer Systems Unknown device 1884
>         Flags: bus master, medium devsel, latency 32, IRQ 185
>         I/O ports at 9000 [size=3D8]
>         I/O ports at 9400 [size=3D4]
>         I/O ports at 9800 [size=3D8]
>         I/O ports at 9c00 [size=3D4]
>         I/O ports at a000 [size=3D16]
>         I/O ports at a400 [size=3D256]
>         Capabilities: <access denied>
>=20
> 00:0f.1 IDE interface: VIA Technologies, Inc.
> VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
> (prog-if 8a [Master SecP PriP])
>         Subsystem: VIA Technologies, Inc.
> VT82C586/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE
>         Flags: bus master, medium devsel, latency 32, IRQ 185
>         I/O ports at a800 [size=3D16]
>         Capabilities: <access denied>
>=20
> 00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
> Controller (rev 81) (prog-if 00 [UHCI])
>         Subsystem: Elitegroup Computer Systems Unknown device 1884
>         Flags: bus master, medium devsel, latency 32, IRQ 177
>         I/O ports at ac00 [size=3D32]
>         Capabilities: <access denied>
>=20
> 00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
> Controller (rev 81) (prog-if 00 [UHCI])
>         Subsystem: Elitegroup Computer Systems Unknown device 1884
>         Flags: bus master, medium devsel, latency 32, IRQ 177
>         I/O ports at b000 [size=3D32]
>         Capabilities: <access denied>
>=20
> 00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
> Controller (rev 81) (prog-if 00 [UHCI])
>         Subsystem: Elitegroup Computer Systems Unknown device 1884
>         Flags: bus master, medium devsel, latency 32, IRQ 177
>         I/O ports at b400 [size=3D32]
>         Capabilities: <access denied>
>=20
> 00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
> Controller (rev 81) (prog-if 00 [UHCI])
>         Subsystem: Elitegroup Computer Systems Unknown device 1884
>         Flags: bus master, medium devsel, latency 32, IRQ 177
>         I/O ports at b800 [size=3D32]
>         Capabilities: <access denied>
>=20
> 00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86) (prog-if
> 20 [EHCI])
>         Subsystem: Elitegroup Computer Systems Unknown device 1884
>         Flags: bus master, medium devsel, latency 32, IRQ 177
>         Memory at b2000000 (32-bit, non-prefetchable) [size=3D256]
>         Capabilities: <access denied>
>=20
> 00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge
> [KT600/K8T800/K8T890 South]
>         Subsystem: Elitegroup Computer Systems Unknown device 1884
>         Flags: bus master, stepping, medium devsel, latency 0
>         Capabilities: <access denied>
>=20
> 00:11.5 Multimedia audio controller: VIA Technologies, Inc.
> VT8233/A/8235/8237 AC97 Audio Controller (rev 60)
>         Subsystem: Elitegroup Computer Systems Unknown device 1884
>         Flags: medium devsel, IRQ 193
>         I/O ports at bc00 [size=3D256]
>         Capabilities: <access denied>
>=20
> 00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II]
> (rev 78)
>         Subsystem: VIA Technologies, Inc. VT6102 [Rhine II] Embeded
> Ethernet Controller on VT8235
>         Flags: bus master, medium devsel, latency 32, IRQ 169
>         I/O ports at c400 [size=3D256]
>         Memory at b2001000 (32-bit, non-prefetchable) [size=3D256]
>         Capabilities: <access denied>
>=20
> 01:00.0 VGA compatible controller: nVidia Corporation NV31 [GeForce FX
> 5600] (rev a1) (prog-if 00 [VGA])
>         Subsystem: ASUSTeK Computer Inc. Unknown device 80e7
>         Flags: bus master, 66MHz, medium devsel, latency 248, IRQ 201
>         Memory at b0000000 (32-bit, non-prefetchable) [size=3D16M]
>         Memory at a0000000 (32-bit, prefetchable) [size=3D256M]
>         [virtual] Expansion ROM at b1000000 [disabled] [size=3D128K]
>         Capabilities: <access denied>
>=20
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--=20
S=E9rgio M.B.

--=-QSsrGy/4DMksZY2YBWAa
Content-Type: application/x-pkcs7-signature; name=smime.p7s
Content-Disposition: attachment; filename=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIGSTCCAwIw
ggJroAMCAQICAw/vkjANBgkqhkiG9w0BAQQFADBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhh
d3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVt
YWlsIElzc3VpbmcgQ0EwHhcNMDUxMTI4MjIyODU2WhcNMDYxMTI4MjIyODU2WjBLMR8wHQYDVQQD
ExZUaGF3dGUgRnJlZW1haWwgTWVtYmVyMSgwJgYJKoZIhvcNAQkBFhlzZXJnaW9Ac2VyZ2lvbWIu
bm8taXAub3JnMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEApCNuKD3pz8GRKd1q+36r
m0z7z+TBsbTrVa45UQsEeh9OQGZIASJMH5erC0u6KbKJ+km97RLOdsgSlKG6+5xuzsk+aqU7A0Gp
kMjzIJT7UH/bbPnIFMQNnWJxluuYq1u+v8iIbfezQy1+SXyAyBv+OC7LnCOiOar/L9AD9zDy2fPX
EqEDlbO3CJsoaR4Va8sgtoV0NmKnAt7DA0iZ2dmlsw6Qh+4euI+FgZ2WHPBQnfJ7PfSH5GIWl/Nx
eUqnYpDaJafk/l94nX71UifdPXDMxJJlEOGqV9l4omhNlPmsZ/zrGXgLdBv9JuPjJ9mxhgwZsZbz
VBc8emB0i3A7E6D6rwIDAQABo1kwVzAOBgNVHQ8BAf8EBAMCBJAwEQYJYIZIAYb4QgEBBAQDAgUg
MCQGA1UdEQQdMBuBGXNlcmdpb0BzZXJnaW9tYi5uby1pcC5vcmcwDAYDVR0TAQH/BAIwADANBgkq
hkiG9w0BAQQFAAOBgQBIVheRn3oHTU5rgIFHcBRxkIhOYPQHKk/oX4KakCrDCxp33XAqTG3aIG/v
dsUT/OuFm5w0GlrUTrPaKYYxxfQ00+3d8y87aX22sUdj8oXJRYiPgQiE6lqu9no8axH6UXCCbKTi
8383JcxReoXyuP000eUggq3tWr6fE/QmONUARzCCAz8wggKooAMCAQICAQ0wDQYJKoZIhvcNAQEF
BQAwgdExCzAJBgNVBAYTAlpBMRUwEwYDVQQIEwxXZXN0ZXJuIENhcGUxEjAQBgNVBAcTCUNhcGUg
VG93bjEaMBgGA1UEChMRVGhhd3RlIENvbnN1bHRpbmcxKDAmBgNVBAsTH0NlcnRpZmljYXRpb24g
U2VydmljZXMgRGl2aXNpb24xJDAiBgNVBAMTG1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBDQTEr
MCkGCSqGSIb3DQEJARYccGVyc29uYWwtZnJlZW1haWxAdGhhd3RlLmNvbTAeFw0wMzA3MTcwMDAw
MDBaFw0xMzA3MTYyMzU5NTlaMGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3Vs
dGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWlu
ZyBDQTCBnzANBgkqhkiG9w0BAQEFAAOBjQAwgYkCgYEAxKY8VXNV+065yplaHmjAdQRwnd/p/6Me
7L3N9VvyGna9fww6YfK/Uc4B1OVQCjDXAmNaLIkVcI7dyfArhVqqP3FWy688Cwfn8R+RNiQqE88r
1fOCdz0Dviv+uxg+B79AgAJk16emu59l0cUqVIUPSAR/p7bRPGEEQB5kGXJgt/sCAwEAAaOBlDCB
kTASBgNVHRMBAf8ECDAGAQH/AgEAMEMGA1UdHwQ8MDowOKA2oDSGMmh0dHA6Ly9jcmwudGhhd3Rl
LmNvbS9UaGF3dGVQZXJzb25hbEZyZWVtYWlsQ0EuY3JsMAsGA1UdDwQEAwIBBjApBgNVHREEIjAg
pB4wHDEaMBgGA1UEAxMRUHJpdmF0ZUxhYmVsMi0xMzgwDQYJKoZIhvcNAQEFBQADgYEASIzRUIPq
Cy7MDaNmrGcPf6+svsIXoUOWlJ1/TCG4+DYfqi2fNi/A9BxQIJNwPP2t4WFiw9k6GX6EsZkbAMUa
C4J0niVQlGLH2ydxVyWN3amcOY6MIE9lX5Xa9/eH1sYITq726jTlEBpbNU1341YheILcIRk13iSx
0x1G/11fZU8xggHvMIIB6wIBATBpMGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29u
c3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNz
dWluZyBDQQIDD++SMAkGBSsOAwIaBQCgXTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqG
SIb3DQEJBTEPFw0wNjEwMzAwMzI5MzdaMCMGCSqGSIb3DQEJBDEWBBReMEw3kA84pTCBs5/CsSXx
dcuHNzANBgkqhkiG9w0BAQEFAASCAQB+z9D1qCDpDCLZEPdBzfX3md7aJWilbpOOzRcbnl8/ZhEy
w33PWgs8rNw2FBl2MiRVNGtg4YpPNAON5a3zVGpW8xIuu27nlaZu1wLkC8v8ugfU5w1H+GX+AkUa
QHiS7FYT0skw9+LZvTmjyrvRJG829TccSxwvwJQr0shHPttt3sLlrJsUZI4hz+Sz1gyAuLoXWs2d
VTIs9efQ/juUrjm2LuI0PP2J1H9VzXzMilGAeq6xDAHhWsSydsYgFpiZIm3BkOsjYgD6Zsjkf6K4
vZvld7/eKl38mwJmsDrD1o9Q72K5raAlxdCn1s3icY3x4KbQDjMM+HAgcERqxYa1hxGaAAAAAAAA



--=-QSsrGy/4DMksZY2YBWAa--
