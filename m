From: Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>
Subject: Re: [Fwd: [patch 2.6.18-rc7] ACPI: build warnings begone (x86_64)]
Date: Wed, 20 Sep 2006 20:49:50 +0400
Message-ID: <4511712E.7030505@linux.intel.com>
References: <B28E9812BAF6E2498B7EC5C427F293A4F8068D@orsmsx415.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:59662 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751910AbWITQux (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 20 Sep 2006 12:50:53 -0400
In-Reply-To: <B28E9812BAF6E2498B7EC5C427F293A4F8068D@orsmsx415.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: sergio@sergiomb.no-ip.org, acpi devel <linux-acpi@vger.kernel.org>, David Brownell <david-b@pacbell.net>

print expects C types, so conversion to them helps (use (unsigned) for =
%X or (unsigned long) for %lX).

Regards,
Alex.

Moore, Robert wrote:
> Problem is to make one version of the code compile everywhere with no=
 warnings.
>=20
>> -----Original Message-----
>> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
>> owner@vger.kernel.org] On Behalf Of Sergio Monteiro Basto
>> Sent: Tuesday, September 19, 2006 6:30 PM
>> To: acpi devel
>> Cc: David Brownell
>> Subject: [Fwd: [patch 2.6.18-rc7] ACPI: build warnings begone (x86_6=
4)]
>>
>> Hi, I think this should be reported on
>> ACPI mailing list , so I am Forwarding to this list
>>
>> -------- Forwarded Message --------
>>> From: David Brownell <david-b@pacbell.net>
>>> To: Brown, Len <len.brown@intel.com>
>>> Cc: linux-kernel@vger.kernel.org
>>> Subject: [patch 2.6.18-rc7] ACPI: build warnings begone (x86_64)
>>> Date: 	Wed, 13 Sep 2006 21:00:33 -0700
>>>
>>> This makes various ACPI compiler warnings go away (x86_64),
>>> making builds be warning-free again.
>>>
>>> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
>>>
>>> Index: g26/drivers/acpi/executer/exmutex.c
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> --- g26.orig/drivers/acpi/executer/exmutex.c	2006-07-14
>> 10:03:04.000000000 -0700
>>> +++ g26/drivers/acpi/executer/exmutex.c	2006-09-13 13:31:10.0000000=
00 -
>> 0700
>>> @@ -266,10 +266,10 @@ acpi_ex_release_mutex(union acpi_operand
>>>  	     walk_state->thread->thread_id)
>>>  	    && (obj_desc->mutex.os_mutex !=3D ACPI_GLOBAL_LOCK)) {
>>>  		ACPI_ERROR((AE_INFO,
>>> -			    "Thread %X cannot release Mutex [%4.4s] acquired by
>> thread %X",
>>> -			    (u32) walk_state->thread->thread_id,
>>> +			    "Thread %p cannot release Mutex [%4.4s] acquired by
>> thread %p",
>>> +			    walk_state->thread->thread_id,
>>>  			    acpi_ut_get_node_name(obj_desc->mutex.node),
>>> -			    (u32) obj_desc->mutex.owner_thread->thread_id));
>>> +			    obj_desc->mutex.owner_thread->thread_id));
>>>  		return_ACPI_STATUS(AE_AML_NOT_OWNER);
>>>  	}
>>>
>>> Index: g26/drivers/acpi/tables/tbget.c
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> --- g26.orig/drivers/acpi/tables/tbget.c	2006-07-14
>> 10:03:04.000000000 -0700
>>> +++ g26/drivers/acpi/tables/tbget.c	2006-09-13 13:37:27.000000000 -
>> 0700
>>> @@ -324,7 +324,7 @@ acpi_tb_get_this_table(struct acpi_point
>>>
>>>  	if (header->length < sizeof(struct acpi_table_header)) {
>>>  		ACPI_ERROR((AE_INFO,
>>> -			    "Table length (%X) is smaller than minimum (%X)",
>>> +			    "Table length (%X) is smaller than minimum (%zX)",
>>>  			    header->length, sizeof(struct acpi_table_header)));
>>>
>>>  		return_ACPI_STATUS(AE_INVALID_TABLE_LENGTH);
>>> Index: g26/drivers/acpi/utilities/utmutex.c
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> --- g26.orig/drivers/acpi/utilities/utmutex.c	2006-07-14
>> 10:03:04.000000000 -0700
>>> +++ g26/drivers/acpi/utilities/utmutex.c	2006-09-13
>> 13:39:24.000000000 -0700
>>> @@ -258,8 +258,8 @@ acpi_status acpi_ut_acquire_mutex(acpi_m
>>>  		acpi_gbl_mutex_info[mutex_id].thread_id =3D this_thread_id;
>>>  	} else {
>>>  		ACPI_EXCEPTION((AE_INFO, status,
>>> -				"Thread %X could not acquire Mutex [%X]",
>>> -				(u32) this_thread_id, mutex_id));
>>> +				"Thread %p could not acquire Mutex [%X]",
>>> +				this_thread_id, mutex_id));
>>>  	}
>>>
>>>  	return (status);
>>> Index: g26/drivers/acpi/tables/tbrsdt.c
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> --- g26.orig/drivers/acpi/tables/tbrsdt.c	2006-07-14
>> 10:03:04.000000000 -0700
>>> +++ g26/drivers/acpi/tables/tbrsdt.c	2006-09-13 13:38:39.000000000 =
-
>> 0700
>>> @@ -187,7 +187,7 @@ acpi_status acpi_tb_validate_rsdt(struct
>>>
>>>  	if (table_ptr->length < sizeof(struct acpi_table_header)) {
>>>  		ACPI_ERROR((AE_INFO,
>>> -			    "RSDT/XSDT length (%X) is smaller than minimum
>> (%X)",
>>> +			    "RSDT/XSDT length (%X) is smaller than minimum
>> (%zX)",
>>>  			    table_ptr->length,
>>>  			    sizeof(struct acpi_table_header)));
>>>
>>> -
>>> To unsubscribe from this list: send the line "unsubscribe linux-ker=
nel"
>> in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>> Please read the FAQ at  http://www.tux.org/lkml/
>> --
>> S=E9rgio M.B.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
