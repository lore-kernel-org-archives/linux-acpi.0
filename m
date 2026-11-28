Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.143.172.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795898593;
	b=XtcyXOxGBwdI5B+6OO38ek8vI27GDmPBZ4tVtiahNP8SxKXq2ZO+KYIm22tF4cRgPuVU
	 CxD0tVwjdCvqA7+S2saT1+Sb2fOOyaqpM3wMNx2FPKxJ5P3EHIfe77+Wy7XEIXVOJ0ocF
	 tAgwo5wp1nXryZ5YHJXXOrRonJroBH6ioBnXGB58/CvEgu4GMyVEh9yAw3JWbT3yfuEsA
	 JTg2LxOMtK5R9lypBCNhrhCvJ8cn8OFzWQlJngyJqC/EY4NaMvdVKLohk1JtAGh/PXweA
	 XOuTkdtjoFrik7Ws+ELoIszsplh97d+zA8QLgpK594X8MotOGDHN9pcugjPNgwtx+kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795898593;
	h=DMARC-Filter:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Rspamd-Bar:X-Rspamd-Report:
	 X-Rspamd-Score:DKIM-Signature;
	bh=YlRaHV+0TUX84p342pJjdfqMOLn4MQd7qODcH8CFS1c=;
	b=V+yJOrppFaflWVlQKD+q4yqboXsKGWY1iujALpsXCs8UGa8ME3QNVyu700cs7X2s6fEk
	 0aJt5s0r/hRUuJX6g8ExMIa6Y8cqOGWG2OQNE9fGtzyxsLJo/q2LSCQy1j0bb89hne8iH
	 9KFmLOKakWXutAurMGAV5IWkFBzB16fzcMBVMkx8losoDeoDnvhfNVHA9P8s1XLY4oEKv
	 mNpOnYPiqSG8DTaQmwgbNEI+V6wj//rXh0As+2fK+gZrZioVkGVVHymRMZ3M0uedd/Vd3
	 CSzu6934tg0NLFWMIYSK47iDspPH+8ajjgg88tvAtLGAbFn6ThNAsHCX82wDZ8KLEdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lausen.nl;
	spf=pass smtp.mailfrom=lausen.nl;
	dkim=pass header.d=lausen.nl header.i=@lausen.nl header.a=rsa-sha256 header.s=uberspace header.b="ARi0/Egj";
	arc=none smtp.remote-ip=95.143.172.20
Received: from mailgate01.uberspace.is (mailgate01.uberspace.is [95.143.172.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFD0606A31C
	for <linux-acpi@vger.kernel.org>; Sat, 28 Nov 2026 20:43:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3AFD0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lausen.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lausen.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=lausen.nl header.i=@lausen.nl header.a=rsa-sha256 header.s=uberspace header.b=ARi0/Egj
Received: from devico.uberspace.de (devico.uberspace.de [185.26.156.185])
	by mailgate01.uberspace.is (Postfix) with ESMTPS id 59DDB61102
	for <linux-acpi@vger.kernel.org>; Sat, 28 Nov 2026 21:43:04 +0100 (CET)
Received: (qmail 23554 invoked by uid 990); 28 Nov 2026 20:43:04 -0000
Authentication-Results: devico.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unknown) (::1)
	by devico.uberspace.de (Haraka/3.1.1) with ESMTPSA; Sat, 28 Nov 2026 21:43:03 +0100
Message-ID: <d5566ab4-2ce5-4cb0-9f83-a082afaf83a9@lausen.nl>
Date: Sat, 28 Nov 2026 21:42:58 +0100
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] ACPI: fan: Broken FAN0._FST on Samsung Galaxy Book5 Pro 360
 (960QHA)
