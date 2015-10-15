From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] acpi: set return value to const char for some functions
Date: Wed, 14 Oct 2015 19:14:26 -0700
Message-ID: <1444875266.2718.37.camel@perches.com>
References: <1444849635-14456-1-git-send-email-clabbe.montjoie@gmail.com>
	 <94F2FBAB4432B54E8AACC7DFDE6C92E37D9803BD@ORSMSX112.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <94F2FBAB4432B54E8AACC7DFDE6C92E37D9803BD@ORSMSX112.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: LABBE Corentin <clabbe.montjoie@gmail.com>, "Zheng, Lv" <lv.zheng@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, 2015-10-14 at 20:53 +0000, Moore, Robert wrote:
> In ACPICA, we tend to be very careful concerning the "const" keyword in order to avoid a phenomenon known as "const pollution".
> 
> That is not to say that we won't use const in some limited cases.

Please describe the effects of "const pollution".

Why isn't it useful to update the functions that
don't modify function pointer arguments to const?
