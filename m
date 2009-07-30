From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [Xen-devel] [PATCH][pvops_dom0][2/4] Introduce the external control
 operation interface for domain0 ACPI parser
Date: Thu, 30 Jul 2009 10:23:04 -0700
Message-ID: <4A71D6F8.9040007@goop.org>
References: <4D05DB80B95B23498C72C700BD6C2E0B315D64CC@pdsmsx502.ccr.corp.intel.com> <E87738D94A6AD54789B5B8D1BAEB06CC5C744C68C2@azsmsx503.amr.corp.intel.com> <4D05DB80B95B23498C72C700BD6C2E0B315D65B6@pdsmsx502.ccr.corp.intel.com> <4A707DC1.9070708@goop.org> <4D05DB80B95B23498C72C700BD6C2E0B315D6A67@pdsmsx502.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from claw.goop.org ([74.207.240.146]:60959 "EHLO claw.goop.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751899AbZG3RXF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 30 Jul 2009 13:23:05 -0400
In-Reply-To: <4D05DB80B95B23498C72C700BD6C2E0B315D6A67@pdsmsx502.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Yu, Ke" <ke.yu@intel.com>
Cc: "Brown, Len" <len.brown@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Tian, Kevin" <kevin.tian@intel.com>

On 07/30/09 02:18, Yu, Ke wrote:
> Can you explain what the deeper design problem is?
>   

I don't know.  It may be that ACPI and Xen-style virtualization
fundimentally have designs which can't easily co-exist, and it is
unavoidable.  I'm simply saying there appears to be a problem because
the need to put a Xen-specific hook in a piece of generic code is
generally a symptom of a design problem.

    J
