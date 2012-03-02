From: Chen Gong <gong.chen@linux.intel.com>
Subject: Re: [PATCH] ACPI, APEI, EINJ, limit the range of einj_param
Date: Fri, 02 Mar 2012 14:54:02 +0800
Message-ID: <4F506E8A.8010901@linux.intel.com>
References: <1330418695-8005-1-git-send-email-gong.chen@linux.intel.com> <1330419255.7432.11.camel@yhuang-dev> <3908561D78D1C84285E8C5FCA982C28F03F983@ORSMSX104.amr.corp.intel.com> <4F4D9111.2010701@linux.intel.com> <3908561D78D1C84285E8C5FCA982C28F04024D@ORSMSX104.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:39121 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755473Ab2CBGyE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 2 Mar 2012 01:54:04 -0500
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F04024D@ORSMSX104.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "Huang, Ying" <ying.huang@intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

=E4=BA=8E 2012/3/1 3:34, Luck, Tony =E5=86=99=E9=81=93:
>> After combination the opinions from Ying and Tony, the current fix i=
s the
>> simplest. Any other changes will make codes more complex. So I prefe=
r to
>> keep current style. What's your opinion?
>
> Not sure which one you mean as "the current fix" (they are both one l=
ine,
> adding a check for param_extension - so neither looks simpler than th=
e
> other :-).
>
> My opinion is that Ying's suggestion to make einj_get_parameter_addre=
ss()
> return NULL is the right one.
>
> -Tony
>
Sorry, here *current fix* means my patch.
I'm afraid your version as below implies some logic errors:

diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
index 4ca087d..3d3816f 100644
--- a/drivers/acpi/apei/einj.c
+++ b/drivers/acpi/apei/einj.c
@@ -238,7 +238,7 @@ static void *einj_get_parameter_address(void)
  			return v5param;
  		}
  	}
-	if (paddrv4) {
+	if (param_extension && paddrv4) {
  		struct einj_parameter *v4param;

  		v4param =3D acpi_os_map_memory(paddrv4, sizeof(*v4param));


Because if working under ACPI4.x without param_extension support, there
is possible that einj_param has meaning (maybe containing address info?=
),
but we just ignore it under current implementation. Maybe in future we
need it so I don't hope to return NULL so early. OTOH, my fix is just
ignore einj_param in current logic, not very destructive.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
