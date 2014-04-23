From: "Chen, Gong" <gong.chen@linux.intel.com>
Subject: Re: [PATCH 2/5 v2] CPER: Adjust code flow of some functions
Date: Tue, 22 Apr 2014 21:28:18 -0400
Message-ID: <20140423012818.GA3888@gchen.bj.intel.com>
References: <1397716119-6164-1-git-send-email-gong.chen@linux.intel.com>
 <1397716119-6164-3-git-send-email-gong.chen@linux.intel.com>
 <20140422135421.GE15882@pd.tnic>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:11918 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751859AbaDWBxx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 22 Apr 2014 21:53:53 -0400
Content-Disposition: inline
In-Reply-To: <20140422135421.GE15882@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: tony.luck@intel.com, m.chehab@samsung.com, rostedt@goodmis.org, linux-acpi@vger.kernel.org, arozansk@redhat.com


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 22, 2014 at 03:54:22PM +0200, Borislav Petkov wrote:
> > +void cper_mem_err_location(const struct cper_sec_mem_err *mem, char *m=
sg)
> > +{
> > +	u32 n =3D 0, len;
> > +
> > +	if (!msg)
> > +		return;
> > +
> > +	len =3D strlen(msg);
> > +	memset(msg, 0, len);
>=20
> Have you even tested this???
>=20
> [    0.104006] ------------[ cut here ]------------
> [    0.108012] WARNING: CPU: 0 PID: 1 at lib/vsprintf.c:1660 vsnprintf+0x=
551/0x560()
> [    0.112006] Modules linked in:
> [    0.114167] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.15.0-rc1+ #13
> [    0.116006] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S Bochs 01/01/2011
> [    0.120025]  0000000000000009 ffff88007bc4bd78 ffffffff815e3c68 000000=
0000000000
> [    0.130251]  ffff88007bc4bdb0 ffffffff8104d10c 00000000ffffffff 000000=
0000000000
> [    0.136006]  ffffffff82bd42c0 0000000000000000 0000000000000000 ffff88=
007bc4bdc0
> [    0.140881] Call Trace:
> [    0.142555]  [<ffffffff815e3c68>] dump_stack+0x4e/0x7a
> [    0.144009]  [<ffffffff8104d10c>] warn_slowpath_common+0x8c/0xc0
> [    0.148034]  [<ffffffff8104d1fa>] warn_slowpath_null+0x1a/0x20
> [    0.152013]  [<ffffffff812be301>] vsnprintf+0x551/0x560
> [    0.156013]  [<ffffffff812be31d>] vscnprintf+0xd/0x30
> [    0.160012]  [<ffffffff812be379>] scnprintf+0x39/0x40
> [    0.164009]  [<ffffffff815e4f92>] cper_mem_err_location.part.1+0x6a/0x=
253
> [    0.168009]  [<ffffffff81496a11>] cper_print_mem+0x41/0x100
> [    0.172018]  [<ffffffff815db7c0>] ? rest_init+0x140/0x140
> [    0.176035]  [<ffffffff815db806>] kernel_init+0x46/0x120
> [    0.180009]  [<ffffffff815ec8ec>] ret_from_fork+0x7c/0xb0
> [    0.182780]  [<ffffffff815db7c0>] ? rest_init+0x140/0x140
> [    0.184012] ---[ end trace d69126aad4cf21bf ]---
>=20
> Think about what happens the first time you call this function and
> strlen returns 0 because the string is empty.
>=20
> I enforced the first call to that function in kvm just so that I can
> test your stuff but I don't see why this won't happen on real hardware
> either.

When I have the first glance on the call trace, I feel strange because I
have tested it for many times on real machine, until I noticed that once
lenght is 0, the evaluation via scnprintf will be a disaster.

BTW, because I can't figure out what field looks more important than
others, I have to keep all of them until some guy tells me something new.

>=20
> Gong, I would strongly urge you to spend more time
> and care on your patches instead of rushing them out.
> ea431643d6c38728195e2c456801c3ef66bb9991 shouldnt've happened if you
> tested your stuff more thoroughly and it cost me a whole day to dig out
> what exactly was happening and talking to bug reporters.
>=20
Thanks very much for your help for it. I do need to be more careful to
avoid similiar stupid thing happened again.

> > +static void cper_print_mem(const char *pfx, const struct cper_sec_mem_=
err *mem)
> > +{
> > +	if (mem->validation_bits & CPER_MEM_VALID_ERROR_STATUS)
> > +		printk("%s""error_status: 0x%016llx\n", pfx, mem->error_status);
> > +	if (mem->validation_bits & CPER_MEM_VALID_PA)
> > +		printk("%s""physical_address: 0x%016llx\n",
> > +		       pfx, mem->physical_addr);
> > +	if (mem->validation_bits & CPER_MEM_VALID_PA_MASK)
> > +		printk("%s""physical_address_mask: 0x%016llx\n",
> > +		       pfx, mem->physical_addr_mask);
> > +	cper_mem_err_location(mem, mem_location);
> > +	pr_debug("%s", mem_location);
> >  	if (mem->validation_bits & CPER_MEM_VALID_ERROR_TYPE) {
> >  		u8 etype =3D mem->error_type;
> >  		printk("%s""error_type: %d, %s\n", pfx, etype,
> > -		       etype < ARRAY_SIZE(cper_mem_err_type_strs) ?
> > -		       cper_mem_err_type_strs[etype] : "unknown");
> > -	}
> > -	if (mem->validation_bits & CPER_MEM_VALID_MODULE_HANDLE) {
> > -		const char *bank =3D NULL, *device =3D NULL;
> > -		dmi_memdev_name(mem->mem_dev_handle, &bank, &device);
> > -		if (bank !=3D NULL && device !=3D NULL)
> > -			printk("%s""DIMM location: %s %s", pfx, bank, device);
> > -		else
> > -			printk("%s""DIMM DMI handle: 0x%.4x",
> > -			       pfx, mem->mem_dev_handle);
> > +		       cper_mem_err_type_str(etype));
> >  	}
> > +	cper_dimm_err_location(mem, dimm_location);
> > +	printk("%s%s", pfx, dimm_location);
>=20
> ???
Here you mean the last line?

printk("%s%s", pfx, dimm_location);

If so, I have to say I follow previous design style in APEI series drivers.
pfx is a prefix to tell printk what priority for this print. It can be
changed under different conditions.
>=20
> >  }
> > =20
> >  static const char *cper_pcie_port_type_strs[] =3D {
> > diff --git a/include/linux/cper.h b/include/linux/cper.h
> > index 2fc0ec3..038cc11 100644
> > --- a/include/linux/cper.h
> > +++ b/include/linux/cper.h
> > @@ -23,6 +23,8 @@
> > =20
> >  #include <linux/uuid.h>
> > =20
> > +extern struct raw_spinlock cper_loc_lock;
> > +
>=20
> Forgot to remove the spinlock.
>=20
OK, gotta it.


--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTVxcyAAoJEI01n1+kOSLHQD0P/Rcxim/SDjANioweG0zdypoy
TNnWVv/BtSHbERG/Rb362sAbkaZk58nYJZXoKHTIRFhA1v16lp3rBwOYxeGPbAv4
D9xi4ejFW0hkifR+IhxLllx6YO9NLnq7GgrGGLLtluB77ct4aUkea0VxMDRCUN4I
5IMgNWJgUlb70/IzVpcv45lPsVriRSliDJopifM40QDYJ0vf5HbukcAjeHdEifAj
j5d1R6Kd4xemZt3proYvl9GDLCXFa2rxkhaUpmPYTS+jpZsdBiKCBeaU79ESCGnl
Kw3fGrRgGG/FiFF1agwhi4tj6UG0reI6qsFL5qGujFj0I7sC0O4BUGwVLBsclK4z
CykfNK0btb+C47cgMxPy1CtNazmNvLWvCad3R7O71RTa/kMXeAwGx/gCj/0OAFJV
yP/xkYcbvOSRdbr1wAlwpCYUL84uhgKxU1X4xxATBA9AFAw8mqizXVE8WjDlIxoZ
AKahPKHxMPZ0je4f7BdeJizlQpLfKYE3aGeLEB8veDUTnUfWoOlp+40T8xtefPjH
TVTIGP+hcqWl/CQX61HApFTl3JaXcrdeAlLm3gnttd7qx07AtXJaEfNfViBlMpWs
INtK2iTMoHbc8AMphoW4ZW7cIupIV47cH56vQ10J8qorxdcuJS1k1eBObyVKlWSK
2pKzl0mVCJNsM8MqsIpK
=4/Es
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--
