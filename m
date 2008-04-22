From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH 65/73] ACPICA: Fix for extraneous debug message for packages
Date: Tue, 22 Apr 2008 15:21:34 -0700
Message-ID: <9D39833986E69849A2A8E74C1078B6B3335943@orsmsx415.amr.corp.intel.com>
References: <1207974356-30687-1-git-send-email-lenb@kernel.org> <200804150309.25361.lenb@kernel.org> <48046902.8040900@gmail.com> <200804221523.22999.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:30932 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757078AbYDVWVf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 22 Apr 2008 18:21:35 -0400
Content-class: urn:content-classes:message
In-Reply-To: <200804221523.22999.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, Alexey Starikovskiy <aystarik@gmail.com>
Cc: linux-acpi@vger.kernel.org, Alexey Starikovskiy <astarikovskiy@suse.de>

>would probably work just as well.  Certainly acpi_native_uint was
overkill.

I disagree. Often more efficient to use machine native word rather than
fooling around with a byte load/clear and store


>-----Original Message-----
>From: Len Brown [mailto:lenb@kernel.org]
>Sent: Tuesday, April 22, 2008 12:23 PM
>To: Alexey Starikovskiy
>Cc: linux-acpi@vger.kernel.org; Moore, Robert; Alexey Starikovskiy
>Subject: Re: [PATCH 65/73] ACPICA: Fix for extraneous debug message for
>packages
>
>On Tuesday 15 April 2008, Alexey Starikovskiy wrote:
>> Len Brown wrote:
>> > From: Len Brown <len.brown@intel.com>
>> >
>> > drivers/acpi/dispatcher/dsobject.c:499: warning: format '%X'
expects
>type 'unsigned int', but argument 4 has type 'acpi_native_uint'
>> > drivers/acpi/dispatcher/dsobject.c:507: warning: format '%X'
expects
>type 'unsigned int', but argument 7 has type 'acpi_native_uint'
>> >
>> > Signed-off-by: Len Brown <len.brown@intel.com>
>> > ---
>> >  drivers/acpi/dispatcher/dsobject.c |    2 +-
>> >  1 files changed, 1 insertions(+), 1 deletions(-)
>> >
>> > diff --git a/drivers/acpi/dispatcher/dsobject.c
>b/drivers/acpi/dispatcher/dsobject.c
>> > index 5184278..bdef2f0 100644
>> > --- a/drivers/acpi/dispatcher/dsobject.c
>> > +++ b/drivers/acpi/dispatcher/dsobject.c
>> > @@ -373,7 +373,7 @@ acpi_ds_build_internal_package_obj(struct
>acpi_walk_state *walk_state,
>> >  	union acpi_parse_object *parent;
>> >  	union acpi_operand_object *obj_desc = NULL;
>> >  	acpi_status status = AE_OK;
>> > -	acpi_native_uint i;
>> > +	u32 i;
>> >
>> why not just unsigned ?
>
>> >  	u16 index;
>> >  	u16 reference_count;
>
>No particular reason, u32 and unsigned are synonyms on the
architectures we
>care about.
>Now that you point it out, i prefer unsigned, and will go with that.
>
>This is used as an index into the arrary of elements in a package, so
8-
>bits
>would probably work just as well.  Certainly acpi_native_uint was
overkill.
>
>-Len
