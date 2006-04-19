From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [RFC] [PATCH] Make ACPI button driver an input device
Date: Wed, 19 Apr 2006 22:04:47 +0200
Message-ID: <20060419200447.GA2459@isilmar.linta.de>
References: <20060419195356.GA24122@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from isilmar.linta.de ([213.239.214.66]:7325 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S1751215AbWDSUEt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 19 Apr 2006 16:04:49 -0400
Content-Disposition: inline
In-Reply-To: <20060419195356.GA24122@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Apr 19, 2006 at 08:53:58PM +0100, Matthew Garrett wrote:
> +++ a/include/linux/input.h	2006-04-19 20:49:18 +0100
> @@ -344,6 +344,7 @@
>  #define KEY_FORWARDMAIL		233
>  #define KEY_SAVE		234
>  #define KEY_DOCUMENTS		235
> +#define KEY_LID			237

What about 236?

	Dominik
