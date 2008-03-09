From: Laurent Riffard <laurent.riffard@free.fr>
Subject: Re: linux-next: Tree for March 6: acpi_os_wait_semaphore tries to
 register non-static key
Date: Sun, 09 Mar 2008 09:39:07 +0100
Message-ID: <47D3A22B.10207@free.fr>
References: <20080306162606.970aefe1.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp4-g19.free.fr ([212.27.42.30]:59107 "EHLO smtp4-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750869AbYCIIjJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 9 Mar 2008 04:39:09 -0400
In-Reply-To: <20080306162606.970aefe1.sfr@canb.auug.org.au>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Cc: linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Le 06.03.2008 06:26, Stephen Rothwell a =E9crit :
> Hi all,
>=20
> I have created today's linux-next tree at
> git://git.kernel.org/pub/scm/linux/kernel/git/sfr/linux-next.git

got this with next-20080306 and next-20080307:

INFO: trying to register non-static key.
the code is fine but needs lockdep annotation.
turning off the locking correctness validator.
Pid: 0, comm: swapper Not tainted 2.6.25-rc4-next-20080306-02654-g4855c=
7e #25
 [<c012fb3e>] __lock_acquire+0x145/0xaa9
 [<c015566e>] cache_alloc_debugcheck_after+0xdd/0x14e
 [<c01568dd>] kmem_cache_alloc+0x7f/0xca
 [<c01307f5>] lock_acquire+0x4c/0x63
 [<c01291e9>] down_trylock+0x9/0x23
 [<c02915ae>] _spin_lock_irqsave+0x2a/0x39
 [<c01291e9>] down_trylock+0x9/0x23
 [<c01291e9>] down_trylock+0x9/0x23
 [<c01eb93e>] acpi_os_wait_semaphore+0x68/0x13e
 [<c0205c58>] acpi_ut_acquire_mutex+0x5d/0xc1
 [<c01fbea5>] acpi_ns_root_initialize+0x18/0x267
 [<c0382746>] acpi_initialize_subsystem+0x44/0x64
 [<c03829bd>] acpi_early_init+0x54/0xf4
 [<c036f998>] start_kernel+0x24e/0x256
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Parsing all Control Methods:

~~
laurent
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
