From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Re: [PATCH] Teach OSL to handle multiple interrupts [1/2]
Date: Wed, 17 Nov 2004 01:57:44 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F84041AC085@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Matthew Wilcox <matthew-Ztpu424NOJ8@public.gmane.org>
Cc: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Fu, Michael" <michael.fu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Sorry, Please revert this one. My mailer  sent out my draft mail instead =
of
completed one!  (because PPP connection broken).

I will rewrite it later. Sorry for confusing.


Thanks
Luming=20

>-----Original Message-----
>From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org=20
>[mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Yu, Luming
>Sent: 2004=C4=EA11=D4=C217=C8=D5 1:49
>To: Matthew Wilcox
>Cc: Brown, Len; Moore, Robert; Fu, Michael;=20
>acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>Subject: RE: [ACPI] Re: [PATCH] Teach OSL to handle multiple=20
>interrupts [1/2]
>
>>On Sat, Nov 13, 2004 at 01:28:54AM +0800, Yu, Luming wrote:
>>> My comments:
>>
>>These all seem to relate to the gpe-block device patch, right?=20
>> You see no
>>problems with the OSL patch you actually quote, correct?
>>
>
>I'm sorry for not mention that, because the I looked over it , and
>didn't find problem. I just re-checked it. Here are some comments:
>
>In acpi_os_install_interrupt_handler:
>
>+	 * If this is the FADT interrupt, ignore the GSI from the core
>and
>+	 * use the value in our copy of the FADT instead.  It may not be
>the
>+	 * same if an interrupt source override exists for the SCI.
> 	 */
>-	gsi =3D acpi_fadt.sci_int;
>+	if (gsi =3D=3D acpi_gbl_FADT->sci_int)
>+		gsi =3D acpi_fadt.sci_int;
>
>4.1:=20
>
>>> 1. In acpi_gpe_block_add,=20
>>>=20
>>> +	acpi_walk_resources(device->handle, METHOD_NAME__CRS,
>>> +			acpi_gpe_block_crs_add, &block);
>>> +	if (block.register_count =3D=3D 0)
>>> +		return 0;
>>>=20
>>> 1.1  Shouldn't it return AE_ERROR.
>>
>>I don't think it really matters.  The driver will attach to=20
>>these devices,
>>but that doesn't do any harm.
>>
>>> 1.2  You assume there always have IRQ resource for the gpe blocks.
>>
>>No, I assume there are io or memory resources for these gpe=20
>blocks.  If
>>there aren't, it's pretty useless!
>>
>>> 2. In acpi_gpe_block_remove,
>>> +	acpi_walk_resources(device->handle, METHOD_NAME__CRS,
>>> +			acpi_gpe_block_crs_remove, &fadt);
>>> +	if (fadt)
>>> +		return AE_OK;
>>>=20
>>> 2.1 fadt seems always to be 0, So why you need it?
>>
>>fadt is only set to 0 when _CRS resources exist.  ie for GPE=20
>>blocks that
>>aren't described in the FADT.  We shouldn't unregister GPE=20
>>blocks that're
>>described in the FADT because we didn't register them in the=20
>>first place.
>>
>>> 2.2 How to free IRQ resource? You just free them at=20
>>acpi_os_terminate.
>>
>>Huh?  acpi_remove_gpe_block() releases the IRQ resource.  I=20
>>have actually
>>loaded and unloaded this driver ;-)
>>
>>> 3. In acpi_gpe_block_crs_addr
>>> +	data->address.register_bit_width =3D ACPI_GPE_REGISTER_WIDTH;
>>> +	data->address.register_bit_offset =3D ACPI_GPE_REGISTER_WIDTH;
>>> +	data->address.address =3D addr->min_address_range;
>>> +	data->register_count =3D size / 2;
>>>=20
>>> 3.1 you should specify address.address_space_id
>>
>>I do that right above the section you quoted.
>>
>>> 3.2  address.reserved must be 0. (You allocate it at stack)
>>
>>Doesn't really matter.  It isn't used.  But I'll fix that.
>>
>>> 3.3 Why you think register_bit_offset is ACPI_GPE_REGISTER_WIDTH.
>>
>>Why do you think it isn't?  BTW, the current ACPICA ignores=20
>what values
>>get passed in for register_bit_width and register_bit_offset=20
>>and hardcodes
>>ACPI_GPE_REGISTER_WIDTH instead.
>>
>>> 3.3 Why you think register_count should be size/2 ?=20
>>
>>Because there's an enable and status byte for each event.  I basically
>>got the idea from:
>>                register_count0 =3D (u16)=20
>>(acpi_gbl_FADT->gpe0_blk_len / 2);
>>
>>
>>BTW, I think your comments basically show why the callback interface
>>that ACPICA is based on sucks.  It forces too much information to be=20
>>remembered between two different functions.  Much better to do it all
>>in one function.
>>
>>--=20
>>"Next the statesmen will invent cheap lies, putting the blame upon=20
>>the nation that is attacked, and every man will be glad of those
>>conscience-soothing falsities, and will diligently study them,=20
>>and refuse
>>to examine any refutations of them; and thus he will by and by=20
>>convince=20
>>himself that the war is just, and will thank God for the better sleep=20
>>he enjoys after this process of grotesque self-deception." --=20
>>Mark Twain
>>
>
>
>-------------------------------------------------------
>This SF.Net email is sponsored by: InterSystems CACHE
>FREE OODBMS DOWNLOAD - A multidimensional database that combines
>robust object and relational technologies, making it a perfect match
>for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
>_______________________________________________
>Acpi-devel mailing list
>Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>https://lists.sourceforge.net/lists/listinfo/acpi-devel
>


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
