From: Cong Wang <amwang@redhat.com>
Subject: Re: [Patch] acpi: introduce "acpi_addr=" parameter for kdump
Date: Mon, 21 Mar 2011 14:43:51 +0800
Message-ID: <4D86F3A7.8060706@redhat.com>
References: <1299766243-494-1-git-send-email-amwang@redhat.com> <20110310082600.b52de7fb.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:3187 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751734Ab1CUGn7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 21 Mar 2011 02:43:59 -0400
In-Reply-To: <20110310082600.b52de7fb.rdunlap@xenotime.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: linux-kernel@vger.kernel.org, Takao Indoh <tindoh@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>, Len Brown <lenb@kernel.org>, linux-doc@vger.kernel.org, linux-acpi@vger.kernel.org

=E4=BA=8E 2011=E5=B9=B403=E6=9C=8811=E6=97=A5 00:26, Randy Dunlap =E5=86=
=99=E9=81=93:
> On Thu, 10 Mar 2011 22:10:43 +0800 Amerigo Wang wrote:
>> +	acpi_addr=3D	[ACPI,EFI]
>> +			Pass the RSDP address to the kernel, mostly used
>> +			on machines running EFI runtime service to boot the
>> +			second kernel for kdump.
>> +
>
> I think that "acpi_addr" is a bit too generic.  How about
> acpi_rsdp or acpi_root instead?
>

Yup, I agree "acpi_rsdp" is better.

Thanks.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
