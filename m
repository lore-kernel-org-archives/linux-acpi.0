From: John M Flinchbaugh <john-sQWoH1wgGpLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Thinkpad R40 freezes after swsusp resume
Date: Tue, 22 Feb 2005 09:22:17 -0500
Message-ID: <20050222142217.GA24536@butterfly.hjsoft.com>
References: <20050216195940.GA32423@butterfly.hjsoft.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline
In-Reply-To: <20050216195940.GA32423-1pX4wqAwPg/D3TZcsk6RgFaTQe2KTcn/@public.gmane.org>
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
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 16, 2005 at 02:59:40PM -0500, John M Flinchbaugh wrote:
> correcting the problem, so I can get swsusp and ACPI coexisting=20
> happily
> on my Thinkpad R40.
> Does anyone here on the ACPI list have some logical next steps for=20
> me to
> test?
> ----- Forwarded message from John M Flinchbaugh <john-sQWoH1wgGpLQT0dZR+AlfA@public.gmane.org>=20
> As Murphy's Law would have it, I usually get these lockups at=20
> inopportune times when I really don't want to have to punch the=20
> power=20
> button, like when I'm in a hurry trying to find something or during
> long-running network backups.  It also does it when sitting idle, so
> this isn't a rule.
>=20
> I've run most of a backup from an NFS mount to the local drive (for
> about 10 minutes), stopped it, swsusp, ran another backup, and it's
> looking fine so far.
>=20
> To be sure that it's not going to freeze, I'd almost have to let it=20
> go
> for a week, though, because sometimes I had just gotten lucky and=20
> not
> seen the issue for upto 4 days at a time.
> ----- End forwarded message -----

I've recompiled my 2.6.11-rc4 kernel without ACPI sleep states, and I've
enabled lots of debugging.

Upon swsusp, I see this oops:
[nosave pfn 0x38c]<7>[nosave pfn 0x38d]<3>Debug: sleeping function
called from invalid context at mm/slab.c:2082
in_atomic():0, irqs_disabled():1
 [<c0102b07>] dump_stack+0x17/0x20
 [<c0110e0c>] __might_sleep+0xac/0xc0
 [<c01397ae>] kmem_cache_alloc+0x5e/0x60
 [<c020dbf9>] acpi_pci_link_set+0x7a/0x24e
 [<c020e292>] acpi_pci_link_resume+0x47/0x7d
 [<c020e30d>] irqrouter_resume+0x45/0x6d
 [<c0234357>] sysdev_resume+0xf7/0xfc
 [<c02386e8>] device_power_up+0x8/0xe
 [<c012e798>] swsusp_suspend+0x48/0x50
 [<c012ebb1>] pm_suspend_disk+0x51/0xc0
 [<c012d07a>] enter_state+0x8a/0x90
 [<c012d1b3>] state_store+0xa3/0xaa
 [<c0186ce7>] subsys_attr_store+0x37/0x40
 [<c0186f4e>] flush_write_buffer+0x2e/0x40
 [<c0186fcf>] sysfs_write_file+0x6f/0x90
 [<c014f004>] vfs_write+0xa4/0x110
 [<c014f121>] sys_write+0x41/0x70
 [<c01025af>] syscall_call+0x7/0xb

Otherwise, the swsusp works and resumes.

After the resume, I see these messages:
Feb 22 09:00:54 navi kernel: osl-0958 [1385] os_wait_semaphore     :
Failed to acquire semaphore[c14de5e0|1|0], AE_TIME
Feb 22 09:04:29 navi kernel: osl-0958 [1734] os_wait_semaphore     :
Failed to acquire semaphore[c14de5e0|1|0], AE_TIME
Feb 22 09:07:53 navi kernel: osl-0958 [2076] os_wait_semaphore     :
Failed to acquire semaphore[c14de5e0|1|0], AE_TIME
Feb 22 09:12:09 navi kernel: osl-0958 [2534] os_wait_semaphore     :
Failed to acquire semaphore[c14de5e0|1|0], AE_TIME

I haven't frozen the box yet, but I wouldn't be surprised if these
contribute to the conditions that cause the freeze.

Thanks.
--=20
John M Flinchbaugh
john-sQWoH1wgGpLQT0dZR+AlfA@public.gmane.org

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCG0AZCGPRljI8080RAqDyAJ4hDGsL0p4igpL51Up7Fh861I9vlACaAnux
ZyMSrCLDPtxZCszPnh8PJP8=
=1ibO
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
