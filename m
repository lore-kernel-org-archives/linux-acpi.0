From: "R, Durgadoss" <durgadoss.r@intel.com>
Subject: RE: [PATCH] ACPI-Thermal: Make Thermal trip points writeable
Date: Thu, 5 Apr 2012 07:43:28 +0000
Message-ID: <4D68720C2E767A4AA6A8796D42C8EB590CE3FC@BGSMSX101.gar.corp.intel.com>
References: <1327681692-19299-1-git-send-email-durgadoss.r@intel.com>
 <1333605123-29172-1-git-send-email-amit.kachhap@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:53655 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751431Ab2DEHnl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 5 Apr 2012 03:43:41 -0400
In-Reply-To: <1333605123-29172-1-git-send-email-amit.kachhap@linaro.org>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Amit Daniel Kachhap <amit.kachhap@linaro.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, "linaro-dev@lists.linaro.org" <linaro-dev@lists.linaro.org>

Hi Amit,

> -----Original Message-----
> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> owner@vger.kernel.org] On Behalf Of Amit Daniel Kachhap
> Sent: Thursday, April 05, 2012 11:22 AM
> To: R, Durgadoss
> Cc: linux-acpi@vger.kernel.org; lenb@kernel.org; Zhang, Rui;
> amit.kachhap@linaro.org; linaro-dev@lists.linaro.org
> Subject: Re: [PATCH] ACPI-Thermal: Make Thermal trip points writeable
> 
> Hi Durgadoss,
> 
> Instead of making all the trip-points of a thermal zone writeable we should
> only allow non-critical trip points to be writeable.

We are not making all trip points writeable. It is on a per-trip point basis.
The 'flag' variable determines whether a particular trip point is writeable or not.

Thanks,
Durga
