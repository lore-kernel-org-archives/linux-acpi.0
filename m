From: Lan Tianyu <tianyu.lan@intel.com>
Subject: Re: [PATCH] ACPI/Processor: Rework processor throttling with work_on_cpu()
Date: Mon, 24 Feb 2014 17:27:55 +0800
Message-ID: <530B109B.5020901@intel.com>
References: <20140220151721.GB32719@redhat.com> <1392960945-30741-1-git-send-email-tianyu.lan@intel.com> <20140221100630.GA1121@krava.brq.redhat.com> <20140221170709.GC1121@krava.brq.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:31818 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751509AbaBXJdw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 24 Feb 2014 04:33:52 -0500
In-Reply-To: <20140221170709.GC1121@krava.brq.redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: tj@kernel.org, oleg@redhat.com, lenb@kernel.org, rjw@rjwysocki.net, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On 2014=E5=B9=B402=E6=9C=8822=E6=97=A5 01:07, Jiri Olsa wrote:
> On Fri, Feb 21, 2014 at 11:06:30AM +0100, Jiri Olsa wrote:
>> On Fri, Feb 21, 2014 at 01:35:45PM +0800, Lan Tianyu wrote:
>>> acpi_processor_set_throttling() uses set_cpus_allowed_ptr() to make
>>> sure struct acpi_processor->acpi_processor_set_throttling() callbac=
k
>>> run on associated cpu. But the function maybe called in a worker wh=
ich
>>> has been bound to a cpu. The patch is to replace set_cpus_allowed_p=
tr()
>>> with work_on_cpu().
>>
>> testing the new patch.. so far so good ;-)
>=20
> ook.. survived whole day under the test workload without the warning =
;-)
>=20
> jirka
>=20

Hi Jirka:
	Great. Thanks for test:).


--=20
Best regards
Tianyu Lan
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
