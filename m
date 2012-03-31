From: Chen Gong <gong.chen@linux.intel.com>
Subject: Re: [PATCH] ACPI, APEI: Add validation check before GHES error is
 recorded
Date: Sat, 31 Mar 2012 13:45:10 +0800
Message-ID: <4F7699E6.90003@linux.intel.com>
References: <1333004952-12403-1-git-send-email-gong.chen@linux.intel.com>  <3908561D78D1C84285E8C5FCA982C28F15B73074@ORSMSX104.amr.corp.intel.com>  <4F766381.4040104@linux.intel.com> <1333164263.7269.7.camel@yhuang-dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:20410 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752065Ab2CaFpN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 31 Mar 2012 01:45:13 -0400
In-Reply-To: <1333164263.7269.7.camel@yhuang-dev>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Huang Ying <ying.huang@intel.com>
Cc: "Luck, Tony" <tony.luck@intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

=E4=BA=8E 2012/3/31 11:24, Huang Ying =E5=86=99=E9=81=93:
> How to filter it is a coding style issue.  The filter can be in
> ghes_do_proc() or apei_mce_report_mem_error().  Both are OK for me.
> Personally, I prefer to filter it in apei_mce_report_mem_error().
> Because it is a MCE trick/quirk instead of GHES trick/quirk.
Maybe some day channel information can be filtered so I will add it in

apei_mce_report_mem_error

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
