From: "Chen, Gong" <gong.chen@linux.intel.com>
Subject: Re: [PATCH 2/2] trace, RAS: Add eMCA trace event interface
Date: Mon, 10 Mar 2014 04:22:42 -0400
Message-ID: <20140310082241.GA873@gchen.bj.intel.com>
References: <1393924997-8992-1-git-send-email-gong.chen@linux.intel.com>
 <1393924997-8992-3-git-send-email-gong.chen@linux.intel.com>
 <20140307114416.GA5255@pd.tnic>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:55237 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751986AbaCJIpo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 10 Mar 2014 04:45:44 -0400
Content-Disposition: inline
In-Reply-To: <20140307114416.GA5255@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: tony.luck@intel.com, m.chehab@samsung.com, arozansk@redhat.com, linux-acpi@vger.kernel.org


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 07, 2014 at 12:44:16PM +0100, Borislav Petkov wrote:
[...]
> > +static void mem_err_location(struct cper_sec_mem_err *mem)
> > +{
> > +	char *p;
> > +	u32 n =3D 0;
> > +
> > +	memset(mem_location, 0, LOC_LEN);
> > +	p =3D mem_location;
> > +	if (mem->validation_bits & CPER_MEM_VALID_NODE)
> > +		n +=3D sprintf(p + n, " node: %d", mem->node);
> > +	if (n >=3D LOC_LEN)
> > +		goto end;
> > +	if (mem->validation_bits & CPER_MEM_VALID_CARD)
> > +		n +=3D sprintf(p + n, " card: %d", mem->card);
> > +	if (n >=3D LOC_LEN)
> > +		goto end;
> > +	if (mem->validation_bits & CPER_MEM_VALID_MODULE)
> > +		n +=3D sprintf(p + n, " module: %d", mem->module);
> > +	if (n >=3D LOC_LEN)
> > +		goto end;
> > +	if (mem->validation_bits & CPER_MEM_VALID_RANK_NUMBER)
> > +		n +=3D sprintf(p + n, " rank: %d", mem->rank);
> > +	if (n >=3D LOC_LEN)
> > +		goto end;
> > +	if (mem->validation_bits & CPER_MEM_VALID_BANK)
> > +		n +=3D sprintf(p + n, " bank: %d", mem->bank);
> > +	if (n >=3D LOC_LEN)
> > +		goto end;
> > +	if (mem->validation_bits & CPER_MEM_VALID_DEVICE)
> > +		n +=3D sprintf(p + n, " device: %d", mem->device);
> > +	if (n >=3D LOC_LEN)
> > +		goto end;
> > +	if (mem->validation_bits & CPER_MEM_VALID_ROW)
> > +		n +=3D sprintf(p + n, " row: %d", mem->row);
> > +	if (n >=3D LOC_LEN)
> > +		goto end;
> > +	if (mem->validation_bits & CPER_MEM_VALID_COLUMN)
> > +		n +=3D sprintf(p + n, " column: %d", mem->column);
> > +	if (n >=3D LOC_LEN)
> > +		goto end;
> > +	if (mem->validation_bits & CPER_MEM_VALID_BIT_POSITION)
> > +		n +=3D sprintf(p + n, " bit_position: %d", mem->bit_pos);
> > +	if (n >=3D LOC_LEN)
> > +		goto end;
> > +	if (mem->validation_bits & CPER_MEM_VALID_REQUESTOR_ID)
> > +		n +=3D sprintf(p + n, " requestor_id: 0x%016llx",
> > +				mem->requestor_id);
> > +	if (n >=3D LOC_LEN)
> > +		goto end;
> > +	if (mem->validation_bits & CPER_MEM_VALID_RESPONDER_ID)
> > +		n +=3D sprintf(p + n, " responder_id: 0x%016llx",
> > +				mem->responder_id);
> > +	if (n >=3D LOC_LEN)
> > +		goto end;
> > +	if (mem->validation_bits & CPER_MEM_VALID_TARGET_ID)
> > +		n +=3D sprintf(p + n, " target_id: 0x%016llx", mem->target_id);
> > +end:
> > +	return;
> > +}
>=20
> Looks like this wants to share with cper_print_mem() - definitely a lot
> of duplication there.
>=20
> > +
> > +static void dimm_err_location(struct cper_sec_mem_err *mem)
> > +{
> > +	const char *bank =3D NULL, *device =3D NULL;
> > +
> > +	memset(dimm_location, 0, LOC_LEN);
> > +	if (!(mem->validation_bits & CPER_MEM_VALID_MODULE_HANDLE))
> > +		return;
> > +
> > +	dmi_memdev_name(mem->mem_dev_handle, &bank, &device);
> > +	if (bank !=3D NULL && device !=3D NULL)
> > +		snprintf(dimm_location, LOC_LEN - 1, "%s %s", bank, device);
> > +	else
> > +		snprintf(dimm_location, LOC_LEN - 1, "DMI handle: 0x%.4x",
> > +			 mem->mem_dev_handle);
> > +}
>=20
> This one too.
>=20
Not really. Firstly they service for different purpose. Secondly the
format here can be changed/updated depending on further requirment.
I can't assume they always keep the same format.

