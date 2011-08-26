From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: APEI: Can not request iomem region for GARs
Date: Fri, 26 Aug 2011 07:43:37 -0600
Message-ID: <CAErSpo5L1X49hfeJ69o_hwfuzMT6R+7TKhGbYCkyqtqVpf4tEw@mail.gmail.com>
References: <CAG1a4rs4Cr1z50gGuK9SLE6aOvibE1sdV_GSLPv+gqYC8g+ORQ@mail.gmail.com>
 <CAErSpo4FfBoGDUquoLNsJ9=z-M-x6NQgP8xJL_VqEXpsL2H5PA@mail.gmail.com>
 <4E520149.3010802@intel.com> <CAG1a4rtMnDXSGLkmwE+6N9smoghWp0W4b5-X_gogzJ9fDLTeBg@mail.gmail.com>
 <4E571D66.1070302@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:52208 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752883Ab1HZNn7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 26 Aug 2011 09:43:59 -0400
Received: from wpaz33.hot.corp.google.com (wpaz33.hot.corp.google.com [172.24.198.97])
	by smtp-out.google.com with ESMTP id p7QDhwiK012156
	for <linux-acpi@vger.kernel.org>; Fri, 26 Aug 2011 06:43:58 -0700
Received: from ywf7 (ywf7.prod.google.com [10.192.6.7])
	by wpaz33.hot.corp.google.com with ESMTP id p7QDh2OJ016896
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Fri, 26 Aug 2011 06:43:57 -0700
Received: by ywf7 with SMTP id 7so3594881ywf.33
        for <linux-acpi@vger.kernel.org>; Fri, 26 Aug 2011 06:43:57 -0700 (PDT)
In-Reply-To: <4E571D66.1070302@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Huang Ying <ying.huang@intel.com>
Cc: Pavel Ivanov <paivanof@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Thu, Aug 25, 2011 at 10:13 PM, Huang Ying <ying.huang@intel.com> wro=
te:
> Hi, Pavel,
>
> Sorry, =A0there is a minor issue in the patch. =A0Do you have time to=
 try
> the updated version attached.

I think Yinghai's patch is a better approach (though it needs a changel=
og).

The ACPI NVS space should not be marked as "busy" by the e820 code in
the iomem_resource tree.

It's way too complicated to mess around with registering NVS space and
trying to deal with it specially in APEI.

Bjorn
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
