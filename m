From: Vlastimil Babka <caster@gentoo.org>
Subject: Re: PROBLEM: NULL pointer dereference in acpi_ns_check_object_type()
Date: Tue, 03 Jul 2012 11:15:55 +0200
Message-ID: <4FF2B84B.1060000@gentoo.org>
References: <4FF15FA6.5070109@gentoo.org> <94F2FBAB4432B54E8AACC7DFDE6C92E346B0252D@ORSMSX101.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:43508 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754191Ab2GCJQA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 3 Jul 2012 05:16:00 -0400
In-Reply-To: <94F2FBAB4432B54E8AACC7DFDE6C92E346B0252D@ORSMSX101.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Thomas Renninger <trenn@suse.de>, collinm@laboiteaprog.com

On 07/02/2012 09:59 PM, Moore, Robert wrote:
> I was able to reproduce the problem here with your ACPI tables.
>
> Will look at your patch, and get back to you.

Thanks.

> You should probably open a bugzilla on this.

Done: bug 44171

https://bugzilla.kernel.org/show_bug.cgi?id=3D44171

> Thanks,
> Bob
>
>
>> -----Original Message-----
>> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
>> owner@vger.kernel.org] On Behalf Of Vlastimil Babka
>> Sent: Monday, July 02, 2012 1:45 AM
>> To: linux-acpi@vger.kernel.org
>> Subject: PROBLEM: NULL pointer dereference in
>> acpi_ns_check_object_type()
>>
>> Hello,
>>
>> I've been experiencing kernel panic with NULL pointer dereference in
>> acpi_ns_check_object_type since kernel 3.4 on a MacPro machine.
>>
>> By recompiling as much of ACPI as possible as modules, I was able to
>> get the system running and postpone the error until doing 'modprobe
>> acpi-cpufreq', which now results in oops, not panic. The log is
>> attached as error.log.
>>
>> By bisecting linus tree between 3.3 and 3.4, I found the guilty comm=
it
>> 6a99b1c94d053b3420eaa4a4bc8b2883dd90a2f9
>> "ACPICA: Object repair code: Support to add Package wrappers" [1]
>> However this patch does not directly touch the functions in the stac=
k
>> trace.
>>
>> Next I created a kdump of the oops, and looked around with gdb.
>> - In acpi_ns_check_package(), the null pointer is in the parameter
>> return_object_ptr, which is dereferenced when initializing the varia=
ble
>> return_object.
>> - The calling function acpi_ns_check_package_list() is in the 'case
>> ACPI_PTYPE2_COUNT:' part, the passed null pointer is in the
>> sub_elements variable.
>> - Before the switch, sub_elements is initialized like this:
>>
>>    sub_elements =3D sub_package->package.elements
>>
>>    interestingly, in the crashdump, sub_elements is null, but
>>    sub_package->package.elements is non-null
>>
>> I've added some printk's and verified that the call of  status =3D
>> acpi_ns_check_object_type(data, &sub_package,
>> 				   ACPI_RTYPE_PACKAGE, i);
>>
>>   makes sub_package->package.elements become non-null, but sub_eleme=
nts
>> was already initialized before this call and remains null.
>>
>> The above led me to create the attached patch which simply moves the
>> initialization of sub_elements after the sub_package check. I think
>> it's this check that results in the Integer to Package
>> conversion/wrapping.
>>
>> After this patch, the null pointer dereference is gone, but the debu=
g
>> output of ACPI (acpi.debug_layer=3D0xffffffff
>> acpi.debug_level=3D0x00000008) shows that something is probably stil=
l
>> wrong:
>>
>> [    1.353677] nsrepair-0681 [4294967287] ns_wrap_with_package  :
>> \_PR_.CPU0._PSD: Wrapped Integer with expected Package object
>> [    1.353869] nsrepair-0681 [4294967287] ns_wrap_with_package  :
>> \_PR_.CPU0._PSD: Wrapped Integer with expected Package object
>> [    1.354059] ACPI Warning: For \_PR_.CPU0._PSD: Return Sub-Package=
[0]
>> is too small - found 1 elements, expected 5 (20120320/nspredef-905)
>> [    1.354253] ACPI: Invalid package argument
>> [    1.354322] ACPI: Invalid _PSD data
>> ... (the same for other CPUx)
>>
>>
>> In comparison, 3.3 kernel with same acpi debug options shows only st=
uff
>> like:
>> [    1.494238] nsrepair-0728 [4294967287] ns_repair_package_list:
>> \_PR_.CPU0._PSD: Repaired incorrectly formed Package
>> [    1.494449] nsrepair-0728 [4294967287] ns_repair_package_list:
>> \_PR_.CPU2._PSD: Repaired incorrectly formed Package
>> [    1.494657] nsrepair-0728 [4294967287] ns_repair_package_list:
>> \_PR_.CPU4._PSD: Repaired incorrectly formed Package ... (the same f=
or
>> other CPUx)
>>
>> Since I don't know much about this subsystem, I figured that I shoul=
d
>> just report my findings at this point. The patched system is usable,
>> but I guess it's not a complete fix.
>>
>> I also attach the output of acpidump. I hope I didn't forget anythin=
g
>> important, please ask for more information if needed.
>>
>> Thanks,
>> Vlastimil Babka
>>
>> [1]
>> git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-
>> 2.6.git;a=3Dcommit;h=3D6a99b1c94d053b3420eaa4a4bc8b2883dd90a2f9
>
> N=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDr=EF=BF=BD=EF=BF=BDy=EF=
=BF=BD=EF=BF=BD=EF=BF=BDb=EF=BF=BDX=EF=BF=BD=EF=BF=BD=C7=A7v=EF=BF=BD^=EF=
=BF=BD)=DE=BA{.n=EF=BF=BD+=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD{=EF=BF=BD=
i=EF=BF=BDb=EF=BF=BD{ay=EF=BF=BD=1D=CA=87=DA=99=EF=BF=BD,j=07=EF=BF=BD=EF=
=BF=BDf=EF=BF=BD=EF=BF=BD=EF=BF=BDh=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD=
=1E=EF=BF=BDw=EF=BF=BD=EF=BF=BD=EF=BF=BD=0C=EF=BF=BD=EF=BF=BD=EF=BF=BDj=
:+v=EF=BF=BD=EF=BF=BD=EF=BF=BDw=EF=BF=BDj=EF=BF=BDm=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=07=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDzZ+=EF=BF=BD=EF=BF=
=BD=DD=A2j"=EF=BF=BD=EF=BF=BD!tml=3D
>


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