> > +
> > +static void trace_mem_error(const uuid_le *fru_id, char *fru_text,
> > +			    u64 err_count, u32 severity,
> > +			    struct cper_sec_mem_err *mem)
> > +{
> > +	u32 etype =3D ~0U;
> > +	u64 phy_addr =3D ~0ull;
>=20
> I'm assuming userspace knows that all 1s means field value is invalid?
Yep, I suppose so.

>=20
> > +	unsigned long flags;
> > +
> > +	if (mem->validation_bits & CPER_MEM_VALID_ERROR_TYPE)
> > +		etype =3D mem->error_type;
>=20
> newline.
Sure.

[...]
> We probably need a mechanism to disable printking to dmesg once
> userspace has opened the tracepoint.
Do we really need to do that? IMHO, I think they are used for two different
usages, just like dmesg & mcelog.

[...]
> >  static void cper_print_mem(const char *pfx, const struct cper_sec_mem_=
err *mem)
> >  {
> >  	if (mem->validation_bits & CPER_MEM_VALID_ERROR_STATUS)
> > @@ -233,8 +241,7 @@ static void cper_print_mem(const char *pfx, const s=
truct cper_sec_mem_err *mem)
> >  	if (mem->validation_bits & CPER_MEM_VALID_ERROR_TYPE) {
> >  		u8 etype =3D mem->error_type;
> >  		printk("%s""error_type: %d, %s\n", pfx, etype,
> > -		       etype < ARRAY_SIZE(cper_mem_err_type_strs) ?
> > -		       cper_mem_err_type_strs[etype] : "unknown");
> > +			cper_mem_err_type_str(etype));
> >  	}
> >  	if (mem->validation_bits & CPER_MEM_VALID_MODULE_HANDLE) {
> >  		const char *bank =3D NULL, *device =3D NULL;
>=20
> Ditto.
I know you hope the print function in CPER & trace for cpi_extlog can be
merged into one. I just have one concern about it. Can we ensure these
two functions keeping align all the time? IOW, merge them for now until
change happens one day?

[...]
> > +#define LOC_LEN		512
> > +
> > +TRACE_EVENT(extlog_mem_event,
>=20
> So this is a mem thing so we're defining a tracepoint for memory events,
> specifically.
>=20
> However, if extlog carries all kinds of errors outside, not only DRAM
> errors, we should do a TRACE_EVENT_CLASS which contains the shared args
> to every error type and then make a mem event ontop of it.
I agree.


--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTHXZRAAoJEI01n1+kOSLHVAAP/2FUqAnpKWCE4DkkAqEK0+E3
CG2LdCqtOm8051VLLpg4L+vdPpEOibSvxn7R1jOTE6fYPPI9/WLKHEIgGJIzMSIx
e8pWrWrT1OnD6LozmugB9tE0yMtdaJ0cVDlJnDUrRwqMUWPnxbTE7O5pp+YZIafE
Ii5MhuCJUu4HjpDs182d/z3vQdmWFwJkUSp7CU6i3UGC69FeebK06GWvlzrcUl+3
syTTmvADt/LAhtiXwhvWJ6fEyY4ZpWxAFD5FMnpRkT+fVx/4q6AFPr/ZendZL2tU
BUUyXjn4I4PDFufFKcXFHSMsi8sZLNebLLr7rgaiOe7OXiSH8rIBajqYVZXTbgqs
7wRctjvJJEBBj2L0LbchP8VYsU2BxvWOWL0l5bn41pxV5BA6rw+QTkS7J4kV622d
5dhgbUYb1QHm6To9kMsclXUDNuFCF8Z461pxweuhw+T82Xe3hzu5JpBcHIepoc6M
ApO2xfyzZSJ0NZykxxTrQIf/dC2Strp5+UCcXIm3wrkF4OBhP5LzTjTnTHF3MV9l
30wxZV0131mlkrvcKIusjXX4EU2rr6cP0z1c3cswYjaI91Rz5DZSR6FLqeLzz9xI
gqo516lY78R9VwLOcpoKXCoGozYvl/nMYqKoSgWeaJlRL6RTro30mmtQa5W77Tsf
0hp+j4N0a8YHreUK0T63
=+2nf
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--
