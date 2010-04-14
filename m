From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: [acpi:battery?] kernel oops on boot
Date: Wed, 14 Apr 2010 17:58:43 +0400
Message-ID: <4BC5CA13.3070801@suse.de>
References: <20100414095750.GA3304@swordfish.minsk.epam.com> <20100414131324.GA6598@nb-core2.darkstar.lan> <alpine.LFD.2.00.1004141641010.3640@terrop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nat.nue.novell.com ([195.135.221.3]:51249 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755439Ab0DNN6q (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Apr 2010 09:58:46 -0400
In-Reply-To: <alpine.LFD.2.00.1004141641010.3640@terrop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tero Roponen <tero.roponen@gmail.com>
Cc: Luca Tettamanti <kronos.it@gmail.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, len.brown@intel.com

14.04.2010 17:50, Tero Roponen =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>
> On Wed, 14 Apr 2010, Luca Tettamanti wrote:
>
>> Hello,
>> I'm seeing a similar bug on my notebook (Asus F3Sa) with current git=
=2E
>> -rc4 does not work, while -rc3 does work.
>>
>> The error (at least in my case) is a division by zero in
>> acpi_ex_insert_into_field.
>
> I have a similar problem with Asus M50Vm. git-bisect found
> the following commit and reverting it does indeed fix the
> problem.
>
> commit dadf28a10c3eb29421837a2e413ab869ebd9e168
> Author: Alexey Starikovskiy<astarikovskiy@suse.de>
> Date:   Wed Mar 17 13:14:13 2010 -0400
>
>      ACPI: EC: Allow multibyte access to EC
>
>      http://bugzilla.kernel.org/show_bug.cgi?id=3D14667
>
>      Signed-off-by: Alexey Starikovskiy<astarikovskiy@suse.de>
>      Signed-off-by: Len Brown<len.brown@intel.com>
>
Please see the patch in https://bugzilla.kernel.org/show_bug.cgi?id=3D1=
5749

Thanks,
Alex.


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
