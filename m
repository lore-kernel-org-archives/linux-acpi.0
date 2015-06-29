From: Jiang Liu <jiang.liu@linux.intel.com>
Subject: Re: [Bugfix v3] PCI, ACPI: Fix regressions caused by resource_size_t
 overflow with 32-bit kernel
Date: Mon, 29 Jun 2015 22:28:26 +0800
Message-ID: <5591560A.8080107@linux.intel.com>
References: <20150624094916.GA5696@gmail.com> <1435141065-28536-1-git-send-email-jiang.liu@linux.intel.com> <20150624101843.GA8924@gmail.com> <559107F2.3080701@pr.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:23409 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753347AbbF2O2b (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 29 Jun 2015 10:28:31 -0400
In-Reply-To: <559107F2.3080701@pr.hu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Boszormenyi Zoltan <zboszor@pr.hu>, Ingo Molnar <mingo@kernel.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, "x86 @ kernel . org" <x86@kernel.org>

On 2015/6/29 16:55, Boszormenyi Zoltan wrote:
> 2015-06-24 12:18 keltez=E9ssel, Ingo Molnar =EDrta:
>> * Jiang Liu <jiang.liu@linux.intel.com> wrote:
>>
>> Also note the indentation, that helps readability.
>>
>> Thanks,
>>
>> 	Ingo
>=20
> So, will there be a v4 with a commit message satisfactory to Ingo
> that will be part of 4.0.7/4.1.1 and 4.2?

Hi Zoltan,
	I'm waiting for a few days to see if there will be other
comments, and will send out v4 then.
Thanks!
Gerry
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