To: Christopher Bormann <wuffeljunior90@gmail.com>
Cc: linux-acpi@vger.kernel.org
References: <1dab8610-d369-4eb8-af3d-9bf5591f49ac@gmail.com>
Content-Language: en-US
From: Leonard Lausen <leonard@lausen.nl>
In-Reply-To: <1dab8610-d369-4eb8-af3d-9bf5591f49ac@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: --
X-Rspamd-Report: BAYES_HAM(-2.894086) XM_UA_NO_VERSION(0.01) MIME_GOOD(-0.1)
X-Rspamd-Score: -2.984086
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lausen.nl; s=uberspace;
	h=from:to:cc:subject:date;
	bh=Pwz2qtt29SbRDHVEQOsXnGZYZ32o1gHaKoll6w9zhTU=;
	b=ARi0/EgjeoMTqV2NqadRSVVrPYwRpoVjDB5JjVW5vIpRd8dLFeG7a2DkJSto+YvdgyC1o4yQlt
	9Y4x+RAD7nhEJBx4AK8xjtWQn1NTQj05Jf09tix+Lbd58KCyJ/eViBXBR2MFInItkJ2KfphzaOsS
	Sqq2oS/k0gK2s8n+/qpv9PBHQUVIgDK3N81YlW9LDINd80C4U0aXhTnPNnZYM0wnsMGGpGGo11gH
	zOD729vBGkX+y4S1MZAp+r+S5IXHHR7zDbLtV96QQpzKmYmufRvA2GcSoge1jlW7t+OK0F2dslev
	BCx5p4L0vtYVIYq29DO9zHY9XiNLc3InNJdJttZVv3I//Lunia73Fqy3r3J+aQYES7jc7PBp8PiS
	FC1SsSKx3L+O0Io2Ge+yr94dQoRCMOpl6h+fUdzEc9DpzoOsM++217NlmNZf5gEtBAqH3G6+eo+N
	7BRMcQAbETKRn3zIQi2X9DL+VQ5xcvgBRJtSDmj9dwTZzLTxnWnBjznlPOfNOxww2ixsMBYeMHB0
	vuuX5T61VdxLXILgHXNVIKUaekxGveewe4u6jo607mtRyTXVvspLFRrcvMGqu2ag3en46kg6f9pb
	o7xe+zK4jwGSc4f/wefAhA9eVeqc0xDk4jyo/d2oLMtPnQBcqTBynHrn7D/9PO8Xg0cqvJWOJgBo
	4=

Hello Christopher,

you can try building a custom kernel with 
https://github.com/open-acpica/acpica/commit/76a97a6a44a2cb08cc005523e94497ac57ffad2a 
fix applied.

Best regards
Leonard

