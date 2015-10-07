From: Prarit Bhargava <prarit@redhat.com>
Subject: Re: [PATCH] ACPICA: AcpiGetSleepTypeData: Failure to find \_Sx should
 not result in a loud warning
Date: Wed, 07 Oct 2015 11:57:27 -0400
Message-ID: <561540E7.30809@redhat.com>
References: <1443720528-14499-1-git-send-email-prarit@redhat.com> <94F2FBAB4432B54E8AACC7DFDE6C92E37D357F6E@ORSMSX112.amr.corp.intel.com> <560DB3A7.2010405@intel.com> <56153A35.4090705@redhat.com> <94F2FBAB4432B54E8AACC7DFDE6C92E37D362FF7@ORSMSX112.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54105 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755104AbbJGP53 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 7 Oct 2015 11:57:29 -0400
In-Reply-To: <94F2FBAB4432B54E8AACC7DFDE6C92E37D362FF7@ORSMSX112.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "devel@acpica.org" <devel@acpica.org>
Cc: "Zheng, Lv" <lv.zheng@intel.com>, Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Box, David E" <david.e.box@intel.com>



On 10/07/2015 11:52 AM, Moore, Robert wrote:
> It would be easy to remove (or partially remove) the warning. Hopefully the calling code will handle AE_NOT_FOUND correctly. 
> 

In the specific case of the \_Sx sleep states the code does handle the
AE_NOT_FOUND correctly.  The issue is solely the warning being displayed when
there should be no warning.

P.
