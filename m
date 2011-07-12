From: Cong Wang <amwang@redhat.com>
Subject: Re: [PATCH v2] acpi: introduce "acpi_rsdp=" parameter for kdump
Date: Tue, 12 Jul 2011 18:30:18 +0800
Message-ID: <4E1C223A.9000705@redhat.com>
References: <E8CC3FDD41FF9Findou.takao@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:29270 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752052Ab1GLKbG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 12 Jul 2011 06:31:06 -0400
In-Reply-To: <E8CC3FDD41FF9Findou.takao@jp.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Takao Indoh <indou.takao@jp.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, ebiederm@xmission.com, vgoyal@redhat.com, rdunlap@xenotime.net, lenb@kernel.org, linux-doc@vger.kernel.org, linux-acpi@vger.kernel.org, mjg@redhat.com

=E4=BA=8E 2011=E5=B9=B407=E6=9C=8811=E6=97=A5 23:14, Takao Indoh =E5=86=
=99=E9=81=93:
> Revised version of the patch which was posted by Cong WANG
>
> Changes in v2:
> * Change parameter name from "acpi_addr" to "acpi_rsdp"
> * Add CONFIG_KEXEC

Thanks for updating it! Definitely looks good to me,

Reviewed-by: WANG Cong <amwang@redhat.com>
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