Am 28.11.26 um 19:15 schrieb Christopher Bormann:
> Hello Leonard and Linux ACPI developers,
> 
> I would like to report a reproducible ACPI fan status issue affecting 
> the Samsung Galaxy Book5 Pro 360 (960QHA).
> 
> The issue causes recurring ACPI errors during normal operation, fan 
> status changes and hardware monitoring. The physical fans appear to 
> operate correctly, but the ACPI fan status method fails with 
> AE_AML_OPERAND_TYPE and, occasionally, AE_AML_PACKAGE_LIMIT.
> 
> *1. Hardware and software environment*
> 
>   *
> 
>     Manufacturer: SAMSUNG ELECTRONICS CO., LTD.
> 
>   *
> 
>     Model: Samsung Galaxy Book5 Pro 360
> 
>   *
> 
>     DMI product name: 960QHA
> 
>   *
> 
>     DMI product version: P17ALY
> 
>   *
> 
>     Processor: Intel Core Ultra 7 256V
> 
>   *
> 
>     BIOS version: P17ALY.390.260616.03
> 
>   *
> 
>     BIOS date: 2026-06-16
> 
>   *
> 
>     Distribution: Ubuntu 26.04.1 LTS
> 
>   *
> 
>     Kernel: 7.0.0-43-generic
> 
>   *
> 
>     Architecture: x86_64
> 
>   *
> 
>     ACPICA version reported in kernel errors: 20251212
> 
>   *
> 
>     Secure Boot: enabled
> 
>   *
> 
>     Kernel lockdown: integrity
> 
>   *
> 
>     Samsung Galaxy Book driver: in-tree samsung_galaxybook
> 
>   *
> 
>     Current platform profile: performance
> 
> No custom ACPI kernel parameters are in use.
> 
> The system also uses out-of-tree DKMS modules for camera, audio and 
> video functionality. No causal relationship between these modules and 
> the ACPI issue has been established.
> 
> *2. Problem description*
> 
> The ACPI fan driver repeatedly reports failures while evaluating:
> 
> |\_SB.PC00.LPCB.FAN0._FST|
> 
> The following error occurs frequently:
> 
> |ACPI Error: Needed [Integer/String/Buffer], found [Reference] 
> (20251212/exresop-388) ACPI Error: AE_AML_OPERAND_TYPE, While resolving 
> operands for [Add] (20251212/dswexec-433) ACPI Error: Aborting method 
> \_SB.PC00.LPCB.FAN0._FST due to previous error (AE_AML_OPERAND_TYPE) 
> acpi-fan PNP0C0B:00: Error retrieving current fan status: -5|
> 
> An additional error occasionally occurs:
> 
> |ACPI BIOS Error (bug): AE_AML_PACKAGE_LIMIT, Index (0x000000005) is 
> beyond end of object (length 0x4) (20251212/exoparg2-393) ACPI Error: 
> Aborting method \_SB.PC00.LPCB.FAN0._FST due to previous error 
> (AE_AML_PACKAGE_LIMIT)|
> 
> These errors occur both during explicit hardware monitoring and 
> independently of periodic sensor polling.
> 
> *3. Steps to reproduce*
> 
> 1.
> 
>     Boot Ubuntu using kernel 7.0.0-43-generic.
> 
> 2.
> 
>     Allow the system to reach a temperature or workload at which the
>     fans are active.
> 
> 3.
> 
>     Read the ACPI fan speed attribute:
> 
> |for hw in /sys/class/hwmon/hwmon*; do if [ "$(cat "$hw/name")" = 
> "acpi_fan" ]; then cat "$hw/fan1_input" fi done|
> 
> 4.
> 
>     Inspect the kernel log:
> 
> |sudo journalctl -k -b --no-pager|
> 
> Fan status notifications can also trigger the errors without manually 
> reading the sensor.
> 
> *4. Expected behavior*
> 
> The ACPI fan status method should return a valid fan status package, or 
> the driver should gracefully handle unavailable fan speed information.
> 
> Invalid AML operands and out-of-bounds package accesses should not 
> generate recurring kernel errors.
> 
> *5. Actual behavior*
> 
>   *
> 
>     Fan speed telemetry is unreliable.
> 
>   *
> 
>     The _FST method aborts with ACPI interpreter errors.
> 
>   *
> 
>     Fan status notifications can generate repeated kernel log messages.
> 
>   *
> 
>     Physical fans remain operational based on observed fan noise and
>     thermal behavior.
> 
> *6. Firmware analysis*
> 
> I extracted the ACPI tables using acpidump and acpixtract and 
> disassembled the DSDT using iasl version 20251212.
> 
> The relevant firmware code is located in:
> 
> |\_SB.PC00.LPCB.FAN0|
> 
> The fan lookup table is defined as:
> 
> |Name (FANT, Package (0x04) { 0x0DAC, 0x0EE2, 0x1144, 0x127A })|
> 
> The status package is defined as:
> 
> |Name (SFST, Package (0x03) { Zero, 0xFFFFFFFF, 0xFFFFFFFF })|
> 
> The complete relevant _FST method is:
> 
> |Method (_FST, 0, Serialized) { Local0 = ^^H_EC.FANS Switch (ToInteger 
> (Local0)) { Case (One) { Local0 = One } Case (0x02) { Local0 = 0x02 } 
> Case (0x03) { Local0 = 0x03 } Case (0x04) { Local0 = 0x03 } Case (0x05) 
> { Local0 = 0x04 } } SFST [One] = Local0 If ((Local0 == Zero)) { SFST 
> [0x02] = Local0 } Else { Local0-- Local1 = FANT [Local0] Local1 += 0x0A 
> SFST [0x02] = Local1 } Return (SFST) }|
> 
> The embedded controller defines FANS as a four-bit field:
> 
> |Offset (0x87), FANS, 4,|
> 
> Two potential issues are apparent:
> 
> A. Reference operand handling
> 
> The expression:
> 
> |Local1 = FANT [Local0] Local1 += 0x0A|
> 
> appears consistent with the observed AE_AML_OPERAND_TYPE error.
> 
> Explicit dereferencing may be relevant, although I have not tested a 
> modified method. It is unclear whether this behavior should be 
> attributed to firmware AML or ACPICA reference handling.
> 
> B. Missing bounds checking
> 
> The FANS field can represent values from 0 to 15, but the switch 
> explicitly handles only values from 1 to 5, with zero handled separately.
> 
> An unexpected value such as 6 would remain unchanged, be decremented to 
> 5 and then be used as an index into the four-element FANT package.
> 
> This is consistent with the observed AE_AML_PACKAGE_LIMIT error. The 
> actual raw EC value has not been independently measured.
> 
> *7. Fan notification mechanism*
> 
> The embedded controller also defines:
> 
> |Method (_Q76, 0, NotSerialized) { Notify (FAN0, 0x80) }|
> 
> This appears to explain why _FST may be evaluated even when userspace is 
> not explicitly polling the fan sensor.
> 
> *8. Physical cooling behavior*
> 
> The physical fans audibly increase their speed during demanding 
> workloads, including gaming.
> 
> A short CPU stress test using two workers showed:
> 
>   *
> 
>     Highest observed CPU package temperature: 81°C
> 
>   *
> 
>     Subsequent CPU package temperature: 47°C
> 
>   *
> 
>     Temperature decrease between the final load observation and
>     subsequent measurement: 34°C
> 
> This suggests that basic automatic cooling remains functional, despite 
> the broken fan status reporting.
> 
> Long-duration maximum-load cooling behavior has not been tested.
> 
> *9. Related upstream work*
> 
> I found the following potentially related patch discussion:
> 
> ACPI: fan: Ignore broken _FST on Samsung Galaxy Book 930XDB
> 
> https://lists.openwall.net/linux-kernel/2026/10/19/2287 <https:// 
> lists.openwall.net/linux-kernel/2026/10/19/2287>
> 
> The reported reference operand error appears similar to the issue 
> observed on the 960QHA.
> 
> I also found the subsequent discussion concerning potential ACPICA 
> reference handling:
> 
> https://lists.openwall.net/linux-kernel/2026/10/22/1944 <https:// 
> lists.openwall.net/linux-kernel/2026/10/22/1944>
> 
> Related ACPICA issue:
> 
> https://github.com/open-acpica/acpica/issues/908 <https://github.com/ 
> open-acpica/acpica/issues/908>
> 
> *10. Questions for maintainers*
> 
>   *
> 
>     Could the Samsung Galaxy Book 960QHA be affected by the same _FST 
> issue?
> 
>   *
> 
>     Would extending the proposed model-specific workaround to this
>     device be appropriate?
> 
>   *
> 
>     Could ACPICA reference handling account for the operand type error?
> 
>   *
> 
>     Would a separate firmware workaround be required for the
>     out-of-bounds package access?
> 
>   *
> 
>     What additional diagnostic information would be useful?
> 
> I have not applied any ACPI override, modified the BIOS, disabled Secure 
> Boot or changed the ACPI fan driver.
> 
> This report is based on the Ubuntu distribution kernel. The issue has 
> not yet been tested on a current unmodified upstream kernel, and the 
> first affected kernel version is unknown.
> 
> Relevant ACPI tables and filtered kernel logs can be provided upon request.
> 
> Thank you for your work on Linux hardware support and for investigating 
> this issue.
> 
> Best regards,
> Christopher Bormann
> 
> 

